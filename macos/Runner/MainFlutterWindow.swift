import Cocoa
import FlutterMacOS
import IOKit.ps
import StoreKit
import AppKit

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        
        // Set up the method channel
        let channel = FlutterMethodChannel(
            name: "social.uchat",
            binaryMessenger: flutterViewController.engine.binaryMessenger
        )
        
        channel.setMethodCallHandler({ [weak self]
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch(call.method) {
            case "debugClearTransaction":
                // Clear all in-app purchase transactions
                let pendingTrans = SKPaymentQueue.default().transactions
                for transaction in pendingTrans {
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
                result(nil)
                
            case "macManageSubscription":
                Task { [weak self] in
                    await self?.manageSub()
                    result(nil)
                }
                
            case "checkPurchasePendingAccDiff":
                self?.checkSubscriptionStatus { originalAccountIdentifier in
                    result(originalAccountIdentifier)
                }
                
            default:
                NSLog("method name invalid : \(call.method)")
                result(FlutterMethodNotImplemented)
            }
        })
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        
        super.awakeFromNib()
    }
    

    func manageSub() async {
        if let window = NSApplication.shared.mainWindow as? MainFlutterWindow {
            do {
//                if #available(macOS 17.0, *) {
//                    try await AppStore.showManageSubscriptions(in: window, subscriptionGroupID: "21527086") // TODO: Update subscriptionGroupID
//                } else if #available(macOS 15.0, *) {
//                    try await AppStore.showManageSubscriptions(in: window)
//                } else {
//                    // Open Mac App Store subscriptions page
//                    let subscriptionURL = URL(string: "macappstore://account/subscriptions")!
//                    NSWorkspace.shared.open(subscriptionURL)
//                }
                // Open Mac App Store subscriptions page
                // Check for macOS 12.0 or newer, where StoreKit 2 is supported.
                if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
                    NSWorkspace.shared.open(url)
                }
            } catch {
                print(error)
            }
        }

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
}
