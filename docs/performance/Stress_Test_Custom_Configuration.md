# Stress Test Configuration Dialog - Custom Parameters

## Overview

The stress test functionality has been enhanced with a custom configuration
dialog that allows users to specify exact numbers for data generation using
intuitive slider controls.

## Features Implemented

### 🎛️ **Interactive Configuration Dialog**

- **Slider Controls**: Interactive sliders for each parameter
- **Real-time Preview**: Live calculation of totals and estimated time
- **Visual Summary**: Clear overview of what will be generated
- **Parameter Validation**: Sensible min/max limits for each parameter

### 📊 **Configurable Parameters**

1. **Messages per Room** (10-200)
    - Number of messages in each chat room
    - Applies to direct chats, group chats, and OA chats

2. **Friend Contacts** (1-20)
    - Number of friend contacts to create
    - Each gets a direct chat room

3. **Group Chats** (1-10)
    - Number of group chats to create
    - Each group has configurable member count

4. **Group Members** (2-10)
    - Number of members in each group chat
    - Includes the current user as a member

5. **Official Accounts** (1-10)
    - Number of official accounts to create
    - Each gets a direct chat room

### 🔄 **Duplicate Handling**

The system now intelligently handles existing mock data:

- **Contacts**: Continues numbering from existing mock contacts
- **Groups**: Continues numbering from existing mock groups
- **Messages**: Generates fresh messages for new rooms
- **No Conflicts**: Prevents ID collisions and naming conflicts

## Implementation Details

### Dialog Components

```dart
// Custom slider widget with live values
_buildSlider
(
title: 'Messages per Room',
subtitle: 'Number of messages in each chat room',
icon: Icons.message,
value: messageCount,
min: 10,
max: 200,
divisions: 19,
onChanged: (value) => setState(() => messageCount = value),
)
```

### Smart Indexing System

```dart
// Check existing data and continue from next index
final existingContacts = await
contactLocalRepository.getAllContact
();

final existingMockContacts = existingContacts.where((c) =>
    c.id.contains('_mock')).toList();
int startContactIndex = existingMockContacts.length + 1;

// Generate with proper incremental naming
displayName: '
Mock Contact 
$
contactIndex', // e.g., "Mock Contact 4" if 3 exist
```

### Parameter Validation

- **Min/Max Limits**: Prevents unrealistic values that could crash the app
- **Memory Estimation**: Calculates approximate memory usage and time
- **User Confirmation**: Shows exact numbers before generation

## Usage Flow

### 1. **Open Configuration Dialog**

```dart
void addDataForStressTest(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) =>
        StressTestConfigDialog(
          onConfirm: (StressTestParams params) async {
            await _executeStressTestWithParams(context, params);
          },
        ),
  );
}
```

### 2. **Configure Parameters**

- Use sliders to set desired values
- View real-time summary of what will be generated
- See estimated generation time

### 3. **Confirm Generation**

- Review final parameters in confirmation dialog
- Start generation process with loading indicator
- Get success notification with actual numbers generated

### 4. **Handle Results**

- Success: Show summary of generated data
- Error: Display detailed error message
- Progress: Live progress tracking during generation

## Example Scenarios

### 📱 **Light Testing** (Default)

- Messages: 50 per room
- Contacts: 3 friends
- Groups: 2 groups
- Members: 3 per group
- OAs: 2 accounts
- **Result**: ~350 messages, 7 total rooms

### 🔥 **Heavy Stress Testing**

- Messages: 150 per room
- Contacts: 10 friends
- Groups: 5 groups
- Members: 8 per group
- OAs: 5 accounts
- **Result**: ~3,000 messages, 20 total rooms

### ⚡ **Performance Testing**

- Messages: 200 per room
- Contacts: 5 friends
- Groups: 3 groups
- Members: 10 per group
- OAs: 2 accounts
- **Result**: ~2,000 messages, 10 total rooms

## Safety Features

### 🛡️ **Memory Protection**

- Maximum limits prevent memory overflow
- Batch processing for large datasets
- Progress indicators show system isn't frozen

### 🔄 **Duplicate Prevention**

- Smart indexing prevents naming conflicts
- Continues from existing data seamlessly
- No database constraint violations

### ⚠️ **Error Handling**

- Graceful error recovery
- Detailed error messages
- Rollback on partial failures

## Technical Benefits

### ✅ **Better User Experience**

- Visual configuration vs text input
- Real-time feedback and estimates
- Clear progress indication

### ✅ **More Flexible Testing**

- Custom data volumes for different test scenarios
- Incremental data generation
- Repeatable test configurations

### ✅ **Production Ready**

- Proper error handling and recovery
- Memory-efficient batch processing
- Smart duplicate handling

The enhanced stress test functionality provides a professional-grade tool for
generating test data with full user control over the parameters, making it ideal
for performance testing, UI stress testing, and development scenarios.
