# Message Sequence Fix - Linear Ordering

## Issue Fixed

The messages generated in the stress test were not in proper sequential order
because:

1. **Random Timestamps**: Messages used
   `DateTime.now().subDays(random.nextInt(roomAge))` which created random
   timestamps
2. **Non-Linear Sequences**: The sequence numbers were based on these random
   timestamps, making them non-sequential
3. **Poor Chat Experience**: Messages appeared out of order in the chat
   interface

## Solution Implemented

### 1. **Linear Time Progression**

```dart
// Before: Random timestamps
final messageCreateTime = DateTime.now().subDays(random.nextInt(roomAge));

// After: Sequential timestamps
final baseTime = DateTime.now().subDays(roomAge);
final messageCreateTime = baseTime.add(Duration(
  minutes: j * 5, // 5 minutes between messages for direct chats
  seconds: random.nextInt(60), // Small random variation
));
```

### 2. **Linear Sequence Numbers**

```dart
// Before: Random sequence based on random timestamp
sequence: messageCreateTime.millisecondsSinceEpoch,

// After: Truly linear sequence
final sequence = baseTime.millisecondsSinceEpoch +
    (j * 300000); // 5 minutes in milliseconds
```

### 3. **Differentiated Chat Types**

- **Direct Chats**: 5 minutes between messages (more relaxed conversation)
- **Group Chats**: 3 minutes between messages (more active discussion)

### 4. **Better Message Content**

```dart
// Direct messages
message: '
Message 
${
j + 1
}
: Mock conversation 
${
_generateRandomString
(10, random)}'

// Group messages  
message: 'Message ${j + 1}: ${sender.account.displayName} says ${_generateRandomString(15, random)}'
```

### 5. **Recent Last Messages**

Room subscriptions now show recent last messages (1-12 hours ago) instead of
random old timestamps.

## Benefits

### ✅ **Proper Message Ordering**

- Messages now appear in chronological order (oldest to newest)
- Sequence numbers are truly linear and predictable
- Chat conversations flow naturally

### ✅ **Realistic Timing**

- Direct chats: 5-minute intervals simulate normal conversation pace
- Group chats: 3-minute intervals simulate active group discussions
- Small random seconds add natural variation

### ✅ **Better Testing Data**

- Messages are numbered sequentially (Message 1, Message 2, etc.)
- Each message includes sender information in group chats
- Last messages are recent for realistic room listings

### ✅ **Performance Benefits**

- Predictable sequence numbers improve database performance
- Linear timestamps enable better message indexing
- Consistent ordering reduces chat rendering issues

## Example Output

### Direct Chat Messages:

```
Message 1: Mock conversation abc123xyz
Message 2: Mock conversation def456uvw  
Message 3: Mock conversation ghi789rst
```

### Group Chat Messages:

```
Message 1: Mock Contact 1 says lorem123ipsum
Message 2: Mock Contact 2 says dolor456sit  
Message 3: Current User says amet789consectetur
```

## Technical Details

### Sequence Calculation:

- **Base timestamp**: Start of room age (e.g., 100 days ago)
- **Direct chat interval**: 5 minutes (300,000 milliseconds)
- **Group chat interval**: 3 minutes (180,000 milliseconds)
- **Sequence formula**:
  `baseTime.millisecondsSinceEpoch + (messageIndex * intervalMs)`

### Timestamp Calculation:

- **Base time**: `DateTime.now().subDays(roomAge)`
- **Message time**: `baseTime.add(Duration(minutes: j * interval))`
- **Random variation**: ±60 seconds for natural feel

This ensures that:

1. Message 1 has the smallest sequence number
2. Message 2 has sequence = Message 1 sequence + interval
3. Messages appear in perfect chronological order
4. Chat performance is optimized for linear access patterns

The fix resolves the non-linear sequence issue and provides a much better
testing experience with realistic, ordered chat conversations.
