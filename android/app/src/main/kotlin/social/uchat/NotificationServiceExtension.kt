package social.uchat

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.PowerManager
import android.util.Log
import androidx.annotation.Keep
import androidx.core.app.NotificationCompat
import com.hiennv.flutter_callkit_incoming.Data
import com.hiennv.flutter_callkit_incoming.FlutterCallkitIncomingPlugin
import com.onesignal.notifications.INotificationReceivedEvent
import com.onesignal.notifications.INotificationServiceExtension
import org.json.JSONException
import java.io.BufferedReader
import java.io.IOException
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.Locale
import java.util.TimeZone

// https://github.com/OneSignal/OneSignal-Android-SDK/issues/2044
@Keep
class NotificationServiceExtension : INotificationServiceExtension {

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
    private val declinedRoomCallIds: MutableList<String> = mutableListOf()
    private val incomingRoomCallIds: MutableList<String> = mutableListOf()

    companion object {
        fun isAppInBackground(notificationContext: Context): Boolean {
            val activityManager =
                notificationContext.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val appProcesses =
                activityManager.runningAppProcesses ?: return false

            for (appProcess in appProcesses) {
                if (appProcess.processName == notificationContext.packageName) {
                    return appProcess.importance != ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND
                }
            }
            return false
        }

        fun postRingingApi(
            endpoint: String,
            userToken: String,
            jsonPayload: String
        ) {
            try {
                val bufferedReader =
                    getRequestBufferedReader(endpoint, userToken)
                val response = StringBuilder()
                var inputLine: String?

                while (bufferedReader.readLine()
                        .also { inputLine = it } != null
                ) {
                    response.append(inputLine)
                }
                bufferedReader.close()

                // print response
                Log.d("native", response.toString())
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }

        @Throws(IOException::class)
        private fun getRequestBufferedReader(
            endpoint: String,
            userToken: String
        ): BufferedReader {
            val url = URL(endpoint)
            val connection = url.openConnection() as HttpURLConnection
            connection.requestMethod = "POST"
            connection.setRequestProperty("Content-Type", "application/json")
            connection.setRequestProperty("Authorization", "Bearer $userToken")

            // send POST request
            connection.doOutput = true
            // connection.outputStream.write(jsonPayload.toByteArray(Charsets.UTF_8))

            // read response
            return BufferedReader(InputStreamReader(connection.inputStream))
        }
    }

    override fun onNotificationReceived(event: INotificationReceivedEvent) {
        val notification = event.notification

        val data = notification.additionalData
        Log.i("native", "Received Notification Data: $data")
        Log.i("native", "Notification Priority: ${notification.priority}")

        val dialogIntent = Intent("android.intent.category.LAUNCHER")
        dialogIntent.setClassName("social.uchat", "social.uchat.MainActivity")
        dialogIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        dialogIntent.addFlags(Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT)

        val context = event.context

        notification.setExtender { builder ->
            builder.priority = NotificationCompat.PRIORITY_MAX

            return@setExtender builder

        }

        val bundle = Bundle()
        val type = data?.optString("type")
        Log.d("native", "type is $type")
        bundle.putString("type", type)

        if (type == "DECLINE_CALL_NOTIFICATION") {
            NativePerfTracker.startDeclineUntilMissedCall(
                mapOf(
                    "roomCallId" to (data.getString("roomCallId") ?: ""),
                    "roomType" to (data.getString("roomType") ?: ""),
                    "callType" to (data.getString("callType") ?: "")
                )
            )
            // Save the roomCallId to declinedRoomCallIds for checking whether call is already decline when
            // receive incoming call notification.
            val callOnSessionKeyId = data.getString("callOnSessionKeyId")
            val sharedPref = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            val currentCallSessionId =
                sharedPref.getString("flutter.currentCallSessionId", "")
            if (currentCallSessionId == callOnSessionKeyId) {
                Log.d(
                    "native",
                    "currentCallSessionId == callOnSessionKeyId, $callOnSessionKeyId - don't decline call."
                )
                event.preventDefault()
                return
            }
        }

        if (type == "DECLINE_CALL_NOTIFICATION" || type == "CALL_NOTIFICATION") {
            try {
                FlutterCallkitIncomingPlugin.Companion.initSharedInstance(
                    context.applicationContext,
                    null
                )
            } catch (e: Exception) {
                FlutterCallkitIncomingPlugin.Companion.initSharedInstance(
                    context,
                    null
                )
            }
        }

        try {
            if (type == "DECLINE_CALL_NOTIFICATION" || type == "CALL_NOTIFICATION") {
                val powerManager =
                    context.getSystemService(Context.POWER_SERVICE) as PowerManager
                val wl = powerManager.newWakeLock(
                    PowerManager.FULL_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP or PowerManager.ON_AFTER_RELEASE,
                    "UChat_Callkit:FORCE_PowerManager"
                )
                wl.acquire(10000)
            }

            if (type == "DECLINE_CALL_NOTIFICATION") {
                // Save the roomCallId to declinedRoomCallIds for checking whether call is already decline when
                // receive incoming call notification.
                if (!data.getString("roomCallId").isNullOrEmpty()) {
                    if (incomingRoomCallIds.contains(data.getString("roomCallId"))) {
                        // If incoming call noti is received before decline call noti, This is the correct case.
                        // Do nothing and remove the roomCallId from incomingRoomCallIds.
                        incomingRoomCallIds.remove(data.getString("roomCallId"))
                    } else {
                        // If incoming call noti is received after decline call noti, This is the incorrect case.
                        // Save the roomCallId to declinedRoomCallIds for handling when incoming call noti is received.
                        declinedRoomCallIds.add(data.getString("roomCallId"))
                    }
                }
                val callOnSessionKeyId = data.getString("callOnSessionKeyId")
                Log.d("native", "callOnSessionKeyId is $callOnSessionKeyId")
                bundle.putString("callOnSessionKeyId", callOnSessionKeyId)
                Log.d(
                    "native",
                    "notification type is DECLINE_CALL_NOTIFICATION"
                )

                val endCallData = Data()
                val extra = HashMap<String, Any?>()
                extra["roomCallId"] = data.getString("roomCallId")!!
                NativePerfTracker.stopDeclineUntilMissedCall()
                FlutterCallkitIncomingPlugin.Companion.getInstance()
                    ?.endCall(endCallData)
                event.preventDefault()
                return
            } else if (type == "CALL_NOTIFICATION") {
                var liveKitRoomSID: String? = null
                try {
                    liveKitRoomSID = data.getString("liveKitRoomSID")
                    Log.d("native", "liveKitRoomSID is $liveKitRoomSID")
                    bundle.putString("liveKitRoomSID", liveKitRoomSID)
                } catch (e: JSONException) {
                    Log.d("native", "get liveKitRoomSID failed")
                }

                var callType: String? = null
                try {
                    callType = data.getString("callType")
                    Log.d("native", "callType is $callType")
                    bundle.putString("callType", callType)
                } catch (e: JSONException) {
                    Log.d("native", "get callType failed")
                }

                var title: String? = null
                try {
                    title = data.getString("title")
                    Log.d("native", "title is $title")
                    bundle.putString("title", title)
                } catch (e: JSONException) {
                    Log.d("native", "get title failed")
                }

                var roomCallId: String? = null
                try {
                    roomCallId = data.getString("roomCallId")
                    Log.d("native", "roomCallId is $roomCallId")
                    bundle.putString("roomCallId", roomCallId)
                } catch (e: JSONException) {
                    Log.d("native", "get roomCallId failed")
                }
                if (roomCallId != null) {
                    if (declinedRoomCallIds.contains(roomCallId)) {
                        // Check whether this call already declined. This will handle the case when incoming call noti is delayed
                        // and decline call noti is received before the incoming call noti.
                        Log.d(
                            "native",
                            "This roomCallId is already declined - don't start call activity"
                        )
                        declinedRoomCallIds.remove(roomCallId)
                        // This will prevent the incoming call from displaying.
                        event.preventDefault()
                        return
                    } else {
                        // If this is a new incoming call and this notification is received before the decline call noti,
                        // save this value for handling when decline call noti is received to check whether received noti
                        // is in correct order or not.
                        incomingRoomCallIds.add(roomCallId)
                    }
                }

                var imageBlurHash: String? = null
                try {
                    imageBlurHash = data.getString("imageBlurhash")
                    Log.d("native", "imageBlurHash is $imageBlurHash")
                    bundle.putString("imageBlurHash", imageBlurHash)
                } catch (e: JSONException) {
                    Log.d("native", "get imageBlurhash failed")
                }

                var roomId: String? = null
                try {
                    roomId = data.getString("roomId")
                    Log.d("native", "roomId is $roomId")
                    bundle.putString("roomId", roomId)
                } catch (e: JSONException) {
                    Log.d("native", "get roomId failed")
                }

                var createdAt: String? = null
                try {
                    createdAt = data.getString("createdAt")
                    Log.d("native", "createdAt is $createdAt")
                    bundle.putString("createdAt", createdAt)
                } catch (e: JSONException) {
                    Log.d("native", "get createdAt failed")
                }

                var roomType: String? = null
                try {
                    roomType = data.getString("roomType")
                    Log.d("native", "roomType is $roomType")
                    bundle.putString("roomType", roomType)
                } catch (e: JSONException) {
                    Log.d("native", "get roomType failed")
                }

                var imageUrl: String? = null
                try {
                    imageUrl = data.getString("imageUrl")
                    Log.d("native", "imageUrl is $imageUrl")
                    bundle.putString("imageUrl", imageUrl)
                } catch (e: JSONException) {
                    Log.d("native", "get imageUrl failed")
                }

                var allowCallKit: Boolean? = null
                try {
                    allowCallKit = data.getBoolean("allowCallKit")
                    Log.d("native", "allowCallKit is $allowCallKit")
                    bundle.putBoolean("allowCallKit", allowCallKit)
                } catch (e: JSONException) {
                    Log.d("native", "get allowCallKit failed")
                }

                try {
                    val dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    val currentLocale = Locale.forLanguageTag("TH")
                    val df = SimpleDateFormat(dateFormat, currentLocale)
                    df.timeZone = TimeZone.getTimeZone("GMT")

                    val createdAtDate = df.parse(createdAt!!)
                    val notiTime = createdAtDate!!.time
                    val currentTime = System.currentTimeMillis()

                    if (currentTime - notiTime > 60000) {
                        Log.d(
                            "native",
                            "noti create time is older than 1 minute"
                        )
                        event.preventDefault()
                        return
                    }

                    if (roomType == "GROUP" || allowCallKit == false) {
                        Log.d(
                            "native",
                            "roomType is GROUP - don't start call activity"
                        )
                        event.notification.display()
                        return
                    }

                    if (isAppInBackground(context)) {
                        NativePerfTracker.startCallTrace(
                            mapOf(
                                "roomCallId" to (roomCallId ?: ""),
                                "roomType" to (roomType ?: ""),
                                "callType" to (callType ?: "")
                            )
                        )
                        Log.d("native", "incoming call start...")
                        val incomingCallData = Data()

                        val extra = HashMap<String, Any?>()
                        extra["roomCallId"] = roomCallId!!
                        extra["imageBlurHash"] = imageBlurHash!!
                        extra["roomType"] = roomType!!
                        extra["callType"] = callType!!
                        extra["roomId"] = roomId!!
                        extra["imageUrl"] = imageUrl!!
                        extra["liveKitRoomSID"] = liveKitRoomSID!!

                        val sharedPref = context.getSharedPreferences(
                            "FlutterSharedPreferences",
                            Context.MODE_PRIVATE
                        )
                        val userToken =
                            sharedPref.getString("flutter.accessToken", "-")

                        if (!userToken.isNullOrEmpty() && userToken != "-") {
                            val isTestMode = false
                            val apiUrlEnv =
                                sharedPref.getString("flutter.apiUrl", "-")
                                    ?.removeSuffix("/")
                            val endpoint =
                                "$apiUrlEnv/v2/room-calls/$roomCallId/ringing"
                            val cancelEndpoint =
                                "$apiUrlEnv/v2/room-calls/$roomCallId/decline"
                            val jsonPayload = "" // no body request
                            postRingingApi(endpoint, userToken, jsonPayload)
                            extra["userToken"] = userToken
                            extra["cancelEndpoint"] = cancelEndpoint
                        }

                        incomingCallData.appName = "UChat"
                        incomingCallData.nameCaller = title!!
                        incomingCallData.type =
                            if (callType == "VIDEO") 1 else 0
                        incomingCallData.avatar = imageUrl
                        incomingCallData.isCustomNotification = true
                        incomingCallData.extra = extra

                        val uiHandler = Handler(Looper.getMainLooper())
                        uiHandler.postDelayed({
                            NativePerfTracker.stopCallTrace()
                            FlutterCallkitIncomingPlugin.Companion.getInstance()
                                ?.showIncomingNotification(incomingCallData)
                        }, 1000)
                    }

                    event.preventDefault()
                    return
                } catch (e: ParseException) {
                    Log.e("native", "Error ${e.message}")
                    event.preventDefault()
                    return
                }
            }
        } catch (e: JSONException) {
            e.printStackTrace()
            event.preventDefault()
            return
        } catch (e: ConcurrentModificationException) {
            e.printStackTrace()
            event.preventDefault()
            return
        }

        notification.display()
        // Always show the notification to trigger the foreground listener.
        // Then, if the app is in the foreground, hide the system notification
        // as the display is handled within the app instead.
        if (!isAppInBackground(context)) {
            event.preventDefault()
        }
    }
}