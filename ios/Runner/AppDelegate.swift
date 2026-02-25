import UIKit
import Intents
import Flutter
import PushKit
import CallKit
import AVFoundation
import GoogleMaps
import Foundation
import flutter_callkit_incoming
import StoreKit
import NaturalLanguage
import FirebasePerformance
import Firebase

/// iOS Performance Tracker for Firebase Performance Monitoring
/// Supports multiple concurrent traces with dynamic configuration
class NativePerfTracker {
    static let shared = NativePerfTracker()
    
    private var activeTraces: [String: Trace] = [:]
    private let queue = DispatchQueue(label: "com.uchat.perf_tracker")
    private let tag = "NativePerfTracker"
    
    /// Start a dynamic trace with optional attributes
    /// - Parameters:
    ///   - traceName: Unique identifier for the trace (e.g., "incoming_call_latency_native_ios")
    ///   - attributes: Optional dictionary of custom attributes to attach to the trace
    /// - Returns: The trace name if successful, nil otherwise
    @discardableResult
    func startTrace(traceName: String, attributes: [String: String]? = nil) -> String? {
        return queue.sync {
            NSLog("\(tag): Attempting to start trace: \(traceName)")
            
            // Check if trace already exists
            if activeTraces[traceName] != nil {
                NSLog("\(tag): Trace '\(traceName)' is already active")
                return traceName
            }
            
            // Start Firebase trace
            let trace = Performance.startTrace(name: traceName)
            
            // Add default attributes
            // trace?.setValue("native", forAttribute: "receivingFrom")
            
            // Add app state
            let state = UIApplication.shared.applicationState
            let appState: String
            if state == .background {
                appState = "background"
            } else if state == .active {
                appState = "foreground"
            } else {
                appState = "inactive"
            }
            trace?.setValue(appState, forAttribute: "app_state")
            
            // Add custom attributes if provided
            if let customAttributes = attributes {
                for (key, value) in customAttributes {
                    trace?.setValue(value, forAttribute: key)
                }
            }
            
            queue.async(flags: .barrier) {
                self.activeTraces[traceName] = trace
            }
            
            NSLog("\(tag): Trace started successfully: \(traceName)")
            return traceName
        }
    }
    
    /// Stop a specific trace by name
    /// - Parameter traceName: The identifier of the trace to stop
    /// - Returns: true if trace was stopped successfully, false otherwise
    @discardableResult
    func stopTrace(traceName: String) -> Bool {
        return queue.sync {
            NSLog("\(tag): Attempting to stop trace: \(traceName)")
            
            // Access activeTraces directly since we're already in queue.sync
            guard let trace = activeTraces[traceName] else {
                NSLog("\(tag): Trace '\(traceName)' not found or already stopped")
                return false
            }
            
            // Remove from activeTraces before stopping
            activeTraces.removeValue(forKey: traceName)
            
            // Stop the trace
            trace.stop()
            
            NSLog("\(tag): Trace stopped successfully: \(traceName)")
            return true
        }
    }
    
    /// Add a custom metric to a specific trace
    /// - Parameters:
    ///   - traceName: The identifier of the trace
    ///   - metricName: The name of the metric
    ///   - value: The numeric value of the metric
    /// - Returns: true if metric was added successfully, false otherwise
    @discardableResult
    func addMetric(traceName: String, metricName: String, value: Int64) -> Bool {
        return queue.sync {
            guard let trace = activeTraces[traceName] else {
                NSLog("\(tag): Trace '\(traceName)' not found for metric '\(metricName)'")
                return false
            }
            
            trace.incrementMetric(metricName, by: value)
            NSLog("\(tag): Metric added to trace '\(traceName)': \(metricName)=\(value)")
            return true
        }
    }
    
    /// Add or update an attribute for a specific trace
    /// - Parameters:
    ///   - traceName: The identifier of the trace
    ///   - key: The attribute key
    ///   - value: The attribute value
    /// - Returns: true if attribute was added successfully, false otherwise
    @discardableResult
    func addAttribute(traceName: String, key: String, value: String) -> Bool {
        return queue.sync {
            guard let trace = activeTraces[traceName] else {
                NSLog("\(tag): Trace '\(traceName)' not found for attribute '\(key)'")
                return false
            }
            
            trace.setValue(value, forAttribute: key)
            NSLog("\(tag): Attribute added to trace '\(traceName)': \(key)=\(value)")
            return true
        }
    }
    
    /// Stop all active traces (useful for cleanup)
    /// - Returns: The count of traces stopped
    @discardableResult
    func stopAllTraces() -> Int {
        return queue.sync {
            let count = activeTraces.count
            
            for (traceName, trace) in activeTraces {
                trace.stop()
                NSLog("\(tag): Stopped trace during cleanup: \(traceName)")
            }
            
            // Clear all traces directly since we're already in queue.sync
            activeTraces.removeAll()
            
            NSLog("\(tag): All traces stopped. Count: \(count)")
            return count
        }
    }
    
    /// Get the count of currently active traces
    func getActiveTraceCount() -> Int {
        return queue.sync {
            activeTraces.count
        }
    }
    
    /// Check if a specific trace is active
    /// - Parameter traceName: The identifier of the trace
    /// - Returns: true if the trace is active, false otherwise
    func isTraceActive(traceName: String) -> Bool {
        return queue.sync {
            activeTraces[traceName] != nil
        }
    }
    
    /// Get all active trace names
    /// - Returns: Array of active trace names
    func getActiveTraceNames() -> [String] {
        return queue.sync {
            Array(activeTraces.keys)
        }
    }
    
    // ============ Legacy Methods for Backward Compatibility ============
    
    /// Legacy method - Start incoming call trace
    /// Defaults to 'incoming_call_latency_native_ios' trace name
    func startCallTrace(attributes: [String: String]? = nil) {
        startTrace(
            traceName: "performance_calling_incoming_call_native",
            attributes: attributes
        )
    }
    
    /// Legacy method - Stop incoming call trace
    func stopCallTrace() {
        stopTrace(traceName: "performance_calling_incoming_call_native")
    }

    /// Legacy method - Start decline call to missed call display trace
    /// Defaults to 'decline_until_missed_call_native_ios' trace name
    func startDeclineToMissedCallTrace(attributes: [String: String]? = nil) {
        startTrace(
            traceName: "performance_calling_missed_native",
            attributes: attributes
        )
    }

    /// Legacy method - Stop decline call to missed call display trace
    func stopDeclineToMissedCallTrace() {
        stopTrace(traceName: "performance_calling_missed_native")
    }
}

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var uiChannel: FlutterMethodChannel? = nil;
    private var keyboardHeight: CGFloat = 0.0;

    var channel : FlutterMethodChannel? = nil;
    var googleMapInit : Bool = false;
    
    private var audioSession: AVAudioSession? = nil;
    
    // Track device lock state
    private var isDeviceLocked: Bool = false;
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Reset the badge count on app launch
        application.applicationIconBadgeNumber = 0

        NSLog("[NSLOG] Start application")
        print("[PRINT] Start application")
        
        FirebaseApp.configure()

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        channel = FlutterMethodChannel(name: "social.uchat", binaryMessenger: controller.binaryMessenger)
        uiChannel = FlutterMethodChannel(name: "social.uchat/ui", binaryMessenger: controller.binaryMessenger)
        // Initialize the audio session
        audioSession = AVAudioSession.sharedInstance()
        
        // Add observers for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // NotificationCenter.default.addObserver(self, selector: #selector(audioRouteChanged),  name: AVAudioSession.routeChangeNotification, object: audioSession)
        
        // Add observers for screen lock/unlock notifications
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidLock), name: UIApplication.protectedDataWillBecomeUnavailableNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidUnlock), name: UIApplication.protectedDataDidBecomeAvailableNotification, object: nil)
        
        uiChannel?.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch(call.method) {
            case "getKeyboardHeight":
                self.getKeyboardHeight(result: result)
            default:
                NSLog("method name invalid : \(call.method)")
                result(FlutterMethodNotImplemented)
            }
        })

        voipRegistration()
        channel?.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch(call.method) {
            case "getAudioRouteList":
                // Extract available input port information
                if let inputsList = AVAudioSession.sharedInstance().availableInputs {
                    let inputDataList: [[String: Any]] = inputsList.map { inputPort in
                        return [
                            "portName": inputPort.portName,
                            "portType": inputPort.portType.rawValue
                        ]
                    }
                    
                    // Prepare the response
                    let response: [String: Any] = [
                        "changeReason": "init",
                        "outputs": inputDataList
                    ]

                    // Send the response to Flutter
                    result(response)
                } else {
                    // If no inputs are available, return an empty response
                    let response: [String: Any] = [
                        "changeReason": "init",
                        "outputs": []
                    ]
                    result(response)
                }
            case "getCurrentDeviceRouteOutput":
                if let currentOutputRoute = AVAudioSession.sharedInstance().currentRoute.outputs.first {
                    let outputRouteInfo: [String: Any] = [
                        "portName": currentOutputRoute.portName ?? "",
                        "portType": currentOutputRoute.portType ?? "",
                        "deviceNumber": AVAudioSession.sharedInstance().outputNumberOfChannels ?? 0,
                    ]
                    result(outputRouteInfo)
                } else {
                    result(nil)
                }
            case "isScreenLocked":
                result(self.isDeviceLocked)
            case "getVoipToken":
                self.voipRegistration()
                result(nil)
            case "getImagesFromPasteboard":
                var data = []
                if let images = UIPasteboard.general.images {
                    for image in images {
                        
                        if let dataUTI = UIPasteboard.general.types.first, let uti = UTType(dataUTI) {
                            NSLog("Original Image Type: \(uti.description)")
                        } else {
                            NSLog("Could not determine original image type.")
                        }

                        func logImageOrientation(_ image: UIImage, prefix: String = "") {
                            switch image.imageOrientation {
                            case .up:
                                NSLog("\(prefix)Image Orientation: Up")
                            case .down:
                                NSLog("\(prefix)Image Orientation: Down")
                            case .left:
                                NSLog("\(prefix)Image Orientation: Left")
                            case .right:
                                NSLog("\(prefix)Image Orientation: Right")
                            case .upMirrored:
                                NSLog("\(prefix)Image Orientation: Up Mirrored")
                            case .downMirrored:
                                NSLog("\(prefix)Image Orientation: Down Mirrored")
                            case .leftMirrored:
                                NSLog("\(prefix)Image Orientation: Left Mirrored")
                            case .rightMirrored:
                                NSLog("\(prefix)Image Orientation: Right Mirrored")
                            @unknown default:
                                NSLog("\(prefix)Image Orientation: Unknown")
                            }
                        }
                        
                        logImageOrientation(image, prefix: "Original ")

                        let orientedImage = self.correctImageOrientation(image)
                        
                        logImageOrientation(orientedImage!, prefix: "Adjusted ")
                        
                        if let pngData = orientedImage?.pngData() {
                            NSLog("Converted Image: PNG")
                            data.append(pngData)
                        } else {
                            NSLog("Failed to convert image to PNG.")
                        }
                    }
                } else {
                    NSLog("No images found in UIPasteboard.")
                }
                result(data)
            case "getHasTextWasCopied":
                result(UIPasteboard.general.hasStrings)
            case "getHasImageWasCopied":
                result(UIPasteboard.general.hasImages)
            case "initGoogleMap":
                // try to init google map again if it is not init
                if (!self.googleMapInit) {
                    self.googleMapInit = GMSServices.provideAPIKey(self.getGoogleApiKey())
                }
                result(nil)
            case "checkIOSINStartCallIntent":
                if let activityDictionary = launchOptions?[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any] {
                    // Handle multiple URLs shared in
                    for key in activityDictionary.keys {
                        if let userActivity = activityDictionary[key] as? NSUserActivity {
                            if let handle = userActivity.handle?.getDecryptHandle() {
                                let isVideo = userActivity.isVideo
                                NSLog("userActivity handling : isVideo >> \(String(describing: isVideo))")
                                NSLog("userActivity handling : handle >> \(String(describing: handle))")
                                self.channel?.invokeMethod("iosNativeStartCall", arguments: ["handle": handle["handle"], "isVideo": isVideo, "calledFrom": "MethodCallHandler"])
                            }
                            break
                        }
                    }
                }
                result(nil)
            case "debugClearTransaction":
                // clear all in app purchase transaction. This will probably fix storekit_duplicate_product_object error.
                let pendingTrans = SKPaymentQueue.default().transactions;
                for transaction in pendingTrans {
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
                result(nil)
            case "iosManageSubscription":
                Task { // Use Task to call async code
                  await self.manageSub()
                  result(nil) // Complete the result after async operation
                }
            case "checkPurchasePendingAccDiff":
                self.checkSubscriptionStatus() { originalAccountIdentifier in
                    result(originalAccountIdentifier)
                }
            case "iOSWordSegmentation":
                if let args = call.arguments as? [String: Any],
                   let text = args["text"] as? String,
                   let languageCode = args["language"] as? String,
                   let language = NLLanguage.init(rawValue: languageCode) as? NLLanguage {
                    let tokens = self.wordSegmentation(text, language: language)
                    result(tokens)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for tokenizeText", details: nil))
                }
            // case "startNativeTrace":
            //     NativePerfTracker.shared.startCallTrace()
            //     result(nil)
            // case "stopNativeTrace":
            //     NativePerfTracker.shared.stopCallTrace()
            //     result(nil)
            default:
                NSLog("method name invalid : \(call.method)")
                result(FlutterMethodNotImplemented)
            }
        })
//        uncomment this to use notification with background_downloader
//        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        
        googleMapInit = GMSServices.provideAPIKey(self.getGoogleApiKey())
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
       if let handle = userActivity.handle?.getDecryptHandle() {
           let isVideo = userActivity.isVideo
           NSLog("userActivity handling : isVideo >> \(String(describing: isVideo))")
           NSLog("userActivity handling : handle >> \(String(describing: handle))")
           channel?.invokeMethod("iosNativeStartCall", arguments: ["handle": handle["handle"], "isVideo": isVideo, "calledFrom": "UIUserActivityRestoring"])
       }
       return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    func wordSegmentation(_ text: String, language: NLLanguage) -> [String] {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.setLanguage(language)
        tokenizer.string = text

        // Get the ranges of all the words
        let tokenRanges = tokenizer.tokens(for: text.startIndex..<text.endIndex)

        // Map the ranges to the actual words and return as a list
        return tokenRanges.map { String(text[$0]) }
    }

    
    func checkSubscriptionStatus(completion: @escaping (String?) -> Void) {
        // Step 1: Retrieve the receipt data
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
              let receiptData = try? Data(contentsOf: appStoreReceiptURL) else {
            completion(nil)
            return
        }
        
        let receiptString = receiptData.base64EncodedString()
        completion(receiptString)
    }

//    func promptUserSubscriptionAlert() {
//        // Step 4: Display an alert to the user if they already have an active subscription on another account
//        let alert = UIAlertController(
//            title: "Purchase Pending",
//            message: "You have already subscribed, either here or on another account. Please check back later.",
//            preferredStyle: .alert
//        )
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            topController.present(alert, animated: true, completion: nil)
//        }
//    }


    func manageSub() async {
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            do {
                
                if #available(iOS 17.0, *) {
                    try await AppStore.showManageSubscriptions(in: window, subscriptionGroupID: "21527086") // TODO: Update subscriptionGroupID
                    } else if #available(iOS 15.0, *) {
                        try await AppStore.showManageSubscriptions(in: window)
                    } else {
                      // Fallback for iOS versions older than 15.0
//                      openAppStoreSubscriptionsPage()
                    }
            } catch {
                print(error)
            }
        }
    }
    
    func getGoogleApiKey() -> String {
        let preferences = UserDefaults.standard
        let prefKey = "flutter.googleApiKey"
        if let googleApiKey = preferences.string(forKey: prefKey) {
            return googleApiKey
        }
        return ""
    }
    
    func getAccessToken() -> String? {
        let preferences = UserDefaults.standard
        let prefKey = "flutter.accessToken"
        if let accessToken = preferences.string(forKey: prefKey) {
            return accessToken
        }
        return nil
    }
    
    func getIsTestMode() -> Bool? {
        let preferences = UserDefaults.standard
        let prefKey = "flutter.isTestMode"
        if let isTestMode = preferences.bool(forKey: prefKey) as? Bool {
            return isTestMode
        }
        return nil
    }
    
    func getApiUrl() -> String {
        let preferences = UserDefaults.standard
        let prefKey = "flutter.apiUrl"
        if let apiUrl = preferences.string(forKey: prefKey) {
            return apiUrl
        }
        return ""
    }
    
    func voipRegistration(){
        let voipRegistry : PKPushRegistry = PKPushRegistry(queue:DispatchQueue.main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
    
    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: [])
            
        } catch {
            NSLog("Failed to set audio session category.")
        }
    }

    func correctImageOrientation(_ image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }

        NSLog("Original Image Orientation: \(image.imageOrientation)")

        if image.imageOrientation == .up {
            return image
        }

        var transform = CGAffineTransform.identity

        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: -.pi / 2)
        case .up, .upMirrored:
            break
        @unknown default:
            return nil
        }

        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            return nil
        }

        guard let context = CGContext(
            data: nil,
            width: Int(image.size.width),
            height: Int(image.size.height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: cgImage.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: cgImage.bitmapInfo.rawValue
        ) else {
            return nil
        }

        context.concatenate(transform)

        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }

        let correctedImage = UIImage(cgImage: context.makeImage()!)
        NSLog("Corrected Image Orientation: \(correctedImage.imageOrientation)")

        return correctedImage
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardFrame.height
            sendKeyboardUpdate(height: keyboardHeight, type: "OPEN")
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        // Handle keyboard hiding if necessary
        keyboardHeight = 0.0
        sendKeyboardUpdate(height: keyboardHeight, type: "CLOSE")
    }

    @objc private func getKeyboardHeight(result: FlutterResult) {
       result(Double(keyboardHeight))
    }

    @objc private func deviceDidLock() {
        self.isDeviceLocked = true
    }
    
    @objc private func deviceDidUnlock() {
        self.isDeviceLocked = false
    }
    
    @objc private func sendKeyboardUpdate(height: CGFloat, type: String) {
        let keyboardData: [String: Any] = [
            "height": height,
            "type": type
        ]

        uiChannel?.invokeMethod("keyboardUpdate", arguments:keyboardData)
    }
    
    @objc func audioRouteChanged(notification: Notification) {
        // guard let userInfo = notification.userInfo,
        //       let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
        //       let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
        //     return
        // }

        // // Fetch the current audio route
        // let currentRoute = audioSession?.currentRoute
        // let availableInputs = audioSession?.availableInputs
        
        // var outputData: [String: Any] = [:]
        
        // var outputDataList: [[String: Any]] = []

        // // Extract output port information
        // if let outputsList = availableInputs {
        //     outputDataList = outputsList.map { outputPort in
        //         return [
        //             "portName": outputPort.portName,
        //             "portType": outputPort.portType.rawValue
        //         ]
        //     }
        // }

        // // Extract output port information
        // if let outputPort = currentRoute?.outputs.first {
        //     outputData["portName"] = outputPort.portName
        //     outputData["portType"] = outputPort.portType.rawValue
        // }

        // // Additional handling based on the reason for the change
        // switch reason {
        // case .newDeviceAvailable:
        //     outputData["changeReason"] = "New device available"
        // case .oldDeviceUnavailable:
        //     outputData["changeReason"] = "Old device unavailable"
        // default:
        //     outputData["changeReason"] = "Unknown change"
        // }

        // // Add the change reason to the output data
        // let response: [String: Any] = [
        //     "changeReason": outputData["changeReason"],
        //     "outputs": outputDataList
        // ]

        // // Send the output change data to Flutter
        // channel?.invokeMethod("audioRouteChangedList", arguments: response)
        // // Send the output change data to Flutter
        // channel?.invokeMethod("iosNativeAudioOutputChange", arguments: outputData)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AppDelegate : PKPushRegistryDelegate{
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        // Register VoIP push token
        let parts = pushCredentials.token.map { String(format: "%02.2hhx", $0) }
        let VoIPToken = parts.joined()
        NSLog("did update push credentials with token: \(VoIPToken)")
        channel?.invokeMethod("updateVoipUser", arguments: VoIPToken)
        SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(VoIPToken)
    }

    func ringingApiService(roomId: String, completion: @escaping (String) -> Void) {
        var resultLog = "ringingApiService start"
        if let isTestMode = self.getIsTestMode() as? Bool,
           let userToken = self.getAccessToken() as? String {
            let apiUrlEnv = self.getApiUrl()
            let url = URL(string: "\(apiUrlEnv)v2/room-calls/\(roomId)/ringing")!
            var request = URLRequest(url: url)
            resultLog = "ringingApiService url: \(apiUrlEnv)livekit/\(roomId)/call/ringing, isTestMode: \(isTestMode) and userToken: \(userToken)"
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    resultLog += ", error \(error)"
                    completion(resultLog)
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        resultLog += ", done response with status code \(httpResponse.statusCode)"
                    } else {
                        resultLog += ", response null"
                    }
                    completion(resultLog)
                }
            }
            task.resume()
        }
        
        // Call the completion closure with the result
        completion(resultLog)
    }

    func feedbackRinging(roomId: String) {
        self.ringingApiService(roomId: roomId) { result in
            NSLog("feedbackRinging ringingApiService result: \(result)")
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        NSLog("Incoming Push \(payload.dictionaryPayload)")
        if type == .voIP {
            let customData = payload.dictionaryPayload["custom"] as? [String:Any]
            let apsData = payload.dictionaryPayload["aps"] as? [String:Any]
            let dataAlert = apsData?["alert"] as? [String:Any]
            var dataA = customData?["a"] as? [String:Any]
            let isDirect: Bool = dataA?["roomType"] as! String == "DIRECT"
            let state = UIApplication.shared.applicationState
            if isDirect {
                NativePerfTracker.shared.startCallTrace(
                    attributes: [
                        "roomCallId": dataA?["roomCallId"] as? String ?? "",
                        "roomType": dataA?["roomType"] as? String ?? "",
                        "callType": dataA?["callType"] as? String ?? "",
                    ]
                )
                NSLog("incoming call :: App is on background .... incoming call showing")
                let createdAt = dataA?["createdAt"] as! String;
                NSLog("createdAt is \(createdAt)") // the date format should follow by ==> "2023-01-23T10:40:22Z"
                
                let dateFormatter = DateFormatter() //ISO8601DateFormatter which adds a Z to the end of the date
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date: Date? = dateFormatter.date(from: createdAt) //Local api response createAt format "2023-02-16T13:54:30+07:00", this should handle.
                let calendar = Calendar.current
                //date! force close app if date format is incorrect (local api "2023-02-16T13:54:30")
                //TODO implement data format to support the format to dev.
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date!, to: Date())
                // don't show call noti if call is older than 2 minute
                if (components.year ?? 0 > 0 || components.month ?? 0 > 0 ||
                    components.day ?? 0 > 0 || components.hour ?? 0 > 0 || components.minute ?? 0 > 2) {
                    NSLog("Reject!! Incoming call, the call is older than ~2 minute")
                    // throw "Reject!! Incoming call, the call is older than ~2 minute."
                } else {
                    let uuid = UUID()
                    NSLog("call uuid is \(uuid)")
                    dataA?["callUUID"] = uuid.uuidString
                    let id = dataA?["roomCallId"] as? String ?? uuid.uuidString
                    let liveKitRoomSID = dataA?["liveKitRoomSID"] as? String ?? ""
                    let roomCallId = dataA?["roomCallId"] as? String ?? ""
                    let nameCaller = dataAlert?["title"] as? String ?? ""
                    let avatar = dataA?["imageUrl"] as? String ?? ""
                    let liveKitToken = dataA?["liveKitToken"] as? String ?? ""
                    let imageBlurHash = dataA?["imageBlurhash"] as? String ?? ""
                    let roomId = dataA?["roomId"] as? String ?? ""
                    let handle = "\(roomId),\(roomCallId)"
                    let roomType = dataA?["roomType"] as? String ?? ""
                    let callType = dataA?["callType"] as? String ?? ""
                    let type : Int
                    if (callType == "VIDEO") {
                        type = 1 // Video
                    } else {
                        type = 0 // Voice
                    }
                    
                    let data = flutter_callkit_incoming.Data(id: id, nameCaller: nameCaller, handle: handle, type: type)
                    data.extra = ["liveKitToken": liveKitToken, "roomType": roomType, "callType": callType, "platform": "ios", "roomId": roomId, "liveKitRoomSID": liveKitRoomSID, "roomCallId": roomCallId, "imageBlurHash": imageBlurHash]
                    data.avatar = avatar
                    data.iconName = "appIconWhite"
                    NativePerfTracker.shared.stopCallTrace()
                    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(data, fromPushKit: true)
                    self.feedbackRinging(roomId: roomCallId)
                    //Make sure call completion()
                    
                    // These two variables are used to check the order of incoming call notification and decline call notification.
                    // There are two cases and the flow is like this
                    // 1. Incoming call notification is received before decline call notification. (The correct case)
                    //    - Receive incoming call noti -> Save the roomCallId to incomingRoomCallIds
                    //    - Receive decline call noti -> Remove the roomCallId from incomingRoomCallIds
                    // 2. Decline call notification is received before incoming call notification. (The incorrect case)
                    //    - Receive decline call noti -> Save the roomCallId to declinedRoomCallIds
                    //    - Receive incoming call noti -> Don't show incoming call and remove the roomCallId is in declinedRoomCallIds
                    // When using only declinedRoomCallIds and always add the roomCallId to it, it will cause the list to grow
                    // indefinitely with each call that work correctly. This way will help to keep the list size small.
                    let incomingRoomCallIdKey = "incomingRoomCallIds"
                    let declinedRoomCallIdKey = "declinedRoomCallIds"
                    // Save incoming roomCallIds and decline roomCallIds to check in pushkit incoming whether the call is already declined or not.
                    // To share data between this extension and main app target a UserDefaults with app group suitename is used.
                    // To get same app group name it is set in User-Defined setting in xcode in runner (under the project tab not target) > build setting
                    // Then There is AppGroupIdentifier key value in both info.plist of Notification service extension and main runner which will get the data from User-Defined setting
                    // Then This line is to get value from info.plist
                    let appGroupName = Bundle.main.object(forInfoDictionaryKey: "AppGroupIdentifier") as? String ?? ""
                    let defaults = UserDefaults(suiteName: appGroupName)
                    var declinedRoomCallIds = defaults?.array(forKey: "declinedRoomCallIds") as? [String] ?? []
                    
                    var endCall = false
                    if let index = declinedRoomCallIds.firstIndex(of: roomCallId){
                        // Check whether this call already declined. This will handle the case when incoming call noti is delayed
                        // and decline call noti is received before the incoming call noti.
                        endCall = true
                        declinedRoomCallIds.remove(at: index)
                        defaults?.set(declinedRoomCallIds, forKey: declinedRoomCallIdKey)
                        NativePerfTracker.shared.startDeclineToMissedCallTrace(
                            attributes: [
                                "roomCallId": roomCallId,
                                "roomType": roomType,
                                "callType": callType,
                            ]
                        )
                    } else {
                        // If this is a new incoming call and this notification is received before the decline call noti,
                        // save this value for handling when decline call noti is received to check whether received noti is in correct order or not.
                        var incomingRoomCallIds = defaults?.array(forKey: incomingRoomCallIdKey) as? [String] ?? []
                        incomingRoomCallIds.append(roomCallId)
                        defaults?.set(incomingRoomCallIds, forKey: incomingRoomCallIdKey)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        // Don't know why is this completion have to delay 1.5 seconds
                        completion()
                        if (endCall) {
                            // End call function is used here to close incoming call
                            // This have to delay a little because if this function is called right after showCallkitIncoming, It will not work.
                            NativePerfTracker.shared.stopDeclineToMissedCallTrace()
                            SwiftFlutterCallkitIncomingPlugin.sharedInstance?.endCall(Data(id: roomCallId, nameCaller: "", handle: "", type: 0))
                        }
                    }
                }
            }
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
    }
}

