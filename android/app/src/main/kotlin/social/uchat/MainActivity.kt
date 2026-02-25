package social.uchat

//noinspection SuspiciousImport
import android.R
import android.content.Intent
import android.graphics.Rect
import android.media.AudioDeviceInfo
import android.media.AudioManager
import android.media.AudioManager.*
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import android.view.ViewTreeObserver
import android.view.WindowInsets
import android.widget.FrameLayout
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.Locale
import java.text.BreakIterator

class MainActivity : FlutterFragmentActivity() {
    private val channel = "social.uchat"
    
    private val audioManager: AudioManager by lazy {
        getSystemService(AUDIO_SERVICE) as AudioManager
    }

    private val uiChannel = "social.uchat/ui"
    private lateinit var uiPlatform: MethodChannel

    private val eventChannelName = "social.uchat.callEventChannel";

    private val intentData: HashMap<String, String> = HashMap()

    private lateinit var powerManager: PowerManager
    private lateinit var wakeLock: PowerManager.WakeLock
    private var field = 0x00000020

    private var keyboardHeight: Double = 0.0
    private var isKeyboardVisible: Boolean = false

    companion object {
        @JvmField
        var eventChannel: EventChannel? = null
        var eventSink: EventChannel.EventSink? = null
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        eventChannel =
            EventChannel(flutterEngine.dartExecutor, eventChannelName);
        eventChannel?.setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(p0: Any?, sink: EventChannel.EventSink) {
                    eventSink = sink;
                }

                override fun onCancel(p0: Any) {
                    eventSink = null;
                }
            }
        )

        val platform =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
        platform.setMethodCallHandler { methodCall, result ->
            when (methodCall.method) {
                "ping" -> {
                    Log.d("native", "pong")
                    result.success("pong")
                }

                "startProximitySensor" -> {
                    startProximitySensor()
                }

                "stopProximitySensor" -> {
                    stopProximitySensor()
                }

                "enableScreenWakeLock" -> {
                    enableScreenWakeLock()
                    result.success(true)
                }

                "disableScreenWakeLock" -> {
                    disableScreenWakeLock()
                    result.success(true)
                }

                "isScreenWakeLockHeld" -> {
                    val isHeld = (window.attributes.flags and android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) != 0
                    result.success(isHeld)
                }

                "endNativeCall" -> {
                    val uuid = methodCall.argument<String>("uuid")
                    Log.d(
                        "native",
                        "setMethodCallHandler rev endNativeCall... end call uuid $uuid"
                    )
                }

                "getIntentData" -> {
                    Log.d(
                        "native",
                        "getIntentData is called from MainActivity.kt"
                    )
                    result.success(intentData)
                    this.intentData.clear()
                }

                "requestDisplayOverPermission" -> {
                    if (!Settings.canDrawOverlays(this)) {
                        Log.d(
                            "native",
                            "display over other apps not granted. requesting permission"
                        )

                        val intent = Intent(
                            Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                            Uri.parse("package:$packageName")
                        )
                        this.startActivityForResult(intent, 0)
                    } else {
                        Log.d("native", "display over other apps is granted")
                    }
                }

                "isDisplayOverPermissionGranted" -> {
                    val granted = Settings.canDrawOverlays(this)
                    Log.d(
                        "native",
                        "isDisplayOverPermissionGranted is $granted"
                    )
                    result.success(granted)
                }

                "androidCallModeEarpiece" -> {
                    setAudioModeEarpiece()
                    result.success(true)
                }

                "androidCallModeSpeaker" -> {
                    setAudioModeSpeaker()
                    result.success(true)
                }

                "androidCallModeBluetooth" -> {
                    setAudioModeBluetooth()
                    result.success(true)
                }

                "androidWordSegmentation" -> {
                    val text = methodCall.argument<String>("text")
                    val localeString =
                        methodCall.argument<String>("locale") ?: "th-TH"
                    val localeParts = localeString.split("-")

                    val locale = if (localeParts.size >= 2) {
                        Locale(localeParts[0], localeParts[1])
                    } else {
                        Locale(localeParts[0])
                    }

                    val words = wordSegmentation(text ?: "", locale)
                    result.success(words)
                }
                
                "isScreenLocked" -> {
                    val isLocked = isScreenLocked()
                    result.success(isLocked)
                }

                else -> result.notImplemented()
            }
        }

        uiPlatform =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, uiChannel)
        uiPlatform.setMethodCallHandler { call, result ->
            if (call.method == "getKeyboardHeight") {
                result.success(keyboardHeight)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onStart() {
        super.onStart()
        initialCallForegroundIntent()
        initialWakeLockProximity()
        observeKeyboardHeight()
    }

    private fun observeKeyboardHeight() {
        val rootView = findViewById<FrameLayout>(R.id.content)
        rootView.viewTreeObserver.addOnGlobalLayoutListener(ViewTreeObserver.OnGlobalLayoutListener {
            val rect = Rect()
            rootView.getWindowVisibleDisplayFrame(rect)

            val windowInsets = rootView.rootWindowInsets
            var navigationBarHeight = 0
            if (Build.VERSION.SDK_INT < 35) {
                navigationBarHeight =
                    windowInsets?.getInsets(WindowInsets.Type.navigationBars())?.bottom
                        ?: 0
            }

            val screenHeight = rootView.rootView.height
            val keypadHeight = screenHeight - rect.bottom - navigationBarHeight

            val resultObject = HashMap<String, Any>()
            // 0.15 ratio to distinguish between keyboard and other UI elements
            if (keypadHeight > 0) {
                // For Android, the keyboard height is returned in pixels, so we need to convert it to dp.
                // It's work for Flutter, because Flutter uses dp for dimensions.
                keyboardHeight =
                    keypadHeight.toDouble() / this.resources.displayMetrics.density
                if (!isKeyboardVisible) {
                    isKeyboardVisible = true
                    resultObject.put("type", "OPEN")
                }
            } else {
                keyboardHeight = 0.0
                if (isKeyboardVisible) {
                    isKeyboardVisible = false
                    resultObject.put("type", "CLOSE")
                }
            }

            // Send the updated keyboard height to Flutter
            resultObject.put("height", keyboardHeight)

            uiPlatform.invokeMethod("keyboardUpdate", resultObject)
        })
    }

    // TOOD: Maybe use with near future. :)
    private fun initialCallForegroundIntent() {
        val intent = this.getIntent()
        val action = intent.action
        val data = intent.getBundleExtra("EXTRA_CALLKIT_CALL_DATA")
        val extraCallkitData =
            data?.getSerializable("EXTRA_CALLKIT_EXTRA") as HashMap<*, *>?
        if (action != null && extraCallkitData != null) {
            val liveKitToken = extraCallkitData?.get("liveKitToken")
            val roomCallId = extraCallkitData?.get("roomCallId")
            val roomType = extraCallkitData?.get("roomType")
            val callType = extraCallkitData?.get("callType")
            val roomId = extraCallkitData?.get("roomId")
            val imageUrl = extraCallkitData?.get("imageUrl")

            Log.d(
                "native", "onStart logger !!! action:  $action,, and " +
                        "\ndata: $data\n" +
                        "liveKitToken: $liveKitToken,\n" +
                        "roomType: $roomType,\n" +
                        "callType: $callType,\n" +
                        "roomId: $roomId,\n" +
                        "title: $title,\n" +
                        "roomCallId: $roomCallId,\n" +
                        "imageUrl: $imageUrl,\n"
            )

            this.intentData["action"] = action
            this.intentData["title"] =
                data?.getString("EXTRA_CALLKIT_NAME_CALLER") ?: ""
            this.intentData["liveKitToken"] = (liveKitToken ?: "").toString()
            this.intentData["roomCallId"] = (roomCallId ?: "").toString()
            this.intentData["roomType"] = (roomType ?: "").toString()
            this.intentData["callType"] = (callType ?: "").toString()
            this.intentData["roomId"] = (roomId ?: "").toString()
            this.intentData["imageUrl"] = (imageUrl ?: "").toString()
        }
    }

    private fun initialWakeLockProximity() {
        try {
            // Yeah, this is hidden field.
            field =
                PowerManager::class.java.javaClass.getField("PROXIMITY_SCREEN_OFF_WAKE_LOCK")
                    .getInt(null)
        } catch (ignored: Throwable) {
        }

        powerManager = getSystemService(POWER_SERVICE) as PowerManager
        wakeLock = powerManager.newWakeLock(field, localClassName)
    }

    private fun startProximitySensor() {
        // Object is near the proximity sensor, turn off the screen
        if (!wakeLock.isHeld()) {
            wakeLock.acquire();
        }
    }

    private fun stopProximitySensor() {
        // Object is far from the proximity sensor, release the wake lock
        if (wakeLock.isHeld()) {
            wakeLock.release();
        }
    }

    private fun enableScreenWakeLock() {
        // Prevent screen from auto locking
        runOnUiThread {
            window.addFlags(android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
        Log.d("native", "Screen wake lock enabled - screen will not auto lock")
    }

    private fun disableScreenWakeLock() {
        // Allow screen to auto lock normally
        runOnUiThread {
            window.clearFlags(android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
        Log.d("native", "Screen wake lock disabled - screen can auto lock normally")
    }

    private fun wordSegmentation(
        txt: String,
        locale: Locale = Locale("th", "TH")
    ): List<String> {
        val boundary = BreakIterator.getWordInstance(locale)
        boundary.setText(txt)
        val words = mutableListOf<String>()
        var start = boundary.first()
        var end = boundary.next()
        while (end != BreakIterator.DONE) {
            words.add(txt.substring(start, end))
            start = end
            end = boundary.next()
        }
        return words
    }
    
    private fun isScreenLocked(): Boolean {
        val keyguardManager = getSystemService(KEYGUARD_SERVICE) as android.app.KeyguardManager
        return keyguardManager.isKeyguardLocked
    }

    private fun forceSpeakerphoneOn(enabled: Boolean) {
        // This is fallback method for older APIs or when setCommunicationDevice fails
        audioManager.mode = MODE_IN_COMMUNICATION
        audioManager.isSpeakerphoneOn = enabled
    }

    private fun setAudioModeSpeaker() {
        try {
            Log.d("native", "Setting audio mode to speaker")
            audioManager.mode = MODE_IN_COMMUNICATION
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val devices = audioManager.getDevices(GET_DEVICES_OUTPUTS)
                val speakerDevice = devices.find { it.type == AudioDeviceInfo.TYPE_BUILTIN_SPEAKER }
                speakerDevice?.let { audioManager.setCommunicationDevice(it) }
            } else {
                audioManager.isSpeakerphoneOn = true
            }
        } catch (e: Exception) {
            Log.d("native", "Failed to set communication device, falling back to speaker: ${e.message}")
            forceSpeakerphoneOn(true)
        }
    }

    private fun setAudioModeEarpiece() {
        try {
            Log.d("native", "Setting audio mode to earpiece")
            audioManager.mode = MODE_IN_COMMUNICATION
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val devices = audioManager.getDevices(GET_DEVICES_OUTPUTS)
                val earpieceDevice = devices.find { it.type == AudioDeviceInfo.TYPE_BUILTIN_EARPIECE }
                earpieceDevice?.let { audioManager.setCommunicationDevice(it) }
            } else {
                audioManager.isSpeakerphoneOn = false
            }
        } catch (e: Exception) {
            Log.d("native", "Failed to set communication device, falling back to earpiece: ${e.message}")
            forceSpeakerphoneOn(false)
        }
    }

    private fun setAudioModeBluetooth() {
        try {
            Log.d("native", "Setting audio mode to Bluetooth")
            audioManager.mode = MODE_IN_COMMUNICATION

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val devices = audioManager.getDevices(GET_DEVICES_OUTPUTS)
                val bluetoothDevice = devices.find {
                    it.type == AudioDeviceInfo.TYPE_BLUETOOTH_A2DP ||
                    it.type == AudioDeviceInfo.TYPE_BLUETOOTH_SCO
                }
                bluetoothDevice?.let { audioManager.setCommunicationDevice(it) }
            } else {
                audioManager.isSpeakerphoneOn = false
                audioManager.startBluetoothSco()
                audioManager.isBluetoothScoOn = true
            }
        } catch (e: Exception) {
            Log.d("native", "Failed to set Bluetooth communication device: ${e.message}")
            forceSpeakerphoneOn(true)
        }
    }
}
