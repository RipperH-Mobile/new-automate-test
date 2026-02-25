# Event Monitor UI User Guide

## Overview
The Event Monitor UI provides a real-time interface for viewing and analyzing event bus activity in the UChat application. This tool is designed for developers and troubleshooting purposes.

## Navigation
**Path**: Settings → Developer Tools section

**Available Options**:
- **Event Bus Tracking**: Toggle to enable/disable tracking
- **Event Monitor**: View and analyze tracked events

## Features

### 1. Event Tracking Toggle
- **Location**: Settings → Developer Tools → "Event Bus Tracking"
- **Purpose**: Enable/disable event tracking system-wide
- **Default**: Disabled (for performance)
- **Note**: Must be enabled before using Event Monitor
- **Visual Indicator**: Icon changes based on state (filled/outlined)

### 2. Real-time Event Monitoring
- **Live Events**: View events as they occur in real-time
- **Auto-scroll**: Automatically scroll to newest events
- **Pause/Resume**: Pause event display while keeping tracking active

### 3. Event Statistics Dashboard
- **Total Events**: Count of all tracked events
- **Error Count**: Number of events that failed
- **Average Time**: Average execution time across all events
- **Event Types**: Number of unique event types
- **Top Events**: Most frequently fired events with percentages

### 4. Filtering and Search
- **Text Search**: Search events by type or content
- **Event Type Filters**: Filter by specific event types (color-coded)
- **Error Filter**: Show only events that encountered errors
- **Clear Filters**: Reset all active filters

### 5. Event Details
- **Tap to View**: Tap any event to see detailed information
- **Copy Details**: Copy event information to clipboard
- **Event Data**: View serialized event data
- **Error Information**: Stack traces for failed events

### 6. Export Functionality
- **JSON Export**: Export event history as JSON file
- **CSV Export**: Export event history as CSV for analysis
- **Share Options**: Share exported files via system share sheet

### 7. History Management
- **Clear History**: Remove all tracked events
- **History Limit**: Configurable maximum events (default: 1000)
- **Memory Management**: Automatic cleanup of old events

## Event Types and Color Coding

The UI uses color-coded chips to categorize different event types:

- **Blue**: Room-related events (RoomUpdateEvent, RoomNewEvent, etc.)
- **Green**: Message-related events (MessageNewEvent, MessageUpdateEvent, etc.)
- **Purple**: User-related events (UserUpdateEvent, UserLoggedInEvent, etc.)
- **Orange**: Contact-related events (ContactUpdateEvent, ContactDeleteEvent, etc.)
- **Red**: Error events (any event with error status)
- **Indigo**: Socket events (SocketConnectedEvent, SocketDisconnectedEvent, etc.)
- **Teal**: Sync events (SyncRequiredEvent, InitCompleteEvent, etc.)
- **Amber**: Notification events
- **Brown**: File-related events
- **Cyan**: Call-related events
- **Grey**: Unknown/other event types

## Event Status Icons

- **🔵 (Blue Circle)**: Event fired
- **🟢 (Green Circle)**: Event executed successfully
- **🔴 (Red Circle)**: Event encountered an error

## Performance Considerations

### When to Enable Tracking
- **Development**: Always enable for debugging
- **Testing**: Enable when investigating issues
- **Production**: Only enable temporarily for troubleshooting

### Performance Impact
- **Tracking Disabled**: No performance impact
- **Tracking Enabled**: Minimal overhead (~1-5% depending on event frequency)
- **UI Active**: Additional UI rendering overhead

### Memory Usage
- Events stored in memory with configurable limit
- Automatic cleanup prevents memory leaks
- Export and clear functionality for manual management

## Troubleshooting Common Issues

### No Events Showing
1. Check if tracking is enabled in settings
2. Verify app is generating events (navigate, send messages, etc.)
3. Check if filters are excluding all events

### High Memory Usage
1. Reduce history limit in configuration
2. Clear event history regularly
3. Disable tracking when not needed

### Performance Issues
1. Pause real-time monitoring
2. Reduce auto-scroll frequency
3. Use filters to reduce displayed events

### Export Failures
1. Check device storage space
2. Verify share permissions
3. Try smaller export ranges

## Technical Implementation

### Architecture
- **TrackedEventBus**: Enhanced EventBus with tracking capabilities
- **EventTracker**: Service for collecting and managing event data
- **EventMonitorController**: GetX controller for UI state management
- **Reactive UI**: Uses Obx for real-time updates

### Data Flow
1. Events fired through TrackedEventBus
2. EventTracker captures event metadata
3. Controller polls tracker for updates
4. UI renders events reactively
5. Export services format data for sharing

### Configuration
- Settings stored in ConfigDb
- Tracking state persisted across app restarts
- History limit configurable per installation

## Best Practices

### For Developers
1. Enable tracking during feature development
2. Monitor event frequency for performance optimization
3. Use error tracking to identify issues
4. Export event data for offline analysis

### For Troubleshooting
1. Enable tracking before reproducing issues
2. Use filters to focus on relevant events
3. Export data for support team analysis
4. Clear history between test scenarios

### For Performance
1. Disable tracking in production builds
2. Set reasonable history limits
3. Monitor memory usage during long sessions
4. Use pause functionality during intensive operations