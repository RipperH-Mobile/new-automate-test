//
//  NotificationService.swift
//  OneSignalNotificationServiceExtension
//
//  Created by Panupong on 24/8/2566 BE.
//

import UserNotifications
import OneSignalExtension
import Intents

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
    var receivedRequest: UNNotificationRequest!
    var bestAttemptContent: UNMutableNotificationContent?
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

    // Get cache directory for storing downloaded images
    // Uses same directory structure as Flutter's getApplicationSupportDirectory()
    private func getCacheDirectory() -> URL? {
        let fileManager = FileManager.default

        // Try to use app group shared container first for persistence
        // Uses Application Support directory structure with notification_avatars subfolder
        let appGroupName = Bundle.main.object(forInfoDictionaryKey: "AppGroupIdentifier") as? String ?? ""
        if !appGroupName.isEmpty,
           let sharedContainer = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupName) {
            let cacheDir = sharedContainer.appendingPathComponent("Library/Application Support/notification_avatars")

            // Create directory if it doesn't exist (withIntermediateDirectories handles nested path)
            if !fileManager.fileExists(atPath: cacheDir.path) {
                try? fileManager.createDirectory(at: cacheDir, withIntermediateDirectories: true, attributes: nil)
            }

            return cacheDir
        }

        // Fallback to extension's Application Support directory if app group not available
        if let appSupportDir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let cacheDir = appSupportDir.appendingPathComponent("notification_avatars")

            // Create directory if it doesn't exist
            if !fileManager.fileExists(atPath: cacheDir.path) {
                try? fileManager.createDirectory(at: cacheDir, withIntermediateDirectories: true, attributes: nil)
            }

            return cacheDir
        }

        // Final fallback to temporary directory
        return fileManager.temporaryDirectory
    }

    // Generate cache filename from URL pattern
    // Example: https://cdn.dev.v2.uchat.social/account-avatar/68f07dcf63576a94c10c31a0_d1ad86a2-6e54-45dd-be9c-5d04459211c2.png
    // Result: account-avatar-68f07dcf63576a94c10c31a0_d1ad86a2-6e54-45dd-be9c-5d04459211c2.png
    private func generateCacheFilename(from url: URL) -> String {
        let pathComponents = url.pathComponents.filter { $0 != "/" }

        // If we have at least 2 components (path/filename), combine them
        if pathComponents.count >= 2 {
            let pathPrefix = pathComponents[pathComponents.count - 2] // e.g., "account-avatar"
            let filename = pathComponents[pathComponents.count - 1]   // e.g., "68f07dcf63576a94c10c31a0_d1ad86a2-6e54-45dd-be9c-5d04459211c2.png"
            return "\(pathPrefix)-\(filename)"
        }

        // Fallback to just the filename if path structure is different
        let filename = url.lastPathComponent
        return filename.isEmpty ? "avatar_\(UUID().uuidString).jpg" : filename
    }

    // Helper method to download image from remote URL with caching support
    // INImage requires local file URLs, not remote URLs, especially on iOS 16+
    private func downloadImage(from url: URL, completion: @escaping (URL?) -> Void) {
        guard let cacheDirectory = getCacheDirectory() else {
            print("Failed to get cache directory")
            completion(nil)
            return
        }

        // Generate cache filename
        let cacheFilename = generateCacheFilename(from: url)
        let cachedFileURL = cacheDirectory.appendingPathComponent(cacheFilename)

        // Check if cached file exists
        if FileManager.default.fileExists(atPath: cachedFileURL.path) {
            print("Cache HIT: Using cached image at \(cachedFileURL.path)")
            completion(cachedFileURL)
            return
        }

        print("Cache MISS: Downloading image from \(url)")

        // Download image if not cached
        let task = URLSession.shared.downloadTask(with: url) { [weak self] localURL, response, error in
            guard let localURL = localURL, error == nil else {
                print("Failed to download image from \(url): \(error?.localizedDescription ?? "unknown error")")
                completion(nil)
                return
            }

            let fileManager = FileManager.default

            do {
                // Remove existing file if present (shouldn't happen, but safe to check)
                if fileManager.fileExists(atPath: cachedFileURL.path) {
                    try fileManager.removeItem(at: cachedFileURL)
                }

                // Move downloaded file to cache location
                try fileManager.moveItem(at: localURL, to: cachedFileURL)
                print("Successfully cached image to: \(cachedFileURL.path)")
                completion(cachedFileURL)
            } catch {
                print("Failed to save image to cache directory: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }

    // Helper method to setup communication notification with sender avatar
    // Requires iOS 15.0+ for INPerson and INSendMessageIntent APIs
    @available(iOS 15.0, *)
    private func setupCommunicationNotification(
        request: UNNotificationRequest,
        customData: Dictionary<String, Any>,
        senderAvatarLocalURL: URL?
    ) {
        let senderAccountId = customData["senderAccountId"] as! String
        let senderName = request.content.title
        let roomId = customData["roomId"] as! String

        var senderPersonNameComponents = PersonNameComponents()
        senderPersonNameComponents.nickname = senderName

        // Create INImage from local file URL (or nil if download failed)
        var senderAvatar: INImage? = nil
        if let localURL = senderAvatarLocalURL {
            senderAvatar = INImage(url: localURL)
        }

        let senderPersonHandle = INPersonHandle(value: senderAccountId, type: .unknown)
        let senderPerson = INPerson(
            personHandle: senderPersonHandle,
            nameComponents: senderPersonNameComponents,
            displayName: senderName,
            image: senderAvatar,
            contactIdentifier: nil,
            customIdentifier: nil,
            isMe: false,
            suggestionType: .none
        )

        let meAccountId = customData["accountId"] as! String
        let mePersonHandle = INPersonHandle(value: meAccountId, type: .unknown)
        let mePerson = INPerson(
            personHandle: mePersonHandle,
            nameComponents: nil,
            displayName: nil,
            image: nil,
            contactIdentifier: nil,
            customIdentifier: nil,
            isMe: true,
            suggestionType: .none
        )

        var speakable = INSpeakableString(spokenPhrase: roomId)
        if (request.content.subtitle != nil) {
            speakable = INSpeakableString(spokenPhrase: request.content.subtitle)
        }

        let intent = INSendMessageIntent(
           recipients: [mePerson, senderPerson],
           outgoingMessageType: .outgoingMessageText,
           content: request.content.body,
           speakableGroupName: speakable,
           conversationIdentifier: roomId,
           serviceName: nil,
           sender: senderPerson,
           attachments: nil
        )

        if let avatar = senderAvatar {
            if (request.content.subtitle != nil) {
                intent.setImage(avatar, forParameterNamed: \.speakableGroupName)
            } else {
                intent.setImage(avatar, forParameterNamed: \.sender)
            }
        }

        let interaction = INInteraction(intent: intent, response: nil)
        interaction.direction = .incoming
        interaction.donate(completion: nil)

        do {
            let content = try request.content.updating(from: intent) as! UNMutableNotificationContent
            self.bestAttemptContent = (content.mutableCopy() as? UNMutableNotificationContent)
        } catch {
            print("Failed to update notification content with intent: \(error.localizedDescription)")
        }
    }

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        print("🚨🚨🚨 EXTENSION START 🚨🚨🚨")
        
        self.receivedRequest = request
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if #available(iOS 15.0, *) {
            // Debug: Log the entire userInfo
            print("🔍 [NotificationService] Full userInfo: \(request.content.userInfo)")
            
            let customInfoData = request.content.userInfo["custom"] as? Dictionary<String, Any>

            // Debug: Log customInfoData
            if let customInfo = customInfoData {
                print("✅ [NotificationService] customInfoData exists: \(customInfo)")
            } else {
                print("❌ [NotificationService] customInfoData is nil")
            }

            if customInfoData != nil {
                let customData = customInfoData!["a"] as? Dictionary<String, Any>

                // Debug: Log customData
                if let custom = customData {
                    print("✅ [NotificationService] customData exists: \(custom)")
                    if let type = custom["type"] as? String {
                        print("📋 [NotificationService] Notification type: \(type)")
                    }
                } else {
                    print("❌ [NotificationService] customData is nil")
                }

                if customData != nil {
                    if (customData?["type"] as! String == "DECLINE_CALL_NOTIFICATION") {
                        // Save incoming roomCallIds and decline roomCallIds to check in pushkit incoming whether the call is already declined or not.
                        // To share data between this extension and main app target a UserDefaults with app group suitename is used.
                        // To get same app group name it is set in User-Defined setting in xcode in runner (under the project tab not target) > build setting
                        // Then There is AppGroupIdentifier key value in both info.plist of Notification service extension and main runner which will get the data from User-Defined setting
                        // Then This line is to get value from info.plist
                        let appGroupName = Bundle.main.object(forInfoDictionaryKey: "AppGroupIdentifier") as? String ?? ""
                        let defaults = UserDefaults(suiteName: appGroupName)
                        let roomCallId: String = customData!["roomCallId"] as! String
                        var incomingRoomCallIds = defaults?.array(forKey: incomingRoomCallIdKey) as? [String] ?? []
                        if let index = incomingRoomCallIds.firstIndex(of: roomCallId){
                            // If incoming call noti is received before decline call noti, This is the correct case.
                            // Do nothing and remove the roomCallId from incomingRoomCallIds.
                            incomingRoomCallIds.remove(at: index)
                            defaults?.set(incomingRoomCallIds, forKey: incomingRoomCallIdKey)
                        } else {
                            // If incoming call noti is received after decline call noti, This is the incorrect case.
                            // Save the roomCallId to declinedRoomCallIds for handling when incoming call noti is received.
                            var declinedRoomCallIds = defaults?.array(forKey: declinedRoomCallIdKey) as? [String] ?? []
                            if (!declinedRoomCallIds.contains(roomCallId) && customData?["anotherSession"] == nil) {
                                declinedRoomCallIds.append(roomCallId)
                            }
                            defaults?.set(declinedRoomCallIds, forKey: declinedRoomCallIdKey)
                        }
                    }
                    
                    let senderAvatarUrl = customData!["senderAvatarUrl"] as? String

                    if senderAvatarUrl != nil, let avatarURL = URL(string: senderAvatarUrl!) {
                        // Download image asynchronously before creating INImage
                        // INImage requires local file URLs, not remote URLs (especially on iOS 16+)
                        downloadImage(from: avatarURL) { [weak self] localImageURL in
                            guard let self = self else { return }

                            // Setup communication notification with the downloaded image (or nil if download failed)
                            self.setupCommunicationNotification(
                                request: request,
                                customData: customData!,
                                senderAvatarLocalURL: localImageURL
                            )

                            // Complete notification processing
                            if let bestAttemptContent = self.bestAttemptContent {
                                OneSignalExtension.didReceiveNotificationExtensionRequest(
                                    self.receivedRequest,
                                    with: bestAttemptContent,
                                    withContentHandler: self.contentHandler
                                )
                            }
                        }
                        // Return early to prevent duplicate contentHandler call
                        return
                    }
                }
            }
        }
        
        
        if let bestAttemptContent = bestAttemptContent {
            /* DEBUGGING: Uncomment the 2 lines below to check this extension is executing
                          Note, this extension only runs when mutable-content is set
                          Setting an attachment or action buttons automatically adds this */
            // bestAttemptContent.body = "[Modified] " + bestAttemptContent.body

            // Modify the notification content here...
            // bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            // contentHandler(bestAttemptContent)
            
            OneSignalExtension.didReceiveNotificationExtensionRequest(self.receivedRequest, with: bestAttemptContent, withContentHandler: self.contentHandler)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            OneSignalExtension.serviceExtensionTimeWillExpireRequest(self.receivedRequest, with: self.bestAttemptContent)
            contentHandler(bestAttemptContent)
        }
    }

}
