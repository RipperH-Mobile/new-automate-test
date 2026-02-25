package social.uchat

import com.google.firebase.perf.FirebasePerformance
import com.google.firebase.perf.metrics.Trace
import android.util.Log
import java.util.concurrent.ConcurrentHashMap

object NativePerfTracker {
    private val activeTraces = ConcurrentHashMap<String, Trace>()
    private const val TAG = "native_perf"

    /**
     * Start a dynamic trace with the given name and optional attributes
     * @param traceName Unique identifier for the trace (e.g., "incoming_call_latency_native_android")
     * @param attributes Optional map of custom attributes to attach to the trace
     * @return The trace identifier for later reference, or null if failed
     */
    fun startTrace(traceName: String, attributes: Map<String, String>? = null): String? {
        return try {
            // Check if trace already exists
            if (activeTraces.containsKey(traceName)) {
                Log.w(TAG, "Trace '$traceName' is already active")
                return traceName
            }

            val trace = FirebasePerformance.getInstance().newTrace(traceName)
            trace.start()
            
            // Add custom attributes if provided
            attributes?.forEach { (key, value) ->
                trace.putAttribute(key, value)
            }

            // Add default attributes
            // trace.putAttribute("receivingFrom", "native")
            
            activeTraces[traceName] = trace
            Log.d(TAG, "Firebase Perf trace started: $traceName")
            traceName
        } catch (e: Exception) {
            Log.e(TAG, "Firebase Perf trace init failed for '$traceName': ${e.message}", e)
            null
        }
    }

    /**
     * Stop a specific trace by name
     * @param traceName The identifier of the trace to stop
     * @return true if trace was stopped successfully, false otherwise
     */
    fun stopTrace(traceName: String): Boolean {
        return try {
            val trace = activeTraces.remove(traceName)
            if (trace == null) {
                Log.w(TAG, "Trace '$traceName' not found or already stopped")
                return false
            }
            
            trace.stop()
            Log.d(TAG, "Firebase Perf trace stopped: $traceName")
            true
        } catch (e: Exception) {
            Log.e(TAG, "Firebase Perf trace stop failed for '$traceName': ${e.message}", e)
            false
        }
    }

    /**
     * Add a custom metric to a specific trace
     * @param traceName The identifier of the trace
     * @param metricName The name of the metric
     * @param value The numeric value of the metric
     */
    fun addMetric(traceName: String, metricName: String, value: Long) {
        try {
            val trace = activeTraces[traceName]
            if (trace == null) {
                Log.w(TAG, "Trace '$traceName' not found for metric '$metricName'")
                return
            }
            trace.putMetric(metricName, value)
            Log.d(TAG, "Metric added to trace '$traceName': $metricName=$value")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to add metric to trace '$traceName': ${e.message}", e)
        }
    }

    /**
     * Add an attribute to a specific trace
     * @param traceName The identifier of the trace
     * @param key The attribute key
     * @param value The attribute value
     */
    fun addAttribute(traceName: String, key: String, value: String) {
        try {
            val trace = activeTraces[traceName]
            if (trace == null) {
                Log.w(TAG, "Trace '$traceName' not found for attribute '$key'")
                return
            }
            trace.putAttribute(key, value)
            Log.d(TAG, "Attribute added to trace '$traceName': $key=$value")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to add attribute to trace '$traceName': ${e.message}", e)
        }
    }

    /**
     * Stop all active traces (useful for cleanup)
     * @return The number of traces stopped
     */
    fun stopAllTraces(): Int {
        val count = activeTraces.size
        try {
            activeTraces.forEach { (traceName, trace) ->
                trace.stop()
                Log.d(TAG, "Stopped trace during cleanup: $traceName")
            }
            activeTraces.clear()
            Log.d(TAG, "All traces stopped. Count: $count")
        } catch (e: Exception) {
            Log.e(TAG, "Error during stopAllTraces: ${e.message}", e)
        }
        return count
    }

    /**
     * Get the count of currently active traces
     */
    fun getActiveTraceCount(): Int = activeTraces.size

    /**
     * Check if a specific trace is active
     * @param traceName The identifier of the trace
     */
    fun isTraceActive(traceName: String): Boolean = activeTraces.containsKey(traceName)


    /* ------------- case start call to display incoming call ------------- */
    /**
     * Legacy method for backward compatibility - starts the default call trace
     */
    fun startCallTrace(attributes: Map<String, String>? = null) {
        startTrace("performance_calling_incoming_call_native", attributes)
    }

    /**
     * Legacy method for backward compatibility - stops the default call trace
     */
    fun stopCallTrace() {
        stopTrace("performance_calling_incoming_call_native")
    }

    /* ------------- case push decline call button to display missed call ------------- */
    /**
     * Legacy method for backward compatibility - start decline until time count
     */
    fun startDeclineUntilMissedCall(attributes: Map<String, String>? = null) {
        startTrace("performance_calling_missed_native", attributes)
    }

    /**
     * Legacy method for backward compatibility - stop decline until time count
     */
    fun stopDeclineUntilMissedCall() {
        stopTrace("performance_calling_missed_native")
    }
}
