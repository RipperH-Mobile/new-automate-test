# Features - Presentation Layer

## Overview

The Presentation Layer is responsible for displaying information to users and handling user interactions. In UChat, this layer uses the GetX package for state management, dependency injection, and navigation. The Presentation Layer communicates with the Domain Layer through use cases but has no direct interaction with the Data Layer.

## Structure

Within each feature, the Presentation Layer follows this structure:

```
feature_name/presentation/
├── arguments/
│   └── feature_name_argument.dart
├── bindings/
│   └── feature_name_binding.dart
├── controllers/
│   └── feature_name_controller.dart
├── screens/
│   └── feature_name_screen.dart
└── widgets/
    ├── feature_name_item.dart
    └── feature_name_list.dart
```

## Components

### Arguments

Arguments are data classes used to pass parameters when navigating between screens.

Characteristics:
- Simple data classes with required parameters
- Used for screen initialization
- Passed during navigation

Example:

```dart
class UserProfileArguments {
  final String userId;
  final bool isEditable;
  final VoidCallback? onUserUpdated;

  const UserProfileArguments({
    required this.userId,
    this.isEditable = false,
    this.onUserUpdated,
  });
}

// Usage in navigation
Get.toNamed(
  Routes.USER_PROFILE,
  arguments: UserProfileArguments(userId: '123', isEditable: true),
);
```

### Bindings

Bindings connect the dependencies required by a screen and its controllers when a route is loaded. They use GetX's dependency injection system to register controllers, use cases, repositories, and other dependencies.

Characteristics:
- Register dependencies for a specific screen
- Instantiate controllers with their dependencies
- Clean up resources when the screen is closed

Example:

```dart
class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Register the controller with its dependencies
    Get.lazyPut<UserProfileController>(
      () => UserProfileController(
        getUserProfile: getIt<GetUserProfileUseCase>(),
        updateUserProfile: getIt<UpdateUserProfileUseCase>(),
        deleteUser: getIt<DeleteUserUseCase>(),
      ),
    );
    
    // You can register additional controllers if needed
    Get.lazyPut<UserActivityController>(
      () => UserActivityController(
        getUserActivity: getIt<GetUserActivityUseCase>(),
      ),
    );
  }
}
```

### Controllers

Controllers manage state, business logic, and user interactions for screens. They mediate between the UI (screens and widgets) and the domain layer (use cases).

Characteristics:
- Extend GetxController for lifecycle management
- Use reactive state with .obs variables
- Execute use cases in response to user actions
- Transform domain data for UI presentation
- Handle exceptions and provide error states

Example:

```dart
class UserProfileController extends GetxController {
  final GetUserProfileUseCase getUserProfile;
  final UpdateUserProfileUseCase updateUserProfile;
  final DeleteUserUseCase deleteUser;
  
  // State variables (reactive)
  final user = Rxn<UserViewModel>(); // nullable observable
  final isLoading = false.obs;
  final error = Rxn<String>();
  final isEditing = false.obs;
  
  // Form controllers
  late TextEditingController nameController;
  
  // Constructor with injected dependencies
  UserProfileController({
    required this.getUserProfile,
    required this.updateUserProfile,
    required this.deleteUser,
  });
  
  // Lifecycle methods
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    
    // Get the arguments
    final args = Get.arguments as UserProfileArguments;
    loadUser(args.userId);
    
    if (args.isEditable) {
      isEditing.value = true;
    }
  }
  
  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
  
  // Business methods
  Future<void> loadUser(String userId) async {
    try {
      isLoading.value = true;
      error.value = null;
      
      final userEntity = await getUserProfile(GetUserProfileParams(userId: userId));
      user.value = UserViewModel.fromEntity(userEntity);
      
      // Set initial form values
      nameController.text = user.value?.displayName ?? '';
    } catch (e) {
      error.value = 'Failed to load user: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> saveProfile() async {
    if (!_validateForm()) return;
    
    try {
      isLoading.value = true;
      error.value = null;
      
      await updateUserProfile(UpdateUserProfileParams(
        userId: user.value!.id,
        displayName: nameController.text,
      ));
      
      // Reload user data to reflect changes
      await loadUser(user.value!.id);
      
      // Exit edit mode
      isEditing.value = false;
      
      // Show success message
      Get.snackbar('Success', 'Profile updated successfully');
      
      // Call callback if provided in arguments
      final args = Get.arguments as UserProfileArguments;
      args.onUserUpdated?.call();
    } catch (e) {
      error.value = 'Failed to update profile: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> deleteProfile() async {
    try {
      isLoading.value = true;
      error.value = null;
      
      await deleteUser(DeleteUserParams(userId: user.value!.id));
      
      // Navigate back after deletion
      Get.back();
      Get.snackbar('Success', 'Profile deleted successfully');
    } catch (e) {
      error.value = 'Failed to delete profile: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Helper methods
  bool _validateForm() {
    if (nameController.text.isEmpty) {
      error.value = 'Name cannot be empty';
      return false;
    }
    return true;
  }
  
  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    
    // Reset form if cancelling edit
    if (!isEditing.value) {
      nameController.text = user.value?.displayName ?? '';
      error.value = null;
    }
  }
}

// View model for UI presentation
class UserViewModel {
  final String id;
  final String displayName;
  final String? profileImage;
  final bool isOnline;
  final String lastSeenDisplay;
  
  UserViewModel({
    required this.id,
    required this.displayName,
    this.profileImage,
    required this.isOnline,
    required this.lastSeenDisplay,
  });
  
  // Create from domain entity
  factory UserViewModel.fromEntity(UserEntity entity) {
    return UserViewModel(
      id: entity.id,
      displayName: entity.displayName,
      profileImage: entity.profileImage,
      isOnline: entity.isOnline,
      lastSeenDisplay: _formatLastSeen(entity.lastSeen),
    );
  }
  
  // Helper method for formatting last seen time for display
  static String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(lastSeen);
    }
  }
}
```

### Screens

Screens represent complete UI views that are navigated to and from. They compose widgets and connect to controllers to display data and handle interactions.

Characteristics:
- Extend GetView for automatic controller access
- Define the overall UI structure for a feature
- Minimal logic, focused on layout and UI concerns
- Use reactive widgets to respond to state changes

Example:

```dart
class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          // Only show edit button if not in edit mode
          Obx(() => controller.isEditing.value 
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: controller.toggleEditMode,
              )
            : IconButton(
                icon: const Icon(Icons.edit),
                onPressed: controller.toggleEditMode,
              ),
          ),
        ],
      ),
      body: Obx(() {
        // Show loading indicator
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message
        if (controller.error.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.error.value!,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadUser(
                    (Get.arguments as UserProfileArguments).userId,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Show user data
        if (controller.user.value == null) {
          return const Center(child: Text('User not found'));
        }

        return _buildUserProfile();
      }),
      bottomNavigationBar: Obx(() {
        // Show save button only in edit mode
        if (controller.isEditing.value) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: controller.saveProfile,
              child: const Text('Save Changes'),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final user = controller.user.value!;
        final isEditing = controller.isEditing.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image
            Center(
              child: UserAvatarWidget(
                imageUrl: user.profileImage,
                size: 120,
                isOnline: user.isOnline,
              ),
            ),
            const SizedBox(height: 24),

            // User name field
            if (isEditing)
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  border: OutlineInputBorder(),
                ),
              )
            else
              Row(
                children: [
                  const Text(
                    'Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.displayName),
                ],
              ),
            const SizedBox(height: 16),

            // Last seen status
            if (!isEditing) ...[
              Row(
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.isOnline ? 'Online' : 'Offline'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    'Last seen: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.lastSeenDisplay),
                ],
              ),
              const SizedBox(height: 24),
              
              // Delete user button (only when not editing)
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    'Delete Profile',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text(
                          'Are you sure you want to delete this profile? This action cannot be undone.'
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              controller.deleteProfile();
                            },
                            child: const Text('Delete'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        );
      }),
    );
  }
}
```

### Widgets

Widgets are reusable UI components specific to a feature. They can be stateless or have their own controllers for complex behavior.

Characteristics:
- Reusable and focused on a specific UI element
- May have their own controllers for complex widgets
- Highly cohesive and loosely coupled
- Accept callbacks for user interactions

Example:

```dart
class UserAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool isOnline;
  final VoidCallback? onTap;

  const UserAvatarWidget({
    Key? key,
    this.imageUrl,
    required this.size,
    this.isOnline = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Avatar image
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: size / 2,
            backgroundColor: Colors.grey[300],
            backgroundImage: imageUrl != null 
                ? CachedNetworkImageProvider(imageUrl!) as ImageProvider
                : AssetImage('assets/images/default_avatar.png'),
          ),
        ),
        
        // Online status indicator
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size / 5,
              height: size / 5,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class UserListItemWidget extends StatelessWidget {
  final UserViewModel user;
  final VoidCallback onTap;
  final bool showLastSeen;

  const UserListItemWidget({
    Key? key,
    required this.user,
    required this.onTap,
    this.showLastSeen = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatarWidget(
        imageUrl: user.profileImage,
        size: 50,
        isOnline: user.isOnline,
      ),
      title: Text(
        user.displayName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: showLastSeen ? Text(user.lastSeenDisplay) : null,
      onTap: onTap,
    );
  }
}
```

## Guidelines

### State Management

1. **Reactive State**:
   - Use `.obs` variables for reactive state
   - Wrap widgets with `Obx()` to respond to state changes
   - Avoid unnecessary state variables

2. **View Models**:
   - Create view models to transform domain entities for UI
   - Include only UI-relevant properties
   - Add helper methods for UI-specific formatting

3. **Loading and Error States**:
   - Always provide loading indicators
   - Handle and display errors appropriately
   - Implement retry mechanisms for failed operations

4. **Form Handling**:
   - Use proper form controllers
   - Validate form input before submitting
   - Provide clear error messages for validation failures

### UI/UX Design

1. **Responsive Design**:
   - Ensure UI works on different screen sizes
   - Use flexible layouts with proper constraints
   - Test on both mobile and tablet/desktop displays

2. **User Feedback**:
   - Show loading indicators for all async operations
   - Provide visual and/or haptic feedback for user actions
   - Use snackbars or toasts for success/failure messages

3. **Error Handling**:
   - Display user-friendly error messages
   - Provide recovery options for failures
   - Log detailed errors for debugging

4. **Accessibility**:
   - Use proper semantic labels for screen readers
   - Ensure sufficient color contrast
   - Support text scaling for accessibility

### Controller Guidelines

1. **Single Responsibility**:
   - Each controller should manage one screen or component
   - Break complex controllers into smaller ones
   - Use services for shared state across controllers

2. **Lifecycle Management**:
   - Initialize resources in `onInit()`
   - Clean up resources in `onClose()`
   - Use `ever()`, `once()`, etc. for state observation

3. **Error Handling**:
   - Catch exceptions from use case calls
   - Transform technical errors into user-friendly messages
   - Update error state for UI display

4. **Dependency Injection**:
   - Inject use cases, not repositories
   - Use interfaces for better testability
   - Follow constructor injection pattern

5. **Testing**:
   - Design controllers to be easily testable
   - Mock dependencies for unit testing
   - Test both success and failure scenarios

### Navigation

1. **Named Routes**:
   - Use named routes for navigation
   - Define routes in a central location
   - Use arguments for passing data between screens

2. **Navigation Patterns**:
   - Use appropriate navigation patterns (push, replacement, dialog)
   - Handle back button behavior properly
   - Provide clear navigation cues to users

3. **Deep Linking**:
   - Support deep linking when appropriate
   - Handle missing parameters gracefully
   - Validate navigation arguments

4. **Screen Results**:
   - Use callbacks or result parameters for screen results
   - Update state after navigation completes
   - Refresh data when returning to screens if needed