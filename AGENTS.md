# AGENTS.md

## Introduction

This document provides essential guidelines for AI agents (such as Roo, Claude, or Gemini) working with the code in this Flutter-based UChat Messenger repository. Following these rules ensures consistency, maintains code quality, and aligns with the project's architecture and tooling. Agents should reference this file before making changes to avoid common pitfalls.

The repository follows clean architecture principles with a hybrid approach combining core infrastructure and feature-based organization. It uses GetX for state management, Get It for dependency injection, and incorporates custom utilities for Thai language support, encryption, and more. Always prioritize version consistency, testing, and separation of concerns.

## Product Overview

### Purpose and Target Users

UChat is a comprehensive messaging application designed for Thai users, providing a secure and feature-rich communication platform. The app supports:

- **Direct Messaging**: One-on-one conversations with real-time messaging
- **Group Chats**: Multi-user group conversations with admin controls
- **Secret Chats**: End-to-end encrypted conversations with enhanced privacy
- **Voice and Video Calls**: High-quality audio/video calling with LiveKit integration
- **Media Sharing**: Send and receive images, videos, audio, files, and stickers
- **Location Sharing**: Share real-time location with contacts
- **Contact Management**: Add, manage, and organize contacts
- **Profile Management**: Customize user profiles with display names, avatars, and status
- **Notifications**: Centralized notification system for all activities
- **Multi-platform Support**: Mobile (iOS/Android), Desktop (macOS, Windows, Linux), and Web

### Key Features

1. **Messaging Features**
   - Real-time messaging with Socket.IO
   - Message reactions and replies
   - Message pinning and bookmarking
   - Message search and filtering
   - Typing indicators and read receipts
   - Message status (sent, delivered, read, failed)

2. **Media and Content**
   - Image and video viewing with gallery integration
   - Audio recording and playback
   - File sharing and management
   - Sticker packs with custom animations
   - GIF support
   - Blurhash for image placeholders

3. **Communication**
   - Voice and video calls with LiveKit
   - Call history and logging
   - Incoming call notifications with CallKit integration
   - Speaker, microphone, and camera controls
   - Screen sharing capabilities

4. **Security and Privacy**
   - End-to-end encryption for secret chats
   - Passcode and biometric authentication
   - Privacy protection overlay
   - Message self-destruct timers
   - Secure file storage

5. **User Experience**
   - Thai language support with custom fonts
   - Dark and light themes
   - Responsive design for all platforms
   - Smooth animations with Lottie and Rive
   - Offline support with local caching

### Business Objectives and Metrics

**Primary Objectives:**
- Provide a secure, user-friendly messaging platform for Thai users
- Ensure cross-platform consistency and performance
- Maintain high reliability and uptime
- Protect user privacy and data security

**Key Metrics:**
- Message delivery success rate > 99.9%
- Call connection success rate > 95%
- App crash rate < 0.5%
- Average message delivery latency < 500ms
- User retention and engagement metrics
- App store ratings and feedback

## Technology Stack

### Core Technologies

**Flutter Version Management**
- **Tool**: FVM (Flutter Version Management)
- **Purpose**: Ensures consistent Flutter version across all team members
- **Usage**: Always use `fvm flutter` instead of `flutter` for all commands
- **Current SDK**: Dart SDK >=3.0.0 <4.0.0

**State Management**
- **GetX** (^4.3.8): Primary state management, navigation, and reactive programming
  - Controllers with `GetxController`
  - Reactive variables with `.obs` and `Rx` types
  - Navigation with `Get.to()`, `Get.back()`, etc.
  - Dependency injection with `Get.put()`, `Get.lazyPut()`
- **Get It** (^7.2.0): Service locator for dependency injection
  - Singleton registration with `registerLazySingleton()`
  - Factory registration with `registerFactory()`
  - Used alongside GetX for complex dependency graphs

**Data Persistence**
- **Isar Community** (^3.3.0-dev.3): Local NoSQL database
  - Fast, ACID-compliant database for offline storage
  - Custom URL: `isar-community.dev`
  - Used for messages, contacts, settings, and cached data
  - Code generation with `isar_community_generator`
- **Shared Preferences** (^2.0.6): Simple key-value storage
- **Get Storage** (^2.0.3): Fast key-value storage for settings

**Networking**
- **Dio** (^5.0.3): HTTP client for REST API calls
  - Interceptors for auth, logging, error handling
  - Request/response transformation
- **Socket.IO Client** (^3.0.0): WebSocket client for real-time communication
  - Real-time messaging
  - Call signaling
  - Presence and typing indicators

**Authentication**
- **Firebase Auth** (^6.0.2): User authentication
- **Google Sign In** (^6.2.1): Google OAuth integration
- **Sign in with Apple** (^7.0.1): Apple OAuth integration
- **Flutter Facebook Auth** (^7.1.1): Facebook OAuth integration

**Push Notifications**
- **OneSignal Flutter** (^5.2.2): Cross-platform push notifications
- **Firebase Cloud Messaging**: Fallback for iOS/Android

**Real-time Communication**
- **LiveKit Client**: Video/audio calling
  - Custom fork for specific features
  - WebRTC-based implementation
- **Flutter CallKit Incoming**: Native call UI integration

**Firebase Services**
- **Firebase Core** (^4.1.1): Base Firebase SDK
- **Firebase Analytics** (^12.0.2): User analytics and event tracking
- **Firebase Performance** (^0.11.1): App performance monitoring
- **Firebase Crashlytics** (^5.0.2): Crash reporting and analytics
- **Firebase Database** (^12.0.2): Real-time database for certain features

**Testing Framework**
- **Mocktail** (^1.0.4): Mocking framework
  - Type-safe mocks with `mocktail`
  - Given-When-Then pattern for tests
- **Flutter Test**: Built-in testing framework
- **Integration Test**: End-to-end testing

**Build Tools and Scripts**
- **Build Runner** (^2.4.13): Code generation for Isar, JSON serialization
- **Flutter Lints** (^6.0.0): Static analysis and linting
- **Husky** (^0.1.7): Git hooks for pre-commit checks
- **Custom Scripts**: Located in `.tools/` directory
  - `clean_rebuild.sh`: Complete clean and rebuild

**UI and Animation**
- **Lottie** (^3.0.0): JSON-based animations
- **Rive** (^0.13.1): Vector animations
- **Flutter Animate** (^4.5.2): Declarative animations
- **Extended Image** (^10.0.0): Advanced image loading with caching
- **Flutter Blurhash** (^0.9.1): Blur hash for image placeholders

**Media Handling**
- **Photo Manager** (^3.7.1): Gallery access and media selection
- **Video Player** (^2.2.18): Video playback
- **Audio Players** (^6.0.0): Audio playback
- **Image Picker** (^1.0.0): Camera and gallery image selection
- **Video Compress** (^3.1.2): Video compression

**Platform-Specific**
- **macOS**: Window manager, menu bar integration
- **Windows**: MSIX packaging with code signing
- **iOS/Android**: Native permissions, biometric auth, call integration

**Utilities**
- **Logger** (^2.6.1): Logging framework
- **Talker Flutter** (^5.0.1): Advanced logging and debugging
- **Sentry Flutter** (^9.9.1): Error tracking and monitoring
- **Connectivity Plus** (^7.0.0): Network connectivity monitoring

### Development Environment

**Required Tools:**
- FVM (Flutter Version Management)
- Flutter SDK (managed via FVM)
- Firebase CLI (for Firebase configuration)
- FlutterFire CLI (for Firebase integration)

**Environment Configuration:**
- `.env` file for environment variables
- Multiple environments: dev, sit, uat, prd
- Firebase projects per environment

## Code Structure and Architecture

### Hybrid Architecture Approach

UChat uses a hybrid architecture combining:
1. **Core Infrastructure** (`lib/core/`): Shared services, utilities, and cross-cutting concerns
2. **Feature-Based Organization** (`lib/features/`): Self-contained features with their own architecture

This approach provides:
- Clear separation between core infrastructure and business features
- Independent feature development and testing
- Reusable core components across features
- Scalable and maintainable codebase

### Core Architecture (`lib/core/`)

The core layer provides foundational services and utilities used across the application.

```
lib/core/
├── data/                          # Core data layer
│   ├── data_sources/              # Data sources (local/remote)
│   │   ├── account_service.dart
│   │   ├── common_service.dart
│   │   ├── local/
│   │   │   └── platform_document_local_data_source.dart
│   │   └── remote/
│   │       ├── app_version_http_data_source.dart
│   │       ├── backend_path.dart
│   │       └── platform_document_http_data_source.dart
│   ├── models/                    # Data models
│   │   └── enums/
│   │       ├── api_exception_type.dart
│   │       └── app_exception_type.dart
│   └── repositories/              # Repository implementations
│       ├── core_server_repository_impl.dart
│       ├── platform_document_repository_impl.dart
│       └── user_local_repository_impl.dart
├── domain/                        # Core domain layer
│   ├── entities/                  # Core entities
│   │   ├── enabled_country_list_entity.dart
│   │   ├── platform_document_entity.dart
│   │   ├── platform_document_version_entity.dart
│   │   ├── public_config_entity.dart
│   │   ├── share_bottom_sheet_data_entity.dart
│   │   ├── share_message_selection_entity.dart
│   │   ├── share_target_entity.dart
│   │   ├── user_entity.dart
│   │   └── version_entity.dart
│   └── use_cases/                # Core use cases
├── presentation/                  # Core presentation layer
│   ├── arguments/                 # Navigation arguments
│   ├── bindings/                 # Dependency injection bindings
│   ├── controllers/              # Core controllers
│   ├── services/                 # Presentation services
│   ├── theme/                    # App theming
│   ├── toast/                    # Toast notifications
│   └── widgets/                  # Reusable widgets
├── infrastructure/               # External integrations
│   ├── analytics/                # Analytics and monitoring
│   │   ├── call_performance_service.dart
│   │   ├── crashlytics_service.dart
│   │   ├── logger_service.dart
│   │   ├── performance_service.dart
│   │   ├── performance_tracing_service.dart
│   │   ├── screen_lag_notification_performance_service.dart
│   │   ├── taxonomy_service.dart
│   │   ├── implementation/
│   │   │   ├── amplitude_service_impl.dart
│   │   │   ├── screen_lag_contact_performance_service_impl.dart
│   │   │   ├── sending_msg_performance_service_impl.dart
│   │   │   └── taxonomy_empty_service_impl.dart
│   │   └── metric/
│   │       ├── duration.dart
│   │       ├── fps_monitor.dart
│   │       └── performance_trace.dart
│   ├── app/                      # App initialization
│   │   └── app.dart
│   ├── file_manager/             # File management
│   │   └── file_manager.dart
│   ├── notification/             # Notification system
│   │   ├── common/
│   │   │   ├── notification_entity.dart
│   │   │   ├── notification_onesignal_entity.dart
│   │   │   └── notification_type.dart
│   │   ├── debug/
│   │   │   ├── circular_buffer.dart
│   │   │   ├── message_state_entity.dart
│   │   │   ├── notification_debug_interface.dart
│   │   │   ├── notification_debug_toggle_service.dart
│   │   │   ├── notification_log_entity.dart
│   │   │   └── notification_logger.dart
│   │   └── implementation/
│   │       └── notification_onesignal_manager_impl.dart
│   └── orchestrator/            # App initialization orchestration
│       ├── config.dart
│       ├── orchestrator_type.dart
│       ├── orchestrator.dart
│       ├── common/
│       │   ├── task_group.dart
│       │   ├── task_result.dart
│       │   └── typedef.dart
│       ├── navigation/
│       │   ├── deep_link_handler.dart
│       │   ├── navigation_coordinator.dart
│       │   └── share_handler.dart
│       └── tasks/
│           ├── factory_dependencies.dart
│           ├── initialize_analytic.dart
│           ├── initialize_app.dart
│           ├── launch_app.dart
│           ├── on_authenticated.dart
│           ├── permanent_controller.dart
│           └── singleton_dependencies.dart
├── event_bus/                    # Event-driven communication
│   ├── event_bus.dart
│   ├── event_bus_impl.dart
│   ├── event_tracker.dart
│   ├── tracked_event_bus.dart
│   └── events/                  # Event definitions
│       ├── accept_request_event.dart
│       ├── add_failed_message_to_state_event.dart
│       ├── add_message_to_state_event.dart
│       ├── add_room_member_event.dart
│       ├── app_inactive_event.dart
│       ├── app_resumed_event.dart
│       ├── assign_admin_event.dart
│       ├── bookmark_tag_deleted_event.dart
│       ├── bookmark_tag_event.dart
│       ├── call_end_event.dart
│       ├── call_incoming_event.dart
│       ├── central_notification_lastseen_update_event.dart
│       ├── central_notification_update_event.dart
│       ├── chat_category_unread_update_event.dart
│       ├── check_email_or_password_not_set_event.dart
│       ├── close_expanded_text_event.dart
│       ├── close_slidable_panel_event.dart
│       ├── close_toast_force_delete_event.dart
│       ├── connectivity_changed_event.dart
│       ├── contact_delete_event.dart
│       ├── contact_list_require_refresh_event.dart
│       ├── contact_update_event.dart
│       ├── desktop_right_panel_change_event.dart
│       ├── file_downloader_progress_event.dart
│       ├── file_downloader_status_event.dart
│       ├── file_state_change_event.dart
│       ├── file_upload_progress_event.dart
│       ├── http_heartbeat_event.dart
│       ├── jump_to_message_event.dart
│       ├── lock_message_unlocked_event.dart
│       ├── maintenance_mode_update_event.dart
│       ├── message_list_attach_event.dart
│       ├── message_new_event.dart
│       ├── message_reaction_event.dart
│       ├── message_update_event.dart
│       ├── new_bookmark_tag_event.dart
│       ├── new_room_after_delete_event.dart
│       ├── notification_desktop_update_event.dart
│       ├── notification_opened_event.dart
│       ├── notification_received_event.dart
│       ├── oa_menu_publish_event.dart
│       ├── oa_menu_unpublish_event.dart
│       ├── on_room_selected_event.dart
│       ├── open_gallery_event.dart
│       ├── ownership_transferred_event.dart
│       ├── passcode_activate_event.dart
│       ├── passcode_checked_event.dart
│       ├── passcode_launch_event.dart
│       ├── passcode_prevent_event.dart
│       ├── passcode_timer_cancel_event.dart
│       ├── passcode_timer_trigger_event.dart
│       ├── passcode_update_event.dart
│       ├── passcode_verify_screen_shown_event.dart
│       ├── pin_message_event.dart
│       ├── play_new_message_animation_event.dart
│       ├── remove_room_member_event.dart
│       ├── reorder_sticker_event.dart
│       ├── require_friend_request_count_update_event.dart
│       ├── require_group_invite_update_event.dart
│       ├── reset_unread_count_local_event.dart
│       ├── revoke_admin_event.dart
│       ├── rich_menu_update_event.dart
│       ├── room_delete_event.dart
│       ├── room_list_require_cancel_db_update_subscribe_event.dart
│       ├── room_new_event.dart
│       ├── room_update_event.dart
│       ├── room_update_subscription_event.dart
│       ├── socket_connect_error_event.dart
│   ├── socket_connecting_event.dart
│   ├── socket_disconnected_event.dart
│   ├── socket_error_event.dart
│   ├── socket_packet_loss_event.dart
│   ├── sticker_animation_event.dart
│   ├── sticker_update_owner_event.dart
│   ├── sync_required_event.dart
│   ├── toggle_failed_message_event.dart
│   ├── ui_keyboard_update_event.dart
│   ├── unpin_all_message_event.dart
│   ├── unpin_message_event.dart
│   ├── update_admin_permission_event.dart
│   ├── update_image_local.dart
│   ├── update_room_member_event.dart
│   ├── user_after_sync_event.dart
│   ├── user_before_switch_event.dart
│   ├── user_expired_event.dart
│   ├── user_in_room_typing_event.dart
│   ├── user_logged_in_event.dart
│   ├── user_logged_out_event.dart
│   ├── user_update_event.dart
│   ├── video_file_compressing_progress_event.dart
│   ├── video_play_pause_event.dart
│   └── waiting_member_update_event.dart
├── exceptions/                   # Custom exceptions
├── extensions/                   # Dart extensions
├── services/                     # Core services
│   ├── messaging/
│   │   ├── message_queue_request_item.dart
│   │   └── message_queue_service.dart
│   └── sharing/
│       ├── sharing_service.dart
│       └── sharing_service_impl.dart
├── theme/                        # Theme configuration
├── utilities/                    # Utility functions
└── word_splitting/               # Thai word splitting
```

### Feature-Based Architecture (`lib/features/`)

Each feature is a self-contained module following Clean Architecture principles. Features are organized by business capability.

**Feature Structure Pattern:**

```
lib/features/{feature_name}/
├── {feature_name}_barrel.dart          # Public API exports
├── data/                               # Data layer
│   ├── data_source/
│   │   ├── local/                      # Local data sources (Isar, SharedPreferences)
│   │   │   └── {feature}_local_data_source.dart
│   │   └── remote/                     # Remote data sources (API, Socket)
│   │       ├── {feature}_api_service.dart
│   │       └── {feature}_socket_service.dart
│   ├── model/                          # Data models
│   │   ├── {feature}_model.dart
│   │   ├── {feature}_model.g.dart      # Generated code
│   │   └── collection/                 # Isar collections
│   │       ├── {feature}_collection.dart
│   │       └── {feature}_collection.g.dart
│   └── repository/                      # Repository implementations
│       ├── {feature}_local_repository_impl.dart
│       └── {feature}_server_repository_impl.dart
├── di/                                 # Dependency injection
│   └── {feature}_injection.dart       # GetIt registration
├── domain/                             # Domain layer
│   ├── {feature}_domain.dart           # Domain barrel file
│   ├── entities/                       # Business entities
│   │   └── {feature}_entity.dart
│   ├── param/                          # Use case parameters
│   │   ├── {operation}_param.dart
│   │   └── ...
│   ├── repository/                      # Repository interfaces
│   │   ├── {feature}_local_repository.dart
│   │   └── {feature}_server_repository.dart
│   └── use_cases/                      # Business logic
│       ├── {operation}_use_case.dart
│       └── ...
└── presentation/                       # Presentation layer
    ├── {feature}_presentation.dart     # Presentation barrel file
    ├── controller/                     # GetX controllers
    │   └── {feature}_controller.dart
    ├── view/                          # Screens and widgets
    │   ├── screens/
    │   │   ├── mobile/
    │   │   │   └── {feature}_screen.dart
    │   │   └── desktop/
    │   │       └── {feature}_screen.dart
    │   └── widgets/
    │       ├── {component}_widget.dart
    │       └── ...
    └── bindings/                       # GetX bindings
        └── {feature}_binding.dart
```

**Current Features:**

1. **accounts_center/** - Account management and settings
2. **add_contact/** - Adding new contacts
3. **album/** - Photo album management
4. **auth/** - Authentication flow
5. **cache_manager/** - Caching strategies
6. **call/** - Voice and video calling
   - Call signaling with Socket.IO
   - LiveKit integration for media
   - CallKit for native call UI
   - Call controls and UI components
7. **call_log/** - Call history
8. **central_notification/** - Centralized notification system
9. **chat_folder/** - Chat organization and folders
10. **chat_room/** - Chat room functionality
    - Direct, group, and secret chat controllers
    - Message input and handling
    - Media attachment handling
    - Pinning and bookmarking
11. **chat_room_detail/** - Chat room details and settings
12. **chat_room_list/** - Chat room listing and management
13. **coin/** - Virtual currency and payments
14. **contact/** - Contact management
15. **home/** - Home screen and navigation
16. **image_edit/** - Image editing functionality
17. **media/** - Media handling
    - Media viewer with zoom/pan
    - Audio preview
    - Media gallery integration
18. **media_gallery/** - Device gallery access
19. **notification_debug/** - Notification debugging tools
20. **profile/** - User profiles
    - Profile viewing and editing
    - Group profiles
    - Settings management
21. **report/** - Reporting functionality
22. **setting/** - App settings
23. **sticker/** - Sticker management
24. **sync/** - Data synchronization
25. **troubleshoot/** - Troubleshooting tools

### Relationship Between Core and Features

**Core provides:**
- Shared services (analytics, logging, notifications)
- Common utilities (encryption, Thai text handling)
- Event bus for cross-feature communication
- Infrastructure (database, networking, file management)
- App initialization and orchestration
- Theme and styling
- Reusable widgets

**Features provide:**
- Business logic and use cases
- Feature-specific data models and repositories
- UI components and screens
- Feature controllers and bindings
- Feature-specific services

**Communication:**
- Features use core services via dependency injection
- Features communicate via event bus (publish-subscribe pattern)
- Core doesn't depend on any feature
- Features can depend on other features through interfaces

### Clean Architecture Principles

**Layer Separation:**
1. **Domain Layer**: Pure business logic, no dependencies on other layers
   - Entities: Business objects
   - Use Cases: Application business rules
   - Repository Interfaces: Contracts for data access

2. **Data Layer**: Data access and external integrations
   - Models: Data transfer objects
   - Data Sources: Local (Isar, SharedPreferences) and Remote (API, Socket)
   - Repository Implementations: Concrete implementations of repository interfaces

3. **Presentation Layer**: UI and user interaction
   - Controllers: GetX controllers for state management
   - Views: Screens and widgets
   - Bindings: Dependency injection setup

**Dependency Rule:**
- Dependencies must point inward
- Domain layer has no dependencies
- Data layer depends on domain (implements interfaces)
- Presentation layer depends on domain (uses use cases)
- Infrastructure is used by all layers but doesn't depend on them

**Best Practices:**
- Use barrel files (`_barrel.dart`) to export public APIs
- Keep layers separated - no direct imports across layers
- Use dependency injection to wire dependencies
- Implement repository interfaces in data layer
- Use entities in domain, models in data layer
- Map between entities and models at repository boundaries

### State Management and Navigation

**GetX Controllers:**
```dart
import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  final RxBool isLoading = false.obs;
  
  final ChatRepository _repository;
  
  ChatController(this._repository);
  
  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }
  
  Future<void> loadMessages() async {
    isLoading.value = true;
    try {
      final result = await _repository.getMessages();
      messages.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}
```

**Get It Dependency Injection:**
```dart
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupDependencies() {
  // Repository
  locator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );
  
  // Use Case
  locator.registerFactory<GetMessagesUseCase>(
    () => GetMessagesUseCase(repository: locator()),
  );
  
  // Controller
  locator.registerFactory<ChatController>(
    () => ChatController(
      repository: locator(),
    ),
  );
}
```

**Navigation:**
```dart
// Navigate to screen
Get.to(() => ChatScreen());

// Navigate with arguments
Get.to(() => ChatScreen(), arguments: ChatArguments(roomId: '123'));

// Navigate and replace
Get.off(() => HomeScreen());

// Navigate and clear back stack
Get.offAll(() => LoginScreen());

// Navigate with named routes
Get.toNamed('/chat', arguments: {'roomId': '123'});
```

**Reactive UI:**
```dart
// Using Obx
Obx(() => Text(controller.message.value))

// Using GetX
GetX<ChatController>(
  builder: (controller) => Text(controller.message.value),
)

// Using GetBuilder
GetBuilder<ChatController>(
  builder: (controller) => Text(controller.message),
  init: ChatController(),
)
```

### Initialization and Orchestrator

The app uses an orchestrator pattern for multi-step initialization:

```
lib/core/infrastructure/orchestrator/
├── orchestrator.dart              # Main orchestrator
├── orchestrator_type.dart         # Task types
├── config.dart                   # Configuration
├── common/
│   ├── task_group.dart          # Task grouping
│   ├── task_result.dart         # Task result handling
│   └── typedef.dart             # Type definitions
├── navigation/
│   ├── deep_link_handler.dart   # Deep link processing
│   ├── navigation_coordinator.dart # Navigation setup
│   └── share_handler.dart      # Share intent handling
└── tasks/
    ├── initialize_analytic.dart # Analytics setup
    ├── initialize_app.dart     # Core initialization
    ├── launch_app.dart         # App launch
    ├── on_authenticated.dart   # Post-auth setup
    ├── permanent_controller.dart # Permanent controllers
    ├── singleton_dependencies.dart # Singleton services
    └── factory_dependencies.dart # Factory dependencies
```

**Initialization Flow:**
1. **Singleton Dependencies**: Register singleton services (database, API, etc.)
2. **Initialize App**: Core app setup (Firebase, analytics, etc.)
3. **Initialize Analytic**: Analytics and monitoring setup
4. **On Authenticated**: Post-authentication setup (user data, etc.)
5. **Launch App**: Navigate to initial screen
6. **Permanent Controllers**: Register controllers that live throughout app lifecycle

### Event-Driven Architecture

The event bus enables loose coupling between features:

```dart
// Publish event
eventBus.fire(MessageNewEvent(message: message));

// Subscribe to event
eventBus.on<MessageNewEvent>().listen((event) {
  // Handle event
});

// In a controller
@override
void onInit() {
  super.onInit();
  ever(eventBus.on<MessageNewEvent>(), (event) {
    handleMessage(event.message);
  });
}
```

**Common Events:**
- `MessageNewEvent`: New message received
- `MessageUpdateEvent`: Message updated
- `RoomNewEvent`: New room created
- `RoomUpdateEvent`: Room updated
- `CallIncomingEvent`: Incoming call
- `NotificationReceivedEvent`: Push notification received
- `ConnectivityChangedEvent`: Network status changed
- `UserLoggedInEvent`: User logged in
- `UserLoggedOutEvent`: User logged out

## Development Guidelines

### Naming Conventions

**Files and Directories:**
- Use snake_case for files and directories: `chat_room_controller.dart`
- Feature directories use singular form: `chat_room/`, not `chat_rooms/`
- Barrel files end with `_barrel.dart`: `chat_room_barrel.dart`

**Classes and Types:**
- Use PascalCase for classes: `ChatController`, `MessageEntity`
- Use PascalCase for enums: `MessageType`, `CallStatus`
- Use PascalCase for typedefs: `MessageCallback`, `ResultHandler`

**Variables and Functions:**
- Use camelCase for variables: `userName`, `isLoading`
- Use camelCase for functions: `sendMessage()`, `loadData()`
- Use lowercase with underscores for private members: `_privateMethod()`, `_privateField`

**Constants:**
- Use lowerCamelCase for local constants: `const maxRetries = 3`
- Use UPPER_SNAKE_CASE for global constants: `const API_BASE_URL = 'https://api.example.com'`

**Prefixes and Suffixes:**
- Use `I` prefix for interfaces: `IChatRepository` (optional, Dart doesn't require it)
- Use `Impl` suffix for implementations: `ChatRepositoryImpl`
- Use `Entity` suffix for domain entities: `MessageEntity`
- Use `Model` suffix for data models: `MessageModel`
- Use `UseCase` suffix for use cases: `SendMessageUseCase`
- Use `Controller` suffix for GetX controllers: `ChatController`
- Use `Binding` suffix for GetX bindings: `ChatBinding`
- Use `Service` suffix for services: `ChatService`
- Use `Helper` suffix for utilities: `EncryptionHelper`
- Use `Param` suffix for use case parameters: `SendMessageParam`

### File Organization

**Feature File Structure:**
```
lib/features/{feature}/
├── {feature}_barrel.dart          # Export public API
├── data/
│   ├── data_source/
│   │   ├── local/
│   │   │   └── {feature}_local_data_source.dart
│   │   └── remote/
│   │       ├── {feature}_api_service.dart
│   │       └── {feature}_socket_service.dart
│   ├── model/
│   │   ├── {feature}_model.dart
│   │   ├── {feature}_model.g.dart
│   │   └── collection/
│   │       ├── {feature}_collection.dart
│   │       └── {feature}_collection.g.dart
│   └── repository/
│       ├── {feature}_local_repository_impl.dart
│       └── {feature}_server_repository_impl.dart
├── di/
│   └── {feature}_injection.dart
├── domain/
│   ├── {feature}_domain.dart
│   ├── entities/
│   │   └── {feature}_entity.dart
│   ├── param/
│   │   ├── {operation}_param.dart
│   │   └── ...
│   ├── repository/
│   │   ├── {feature}_local_repository.dart
│   │   └── {feature}_server_repository.dart
│   └── use_cases/
│       ├── {operation}_use_case.dart
│       └── ...
└── presentation/
    ├── {feature}_presentation.dart
    ├── controller/
    │   └── {feature}_controller.dart
    ├── view/
    │   ├── screens/
    │   │   ├── mobile/
    │   │   │   └── {feature}_screen.dart
    │   │   └── desktop/
    │   │       └── {feature}_screen.dart
    │   └── widgets/
    │       ├── {component}_widget.dart
    │       └── ...
    └── bindings/
        └── {feature}_binding.dart
```

**Import Order:**
```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:convert';

// 2. Flutter SDK
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 3. Third-party packages
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';

// 4. Core imports
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

// 5. Feature imports
import 'package:uchat/features/chat/domain/entities/message_entity.dart';
import 'package:uchat/features/chat/domain/use_cases/send_message_use_case.dart';

// 6. Relative imports
import '../widgets/message_widget.dart';
```

### Layer Separation Rules

**Domain Layer:**
- **Can depend on**: Nothing (pure Dart)
- **Contains**: Entities, use cases, repository interfaces
- **Cannot contain**: UI code, data access, external dependencies
- **Example**:
  ```dart
  // Good
  class SendMessageUseCase {
    final ChatRepository _repository;
    
    SendMessageUseCase(this._repository);
    
    Future<void> call(MessageEntity message) async {
      await _repository.sendMessage(message);
    }
  }
  
  // Bad - UI code in domain
  class SendMessageUseCase {
    void showMessage() {
      Get.snackbar('Success', 'Message sent'); // ❌ No GetX in domain
    }
  }
  ```

**Data Layer:**
- **Can depend on**: Domain layer, external libraries
- **Contains**: Models, data sources, repository implementations
- **Cannot contain**: UI code, business logic
- **Example**:
  ```dart
  // Good
  class ChatRepositoryImpl implements ChatRepository {
    final ChatLocalDataSource _localDataSource;
    final ChatRemoteDataSource _remoteDataSource;
    
    ChatRepositoryImpl(this._localDataSource, this._remoteDataSource);
    
    @override
    Future<void> sendMessage(MessageEntity message) async {
      final model = MessageModel.fromEntity(message);
      await _remoteDataSource.sendMessage(model);
      await _localDataSource.saveMessage(model);
    }
  }
  
  // Bad - business logic in data layer
  class ChatRepositoryImpl implements ChatRepository {
    @override
    Future<void> sendMessage(MessageEntity message) async {
      if (message.text.isEmpty) { // ❌ Validation is domain logic
        throw Exception('Message cannot be empty');
      }
    }
  }
  ```

**Presentation Layer:**
- **Can depend on**: Domain layer, UI libraries
- **Contains**: Controllers, views, widgets
- **Cannot contain**: Data access, business logic
- **Example**:
  ```dart
  // Good
  class ChatController extends GetxController {
    final SendMessageUseCase _sendMessageUseCase;
    
    ChatController(this._sendMessageUseCase);
    
    Future<void> sendMessage(String text) async {
      final message = MessageEntity(text: text);
      await _sendMessageUseCase(message);
    }
  }
  
  // Bad - data access in presentation
  class ChatController extends GetxController {
    final Isar _isar; // ❌ Direct database access
    
    Future<void> sendMessage(String text) async {
      await _isar.writeTxn(() async {
        // ❌ Data access in controller
      });
    }
  }
  ```

### Thai Localization Considerations

**Font Support:**
- Use `notoSansThai` family for Thai text
- Use `notoSansThaiLooped` for connected Thai characters
- Use `BaiJamjuree` for headings and UI elements
- Use `Uchat` family for custom icons and branding

**Text Handling:**
```dart
// Thai text sanitization
import 'package:uchat/utils/thai_sanitizer.dart';

String sanitized = ThaiSanitizer.normalize(text);

// Thai word splitting
import 'package:uchat/core/word_splitting/thai_word_splitter.dart';

List<String> words = ThaiWordSplitter.split(text);
```

**Thai-Specific Considerations:**
- Tone marks and diacritics must be preserved
- Zero-width joiners for connected characters
- Proper line breaking for Thai text
- Thai numerals vs Arabic numerals
- Thai date and time formats

**Localization Files:**
- Located in `lib/lang/`
- Use ARB format for translations
- Support for English and Thai
- Context-aware translations for different UI contexts

**Example:**
```dart
// Using localized strings
import 'package:uchat/lang/app_localizations.dart';

Text(AppLocalizations.of(context)!.sendMessage)

// With parameters
Text(AppLocalizations.of(context)!.messageCount(count: 5))
```

### Code Quality Standards

**Linting Rules** (from `analysis_options.yaml`):
- `avoid_print` (error level): Use logging instead
- `prefer_single_quotes`: Use single quotes for strings
- `prefer_const_constructors`: Use const where possible
- `prefer_const_literals_to_create_immutables`: Use const for collections
- `prefer_final_fields`: Use final for immutable fields
- `avoid_unnecessary_containers`: Remove unnecessary widgets
- `use_key_in_widget_constructors`: Use keys for widgets with children

**Code Formatting:**
- Use `dart format` to format code
- Maximum line length: 80 characters
- Indentation: 2 spaces
- Trailing commas for multi-line parameters

**Documentation:**
- Use `///` for public API documentation
- Use `//` for inline comments
- Document complex algorithms
- Explain non-obvious decisions
- Keep comments up-to-date

**Error Handling:**
```dart
// Custom exceptions
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, {this.statusCode});
  
  @override
  String toString() => 'ApiException: $message';
}

// Usage in repository
try {
  final response = await dio.get('/messages');
  return MessageModel.fromJson(response.data);
} on DioException catch (e) {
  throw ApiException(
    'Failed to fetch messages',
    statusCode: e.response?.statusCode,
  );
}
```

### Testing Guidelines

**Test Structure:**
- Mirror source directory structure
- Place tests in `test/` directory
- Use descriptive test names
- Follow Given-When-Then pattern

**Example Test:**
```dart
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:uchat/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:uchat/features/chat/domain/entities/message_entity.dart';
import 'package:uchat/features/chat/domain/repository/chat_repository.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late SendMessageUseCase useCase;
  late MockChatRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRepository();
    useCase = SendMessageUseCase(mockRepository);
  });

  group('SendMessageUseCase', () {
    test('should send message successfully', () async {
      // Given
      final message = MessageEntity(
        id: '1',
        text: 'Hello',
        senderId: 'user1',
      );
      
      when(() => mockRepository.sendMessage(message))
          .thenAnswer((_) async {});

      // When
      await useCase(message);

      // Then
      verify(() => mockRepository.sendMessage(message)).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Given
      final message = MessageEntity(
        id: '1',
        text: 'Hello',
        senderId: 'user1',
      );
      
      when(() => mockRepository.sendMessage(message))
          .thenThrow(Exception('Network error'));

      // When & Then
      expect(
        () => useCase(message),
        throwsA(isA<Exception>()),
      );
    });
  });
}
```

**Running Tests:**
```bash
# Run all tests
fvm flutter test

# Run specific test file
fvm flutter test test/features/chat/domain/use_cases/send_message_use_case_test.dart

# Run with coverage
fvm flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

**Coverage Goals:**
- Aim for 100% coverage on critical paths
- Minimum 80% coverage overall
- Mock all external dependencies
- Test edge cases and error scenarios

## Development Environment Setup

### Flutter Version Management (FVM)

**Installation:**
```bash
# Install FVM
brew install fvm

# Install Flutter version
fvm install 3.19.0

# Use Flutter version
fvm use 3.19.0
```

**Usage:**
- **Rule**: Always use `fvm flutter` instead of `flutter` for all Flutter commands
- **Why?**: Ensures version consistency across the team
- **Example Commands**:
  ```bash
  fvm flutter pub get
  fvm flutter analyze
  fvm flutter test
  fvm flutter run
  fvm flutter build apk
  fvm flutter build ios
  ```

**Pitfall**: Running plain `flutter` commands may use a different version, leading to build errors or incompatible code.

### Scripts and Tools

**Location**: All development scripts are in the `.tools/` directory.

**Key Scripts:**

1. **clean_rebuild.sh**: Complete clean and rebuild
   ```bash
   ./.tools/clean_rebuild.sh
   ```
   - Runs Gradle clean (`./gradlew clean`)
   - Runs `fvm flutter pub get`
   - Runs iOS Pod install (`pod install` in `ios/`)

**Best Practice**: Run this script after dependency changes or before building to resolve caching issues.

**Making Scripts Executable:**
```bash
chmod +x .tools/*.sh
```

### Dependencies

**Version Overrides:**
Many packages in `pubspec.yaml` have version overrides to handle compatibility:
- WireGuard
- Protobuf
- UUID
- Get It
- Video Player
- Share Plus
- Super Clipboard
- Device Info Plus

**Do not remove or alter overrides without testing.**

**Database:**
- Uses Isar (from `isar-community.dev` custom URL) for local storage
- Refer to `lib/core/infrastructure/database/` for setup
- Code generation with `isar_community_generator`

**Custom Fonts:**
Extensive Thai font support in `pubspec.yaml`:
- `Uchat`: Custom brand font
- `notoSansThai`: Standard Thai font with multiple weights
- `notoSansThaiLooped`: Connected Thai characters
- `BaiJamjuree`: Modern Thai font for UI
- `PinMuteHideDelete`: Icon font

Ensure font loading in `lib/core/presentation/themes/`.

### Firebase Setup

**Installation:**
```bash
# Install Firebase CLI
brew install firebase-cli

# Login to Firebase
firebase login

# Install FlutterFire CLI
fvm flutter pub global activate flutterfire_cli
```

**Configuration:**

For dev:
```bash
flutterfire configure \
  --platforms="ios,android" \
  --project="uchat-dev-d3114" \
  --ios-bundle-id="social.uchat.messenger.dev" \
  --android-package-name="social.uchat.messenger.dev" \
  --yes
```

For sit:
```bash
flutterfire configure \
  --platforms="ios,android" \
  --project="uchat-dev-d3114" \
  --ios-bundle-id="social.uchat.messenger.sit" \
  --android-package-name="social.uchat.messenger.sit" \
  --yes
```

For uat:
```bash
flutterfire configure \
  --platforms="ios,android" \
  --project="uchat-dev-d3114" \
  --ios-bundle-id="social.uchat.messenger.uat" \
  --android-package-name="social.uchat.messenger.uat" \
  --yes
```

### Environment Configuration

**Environment Variables:**
- Stored in `.env` file at project root
- Loaded using `flutter_dotenv` package
- Different configurations for dev, sit, uat, prd

**Example `.env`:**
```env
API_BASE_URL=https://api-dev.uchat.com
SOCKET_URL=https://socket-dev.uchat.com
ONESIGNAL_APP_ID=your-app-id
FIREBASE_PROJECT_ID=uchat-dev-d3114
```

### Build Configuration

**Launcher Icons:**
```bash
fvm dart run flutter_launcher_icons
```

**Windows Installer:**
```bash
fvm dart run msix:create
```

**Code Generation:**
```bash
# Generate Isar code
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Build, Testing, and Linting

### Testing

**Structure:**
Tests mirror source paths (e.g., `test/features/chat/domain/use_cases/send_message_use_case_test.dart`). Not a flat `test/` directory.

**Framework:**
Use Mocktail for mocks with Given-When-Then pattern. Aim for 100% coverage.

**Example Test:**
```dart
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

test('User creation', () {
  // Given
  final mockRepo = MockUserRepository();
  when(() => mockRepo.getUser(id)).thenReturn(user);

  // When
  final result = userUseCase.getUser(id);

  // Then
  expect(result, user);
});
```

**Run Tests:**
```bash
fvm flutter test
```

**Pitfall**: Incomplete mocks can cause flaky tests; always verify interactions.

### Linting

**Rules** (in `analysis_options.yaml`):
- Strict `avoid_print` (error level): Use logging instead
- Prefer single quotes for strings
- Enforce `const` constructors

**Run Linter:**
```bash
fvm flutter analyze
```

**Best Practice**: Fix lint issues before commits; integrate with CI via `.github/workflows/`.

### Code Generation

**When to Run:**
- After adding new Isar entities
- After adding new JSON serializable models
- After modifying entity/model definitions

**Commands:**
```bash
# Single build
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (for development)
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Best Practices and Troubleshooting

### General Best Practices

**Version Control:**
- Commit atomic changes
- Use descriptive messages (e.g., "feat: add Thai sanitization utility")
- Follow conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, etc.
- Include issue numbers in commits: `feat: add chat search (#123)`

**Error Handling:**
- Use custom exceptions in `lib/api/error/` and `lib/core/exceptions/`
- Catch and handle in repositories/use cases
- Provide meaningful error messages
- Log errors for debugging

**Example:**
```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, {this.statusCode});
  
  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}
```

**Use Cases:**
- **Adding a feature**: Start in domain (entity/use case), implement data layer, then presentation
- **Refactoring**: Preserve 100% test coverage; update mirrors in `test/`
- **Bug fixing**: Write failing test first, then fix bug

**Integrations:**
- For external services (e.g., calls via WireGuard), check overrides in `pubspec.yaml`
- Use dependency injection for external services
- Mock external dependencies in tests

**Performance:**
- Use `const` constructors where possible
- Avoid unnecessary rebuilds with `const` widgets
- Use `ListView.builder` for long lists
- Implement pagination for large datasets
- Cache expensive computations
- Use `compute` for heavy processing

**Security:**
- Never hardcode sensitive data
- Use environment variables for configuration
- Implement proper authentication and authorization
- Validate all user inputs
- Use HTTPS for all network requests
- Encrypt sensitive data at rest

### Common Pitfalls and Troubleshooting

**Build Failures:**
- Run `.tools/clean_rebuild.sh` if Gradle/Pod issues arise
- Check Flutter version with `fvm flutter --version`
- Clear Flutter cache: `fvm flutter clean`
- Update dependencies: `fvm flutter pub upgrade`

**Font/Thai Issues:**
- Verify `pubspec.yaml` fonts
- Test on physical devices for rendering
- Check font family names match exactly
- Ensure font files are included in assets

**Dependency Conflicts:**
- Check overrides in `pubspec.yaml`
- Run `fvm flutter pub deps` to visualize dependencies
- Use `fvm flutter pub outdated` to check for updates
- Resolve conflicts by adjusting version constraints

**Testing Gaps:**
- If coverage <100%, add mocks for all external dependencies
- Use `fvm flutter test --coverage` to generate coverage
- Review coverage report in `coverage/html/index.html`

**Initialization Delays:**
- Profile orchestrator steps
- Offload heavy tasks (e.g., DB migration) asynchronously
- Use loading indicators during initialization
- Implement timeout mechanisms

**Memory Leaks:**
- Dispose controllers properly in `onClose()`
- Cancel stream subscriptions
- Close database connections
- Use `Get.delete()` to remove controllers when not needed

**State Management Issues:**
- Use `ever()` for one-time subscriptions
- Use `debounce()` for frequent updates
- Use `interval()` for periodic updates
- Avoid nested reactive variables

**Platform-Specific Issues:**
- Test on all target platforms (iOS, Android, Desktop, Web)
- Check platform-specific permissions
- Verify native integrations (CallKit, biometrics, etc.)
- Test on different screen sizes

**Performance Issues:**
- Use Flutter DevTools for profiling
- Check for unnecessary rebuilds with `RepaintBoundary`
- Optimize image loading with caching
- Use `ListView.builder` instead of `Column` for lists
- Implement lazy loading for large datasets

**Network Issues:**
- Implement retry logic for failed requests
- Use proper timeout values
- Handle connectivity changes
- Cache responses when appropriate
- Use exponential backoff for retries

### Debugging Tools

**Flutter DevTools:**
```bash
fvm flutter pub global activate devtools
fvm flutter pub global run devtools
```

**Logging:**
```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter();

// Log info
talker.info('Message sent');

// Log error
talker.error('Failed to send message', error, stackTrace);

// Log debug
talker.debug('Current state: ${controller.state.value}');
```

**Sentry Integration:**
```dart
import 'package:sentry_flutter/sentry_flutter.dart';

try {
  // Your code
} catch (exception, stackTrace) {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
  );
}
```

**Talker Dio Logger:**
```bash
# Enable in development
talkerDioLogger.attach(dio);
```

## Additional Resources

**Documentation:**
- `README.md`: Project overview and setup
- `CLAUDE.md`: Claude-specific guidelines
- `.github/`: CI/CD workflows and issue templates

**Internal Documentation:**
- `docs/`: Additional project documentation
- `plans/`: Feature plans and specifications

**Community Resources:**
- Flutter documentation: https://flutter.dev/docs
- GetX documentation: https://github.com/jonataslaw/getx
- Isar documentation: https://isar.dev
- Mocktail documentation: https://pub.dev/packages/mocktail

**Support:**
- Open an issue in `.github/` for bugs or questions
- Contact the development team for urgent issues

---

**Last Updated: 2025-02-05**
