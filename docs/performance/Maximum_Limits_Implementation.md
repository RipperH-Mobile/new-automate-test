# Maximum Limits Implementation for Stress Test Data Generation

## Overview

Added comprehensive maximum limits to prevent the stress test data generation
from creating excessive amounts of data that could impact app performance or
storage.

## Maximum Limits Defined

```dart
// Maximum limits for data generation
static const double messageCountMax = 2000.0;
static const double contactCountMax = 1000.0;
static const double groupCountMax = 10000.0;
static const double groupMemberCountMax = 500.0;
static const double oaCountMax = 10000.0;
```

## Implementation Details

### 🛡️ **Pre-Generation Limit Checks**

Before any data generation begins, the system:

1. **Counts Existing Mock Data**:
    - Friend contacts with `_mock` in ID
    - Official accounts with `@` prefix and `_mock` in ID
    - Group rooms containing "Mock group" in name
    - Estimates existing messages based on room count

2. **Calculates Projected Totals**:
    - `newContactTotal = existing + requested`
    - `newOATotal = existing + requested`
    - `newGroupTotal = existing + requested`
    - `estimatedMessages = existing + (rooms × messages per room)`

3. **Enforces Limits**:
    - Throws exception if any limit would be exceeded
    - Prevents partial generation that could leave incomplete data
    - Provides clear error messages with current counts and limits

### ⚠️ **Limit Enforcement Logic**

```dart
// Example limit check for contacts
if (newContactTotal > contactCountMax) {
log.w('⚠️ Contact limit reached! Current: $existingMockContacts, Requested: $contactCount, Max: ${contactCountMax.toInt()}');
throw Exception('Contact limit would be exceeded. Current: $existingMockContacts, Max: ${contactCountMax.toInt()}');
}
```

### 📊 **User Interface Updates**

1. **Dialog Slider Limits Updated**:
    - Messages per Room: 10-200 (UI limit, actual limit 2000)
    - Friend Contacts: 1-50 (UI limit, actual limit 1000)
    - Group Chats: 1-20 (UI limit, actual limit 10000)
    - Group Members: 2-20 (UI limit, actual limit 500)
    - Official Accounts: 1-20 (UI limit, actual limit 10000)

2. **Warning Information Box**:
    - Shows all maximum limits in the configuration dialog
    - Informs users about automatic limit enforcement
    - Orange warning styling to draw attention

## Behavior When Limits Are Reached

### ✅ **Successful Scenarios**

- **Within Limits**: Normal generation proceeds with progress tracking
- **Approaching Limits**: Generation completes successfully with warnings in
  logs

### ❌ **Limit Exceeded Scenarios**

- **Before Generation**: Exception thrown with specific limit information
- **User Notification**: Clear error message showing current count and maximum
- **No Partial Data**: Nothing is generated if limits would be exceeded
- **Graceful Handling**: Controller shows error dialog to user

### 📝 **Error Messages Provided**

Example error messages users will see:

```
Contact limit would be exceeded. Current: 950, Max: 1000
Official Account limit would be exceeded. Current: 9980, Max: 10000
Group limit would be exceeded. Current: 9995, Max: 10000
Group member count exceeds limit. Requested: 600, Max: 500
Message limit would be exceeded. Current: ~1800, Max: 2000
```

## Benefits of Limit Implementation

### 🎯 **Performance Protection**

- Prevents app crashes from excessive data
- Maintains reasonable database sizes
- Ensures UI remains responsive

### 🔐 **Data Integrity**

- All-or-nothing generation approach
- No partial data creation on limit violations
- Consistent state maintenance

### 👥 **User Experience**

- Clear feedback about current data state
- Informative error messages with specific numbers
- Visual warning in configuration dialog

### 🔧 **Developer Benefits**

- Configurable limits via constants
- Comprehensive logging for debugging
- Easy to adjust limits for different environments

## Configuration and Customization

### 📝 **Adjusting Limits**

To modify limits, update the constants in `GenerateDataForStressTestUseCase`:

```dart

static const double messageCountMax = 3000.0; // Increase message limit
static const double contactCountMax = 2000.0; // Increase contact limit
// etc.
```

### 🎛️ **UI Slider Limits**

Update dialog sliders in `StressTestConfigDialog` for reasonable UI ranges:

```dart
max: 100
, // Increase slider maximum
divisions: 99
, // Adjust divisions accordingly
```

### 🔍 **Monitoring Current Usage**

The system provides detailed logging:

```
📊 Current data: Contacts: 45, OAs: 12, Groups: 8, Messages: ~3250
✅ Limit checks passed. Proceeding with data generation...
```

## Testing Scenarios

### 🧪 **Test Cases to Verify**

1. **Normal Generation**: Within all limits
2. **Contact Limit**: Try to exceed 1000 contacts
3. **Message Limit**: Generate enough rooms/messages to exceed 2000
4. **Group Member Limit**: Set group members > 500
5. **Multiple Limit**: Test combinations that exceed multiple limits

### 📊 **Expected Results**

- Clear error messages for limit violations
- Successful generation when within limits
- No data corruption or partial generation
- Proper UI feedback in all scenarios

The maximum limits implementation provides robust protection against excessive
data generation while maintaining a smooth user experience and clear feedback
about system constraints.
