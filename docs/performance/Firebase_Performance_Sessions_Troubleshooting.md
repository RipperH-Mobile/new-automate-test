# Firebase Performance Sessions - Troubleshooting Guide

## Understanding "No Sessions" Issue

### What is a Firebase Performance Session?

A **session** in Firebase Performance represents a period of app usage by a
user, from when the app starts until it goes to the background or is terminated.

### Why No Sessions Appear?

The issue occurs due to **Firebase's sampling mechanism**:

1. **Default Sampling Rate**: Only **1%** of sessions are collected
2. **Minimum Threshold**: Need **100+ sessions** to see **1 session** in console
3. **Random Selection**: Firebase randomly picks which sessions to monitor

## The Math Behind Sampling

```
Sampling Rate: 1% (0.01)
Sessions Needed: 100 sessions minimum
Visible Sessions: 100 × 0.01 = 1 session (approximately)

For reliable data:
- 500 sessions → ~5 visible sessions
- 1000 sessions → ~10 visible sessions
```

## Solutions

### 1. Development Mode Setup

Use high sampling rate during development:

```dart
// In your main app initialization
final performance = usePerformance();

// For Development (100% sampling)
await
performance.initializeDevelopment
();

// For Production (1% sampling)
await
performance.initializeProduction
();
```

### 2. Generate Test Sessions

Create multiple app sessions to reach the threshold:

```dart
// Generate test sessions during development
await
performance.generateTestSessions
(
sessionCount: 150);

// Check debug information
performance.printDebugInfo();
```

### 3. Manual Session Generation

If you need to generate sessions manually:

1. **Open and close the app** 100+ times
2. **Use different devices** to create unique sessions
3. **Simulate real user behavior** (navigate, interact, wait)

### 4. App Usage Patterns

Ensure your app generates natural sessions:

```dart
class AppLifecycleManager extends StatefulWidget {
  @override
  _AppLifecycleManagerState createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {

  PerformanceTrace? _sessionTrace;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startSession();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _endSession();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _startSession();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _endSession();
        break;
      default:
        break;
    }
  }

  void _startSession() async {
    if (_sessionTrace == null) {
      final performance = usePerformance();
      _sessionTrace = performance.create('2025_performance_app_session');
      await _sessionTrace!.start();
    }
  }

  void _endSession() async {
    if (_sessionTrace != null) {
      await _sessionTrace!.stop();
      _sessionTrace!.dispose();
      _sessionTrace = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
```

## Timeline for Data Appearance

| Action                    | Timeline    |
|---------------------------|-------------|
| App generates sessions    | Immediate   |
| Data sent to Firebase     | 1-5 minutes |
| Data appears in console   | 1-2 hours   |
| Historical data available | 24 hours    |

## Verification Steps

### 1. Check Performance Collection Status

```dart

final performance = usePerformance();

// Print debug information
performance.printDebugInfo
();

// Verify collection is enabled
if
(!performance.isPerformanceCollectionEnabled()) {
print('❌ Performance collection is disabled');
} else {
print('✅ Performance collection is enabled');
}
```

### 2. Monitor Network Traffic

Check if your app is sending performance data:

1. Open **Firebase Console** → **Performance**
2. Look for **"Waiting for data"** message
3. Check **Network tab** in browser dev tools for Firebase requests

### 3. Validate Firebase Configuration

Ensure Firebase Performance is properly configured:

```dart
// In main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Performance Monitoring
  final performance = usePerformance();
  await performance.initializeDevelopment(); // For development

  runApp(MyApp());
}
```

## Best Practices

### 1. Development vs Production

- **Development**: Use 100% sampling to see all data immediately
- **Production**: Use default 1% sampling to minimize impact

### 2. Trace Naming

Use consistent naming conventions:

```dart
// Good naming
'2025_performance_chat_scroll'
'2025_performance_image_load'
'2025_performance_video_play'

// Bad naming
'trace1'
'
performance
'
'
test
'
```

### 3. Session Generation Strategy

```dart
class SessionManager {
  static Future<void> generateDevelopmentSessions() async {
    final performance = usePerformance();

    // Generate sessions with realistic intervals
    for (int i = 0; i < 200; i++) {
      await _simulateUserSession(i);

      // Wait between sessions (realistic user behavior)
      await Future.delayed(Duration(
        milliseconds: 100 + (i % 500), // Variable delays
      ));
    }
  }

  static Future<void> _simulateUserSession(int sessionId) async {
    final performance = usePerformance();

    // Start main session trace
    final sessionTrace = performance.create(
      '2025_performance_session_$sessionId',
    );

    await sessionTrace.start();

    // Simulate user activities
    await _simulateUserActivities(performance);

    // Add session metrics
    sessionTrace.putMetric('user_actions', 5 + (sessionId % 10));
    sessionTrace.putMetric('session_duration', 1000 + (sessionId % 5000));

    await sessionTrace.stop();
    sessionTrace.dispose();
  }

  static Future<void> _simulateUserActivities(
      PerformanceService performance) async {
    // Simulate navigation
    final navTrace = performance.create('2025_performance_navigation');
    await navTrace.start();
    await Future.delayed(const Duration(milliseconds: 50));
    await navTrace.stop();
    navTrace.dispose();

    // Simulate data loading
    final loadTrace = performance.create('2025_performance_data_load');
    await loadTrace.start();
    await Future.delayed(const Duration(milliseconds: 30));
    await loadTrace.stop();
    loadTrace.dispose();
  }
}
```

## Troubleshooting Checklist

- [ ] Firebase Performance is enabled in Firebase Console
- [ ] `firebase_performance` plugin is properly installed
- [ ] Performance collection is enabled in code
- [ ] App has generated 100+ sessions
- [ ] Waited 1-2 hours for data to appear
- [ ] Checked correct Firebase project
- [ ] Verified app is connected to internet
- [ ] No ad blockers interfering with Firebase requests

## Common Mistakes

1. **Not generating enough sessions**: Need 100+ for visibility
2. **Expecting immediate data**: Takes 1-2 hours to appear
3. **Using production sampling in dev**: Use development mode
4. **Not waiting long enough**: Firebase has processing delays
5. **Incorrect Firebase project**: Verify project connection

## Quick Test Script

Add this to your app for quick testing:

```dart
class FirebasePerformanceTest {
  static Future<void> runQuickTest() async {
    final performance = usePerformance();

    print('🚀 Starting Firebase Performance Test...');

    // Check if enabled
    performance.printDebugInfo();

    // Generate test sessions
    await performance.generateTestSessions(sessionCount: 150);

    // Create some manual traces
    for (int i = 0; i < 10; i++) {
      final trace = performance.create('2025_performance_test_trace_$i');
      await trace.start();
      await Future.delayed(const Duration(milliseconds: 100));
      trace.putMetric('test_value', i + 1);
      await trace.stop();
      trace.dispose();
    }

    print('✅ Test completed! Check Firebase Console in 1-2 hours.');
  }
}

// Call this in your development build
// FirebasePerformanceTest.runQuickTest();
```

Remember: The key is **patience** and **generating enough sessions**. Firebase
Performance's sampling mechanism is designed for production apps with thousands
of users, not development apps with a few test sessions.
