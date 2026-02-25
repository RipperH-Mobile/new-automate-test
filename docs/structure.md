# Structure

The following is the project folder structure (only the folders under lib are introduced)

## Overview

UChat Messenger Flutter follows a feature-first organization with a Clean Architecture approach. The application is structured to promote separation of concerns, maintainability, and testability.

```
lib/
├── api/                      # Core API communication layer
├── constants/                # Application-wide constants
├── controllers/              # Global controllers
├── core/                     # Core functionality and utilities
├── di/                       # Dependency injection
├── entities/                 # Shared domain entities
├── events/                   # Application-wide events
├── features/                 # Feature modules
├── firebase/                 # Firebase configuration
├── gen/                      # Generated asset code
├── lang/                     # Localization
├── routes/                   # Navigation routes
├── themes/                   # Theme and styling
├── use_cases/                # Shared use cases
├── utils/                    # Utility functions
└── widgets/                  # Shared widgets
```

For a comprehensive guide to our architecture, refer to our [Clean Architecture Guide](./clean_architecture_guide.md).

## Core folder

The core folder contains foundational components used across the application. It follows the same clean architecture structure as features.

For detailed documentation on core components:
- [Infrastructure](./core/infrastructure.md) - Low-level services including the orchestrator, analytics, and notification systems
- [Orchestrator](./core/orchestrator.md) - Detailed explanation of the application initialization and task coordination system

```
core/
├── cupertino_context_menu/                    # Custom implementation of Cupertino context menu
│   ├── cupertino_context_menu.dart
│   ├── cupertino_context_menu_widget.dart
│   ├── cupertino_context_menu_widget_expanded.dart
│   └── render_box.dart
│
├── data/                                      # Data layer of core components
│   ├── data_sources/                          # Data sources for core functionality
│   │   ├── account_service.dart
│   │   └── common_service.dart
│   ├── models/                                # Data models for core functionality
│   │   ├── enums/                             # Enums used in data layer
│   │   │   ├── api_exception_type.dart
│   │   │   └── sort_room_sub_by.dart
│   │   └── responses/                         # API response models
│   │       ├── get_enabled_country_list_response.dart
│   │       └── get_public_config_response.dart
│   └── repositories/                          # Repository implementations
│       ├── core_server_repository_impl.dart
│       └── user_local_repository_impl.dart
│
├── di/                                        # Dependency injection for core module
│   ├── analytic_injection.dart
│   ├── core_injection.dart
│   └── orchestrator_injection.dart
│
├── domain/                                    # Domain layer of core components
│   ├── entities/                              # Core business entities
│   │   ├── enabled_country_list_entity.dart
│   │   ├── public_config_entity.dart
│   │   ├── share_bottom_sheet_data_entity.dart
│   │   ├── share_message_selection_entity.dart
│   │   ├── share_target_entity.dart
│   │   └── user_entity.dart
│   ├── params/                                # Parameters for use cases
│   │   ├── app_share_bottom_sheet_share_param.dart
│   │   ├── get_chat_room_for_share_param.dart
│   │   └── share_image_from_album_param.dart
│   ├── repositories/                          # Repository interfaces
│   │   ├── core_server_repository.dart
│   │   └── user_local_repository.dart
│   ├── services/                              # Domain services
│   │   └── native_method_channel_service.dart
│   └── use_cases/                             # Core use cases
│       ├── app_share_bottom_sheet_share_use_case.dart
│       ├── get_chat_room_for_share_use_case.dart
│       ├── get_enabled_country_list_use_case.dart
│       └── get_public_config_use_case.dart
│
├── exceptions/                                # Application-wide exceptions
│   ├── api_deprecated_exception.dart
│   ├── api_exception.dart
│   ├── api_friend_limit_exceed_exception.dart
│   ├── api_state_limit_exceed_exception.dart
│   ├── api_state_null_exception.dart
│   ├── api_unauthorized_exception.dart
│   ├── api_validation_exception.dart
│   ├── app_exception.dart
│   ├── error_account_action_token_expired.dart
│   ├── error_account_baned_exception.dart
│   ├── error_account_invalid_otp_token.dart
│   ├── error_account_otp_cooldown.dart
│   ├── error_account_otp_expired.dart
│   ├── error_user_not_found_exception.dart
│   ├── exception_handler.dart
│   ├── exceptions.dart
│   ├── failed_host_lookup_exception.dart
│   ├── invalid_token_exception.dart
│   ├── no_permission_exception.dart
│   ├── null_response_exception.dart
│   ├── service_on_maintenance_mode_exception.dart
│   ├── socket_connection_exception.dart
│   ├── socket_handshake_exception.dart
│   ├── socket_io_exception.dart
│   ├── socket_timeout_exception.dart
│   └── socket_unknown_exception.dart
│
├── extensions/                                # Extension methods
│   └── theme_extensions.dart
│
├── infrastructure/                            # Infrastructure components
│   ├── analytics/                             # Analytics and logging
│   │   ├── crashlytics_service.dart
│   │   ├── logger/                            # Logging implementation
│   │   │   ├── filter.dart
│   │   │   ├── message.dart
│   │   │   └── output.dart
│   │   ├── logger_service.dart
│   │   ├── metric/                            # Performance metrics
│   │   │   ├── duration.dart
│   │   │   └── performance_trace.dart
│   │   └── performance_service.dart
│   ├── app/                                   # Application infrastructure
│   │   └── app.dart
│   ├── notification/                          # Notification infrastructure
│   │   └── one_signal.dart
│   └── orchestrator/                          # Application initialization orchestrator
│       ├── common/                            # Shared components for orchestrator
│       │   ├── task_group.dart
│       │   └── typedef.dart
│       ├── config.dart
│       ├── navigation/                        # Navigation coordination
│       │   ├── deep_link_handler.dart
│       │   ├── navigation_coordinator.dart
│       │   └── share_handler.dart
│       ├── orchestrator.dart
│       ├── orchestrator_type.dart
│       └── tasks/                             # Orchestrator initialization tasks
│           ├── factory_dependencies.dart
│           ├── initialize_analytic.dart
│           ├── initialize_app.dart
│           ├── launch_app.dart
│           ├── on_authenticated.dart
│           ├── permanent_controller.dart
│           └── singleton_dependencies.dart
│
├── presentation/                              # Presentation layer of core components
│   ├── controllers/                           # Shared controllers
│   │   └── app_share_bottom_sheet_controller.dart
│   └── widgets/                               # Shared widgets
│       ├── app_outlined_button.dart
│       ├── app_primary_button.dart
│       ├── app_search_box.dart
│       ├── app_share_bottom_sheet.dart
│       ├── share_check_box_tile.dart
│       └── share_selected_preview.dart
│
├── services/                                  # Core services
│   ├── messaging/                             # Messaging services
│   │   └── message_queue_service.dart
│   └── social_auth_provider/                  # Social authentication providers
│       ├── apple_auth_service.dart
│       └── google_auth_service.dart
│
├── theme/                                     # Application theming system
│   ├── app_colors_theme.dart
│   ├── app_radius.dart
│   ├── app_shadow.dart
│   ├── app_size.dart
│   ├── app_space.dart
│   ├── app_text_theme.dart
│   ├── app_theme.dart
│   ├── app_theme_config.dart
│   └── example.dart
│
├── toast/                                     # Toast notifications system
│   ├── app_toast.dart
│   ├── toast_with_undo.dart
│   └── toast_with_undo_controller.dart
│
└── utilities/                                 # Utility functions
    └── mongo_id_generator.dart
```

## Features folder

The features folder contains all the application's features, with each feature organized in a Clean Architecture structure.

```
feature_name/
        ├── data/                                               # Data layer of the feature
        │   ├── data_sources/
        │   │   ├── local/
        │   │   │   └── feature_name_local_datasource.dart
        │   │   └── remote/
        │   │       ├── feature_name_http_datasource.dart
        │   │       └── feature_name_socket_datasource.dart
        │   │
        │   ├── models/
        │   │   ├── payloads/
        │   │   │   ├── create_feature_name_payload.dart
        │   │   │   └── update_feature_name_payload.dart
        │   │   └── collections/
        │   │       └── feature_name_collection.dart
        │   │
        │   └── repositories/
        │       └── feature_name_repository_impl.dart
        │
        │── di/
        │   └── feature_injection.dart                      # Dependency injection for the feature
        │
        ├── domain/                                         # Domain layer of the feature
        │   ├── services/
        │   │   └── feature_name_service.dart               # Stateful service for the feature, singleton
        │   ├── entities/
        │   │   └── feature_name_entity.dart
        │   ├── enums/
        │   │   └── feature_name_enum.dart
        │   ├── events/
        │   │   └── create_feature_name_events.dart
        │   ├── exceptions/
        │   │   ├── create_feature_name_exception.dart
        │   │   └── update_feature_name_exception.dart
        │   ├── repositories/
        │   │   └── feature_name_repository.dart
        │   ├── use_cases/                                  # Use cases for the feature, all use by get it factory
        │   │   ├── get_feature_name_use_cases.dart
        │   │   └── update_feature_name_use_cases.dart
        │   └── typedefs.dart                               # typedefs for the feature
        │
        └── presentation/                                   # Presentation layer of the feature
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