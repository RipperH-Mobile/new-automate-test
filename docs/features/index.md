# Practice for Feature Folder

## Introduction

UChat Messenger follows a partial Clean Architecture approach to organize its codebase. This architecture separates code into layers with clear responsibilities, promoting maintainability, testability, and scalability.

For a comprehensive overview of our Clean Architecture implementation, please refer to the [Clean Architecture Guide](../clean_architecture_guide.md).

## Flow

The typical flow of data and control in our architecture follows this pattern:

```
Presentation layer -> Domain layer -> Data layer
```

1. **User Interaction**: User interacts with the UI in the Presentation layer
2. **Controller**: Handles the interaction and calls appropriate Use Case
3. **Use Case**: Executes business logic using Repository interfaces
4. **Repository Implementation**: Coordinates data operations between data sources
5. **Data Source**: Retrieves or stores data
6. **Return Path**: Data flows back through the same path, transformed for UI presentation

## Layered Architecture (Partial Clean Architecture)

### For Data Layer
Please refer to [data layer](data_layer.md) for more details.

### For Domain Layer
Please refer to [domain layer](domain_layer.md) for more details.

### For Presentation Layer
Please refer to [presentation layer](presentation_layer.md) for more details.

## Custom Rules

1. **Exception Handling**: Do not use Either for exception handling. Use normal exception handling (throw error and try...catch) instead.

2. **Layer Independence**: Higher layers should not depend on lower layers:
   - Domain layer should not import anything from data or presentation layers
   - Presentation layer can import from domain layer but not data layer

3. **Feature-First Organization**: Code is organized by feature first, then by layer:
   ```
   features/
     ├── auth/
     │   ├── data/
     │   ├── domain/
     │   └── presentation/
     ├── chat/
     │   ├── data/
     │   ├── domain/
     │   └── presentation/
     └── user_profile/
         ├── data/
         ├── domain/
         └── presentation/
   ```

4. **Use Case Parameters**: Parameters for use cases are defined in the use case file, not in separate files.

5. **Repository Interfaces**: Repository interfaces are defined in the domain layer and implemented in the data layer.

6. **Testing Requirements**: All code requires 100% test coverage with appropriate unit tests.

## Getting Started with a New Feature

When developing a new feature, follow these steps:

1. **Define Domain Entities**: Start by defining the core domain entities for your feature
2. **Create Repository Interface**: Define the data operations needed for your feature
3. **Implement Use Cases**: Create use cases for each user action or system operation
4. **Implement Data Layer**: Create repositories, data sources, and models
5. **Create UI**: Develop controllers, screens, and widgets for user interaction
6. **Write Tests**: Ensure all layers are properly tested

For more guidance on implementing each part of the architecture, refer to the specific layer documentation linked above.

## Common Patterns and Best Practices

1. **Dependency Injection**: Use GetIt for dependency injection across all layers
2. **State Management**: Use GetX for reactive state management
3. **Navigation**: Use named routes with GetX for screen navigation
4. **Error Handling**: Use domain-specific exceptions and proper error handling in controllers
5. **Modular Design**: Keep features independent and modular
6. **Code Generation**: Use code generation tools when appropriate for repetitive patterns