---
name: flutter-clean-arch-code
description: Generate and scaffold new features following Clean Architecture principles for Flutter with GetX and Get It. Use this skill when creating new features, adding domain logic, implementing data repositories, or building presentation layers in the UChat Messenger project.
---

# Flutter Clean Architecture Code Skill

## Overview

This skill provides comprehensive guidance for implementing new features in the UChat Messenger Flutter project following Clean Architecture principles. The project uses GetX for state management, Get It for dependency injection, and Isar for local storage.

## Clean Architecture Principles

### Three-Layer Architecture

The UChat Messenger follows Clean Architecture with three distinct layers:

1. **Domain Layer** (`lib/features/{feature}/domain/`)
   - Contains business logic and rules
   - Independent of frameworks and external dependencies
   - Defines entities (pure data models) and use cases
   - Declares repository interfaces

2. **Data Layer** (`lib/features/{feature}/data/`)
   - Implements repository interfaces from domain
   - Handles data sources (remote API, local database)
   - Contains models for data transformation
   - Manages data fetching, caching, and persistence

3. **Presentation Layer** (`lib/features/{feature}/presentation/`)
   - Contains UI components (screens, widgets)
   - Manages state with GetX controllers
   - Handles user interactions and navigation
   - Observes use cases and updates UI reactively

### Dependency Flow

```
Presentation → Domain ← Data
```

- **Presentation** depends on **Domain** (use cases, entities)
- **Data** implements **Domain** (repositories)
- **Presentation** NEVER depends on **Data** directly
- **Domain** is independent and has no dependencies on other layers

## Feature Scaffolding Instructions

### Step 1: Create Feature Directory Structure

```bash
# Create the feature directory with all required subdirectories
mkdir -p lib/features/{feature_name}/{domain,data,presentation}/{entities,repositories,use_cases,models,data_sources,controllers,views,widgets,arguments,bindings,di}
```

### Step 2: Domain Layer Implementation

#### 2.1 Create Entity

File: `lib/features/{feature_name}/domain/entities/{feature_name}_entity.dart`

```dart
class {FeatureName}Entity {
  final String id;
  final String name;
  final DateTime createdAt;
  final bool isActive;

  const {FeatureName}Entity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.isActive = true,
  });

  {FeatureName}Entity copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return {FeatureName}Entity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  factory {FeatureName}Entity.fromJson(Map<String, dynamic> json) {
    return {FeatureName}Entity(
      id: json['_id'] ?? json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}
```

#### 2.2 Create Repository Interface

File: `lib/features/{feature_name}/domain/repositories/{feature_name}_repository.dart`

```dart
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';

abstract class {FeatureName}Repository {
  Future<{FeatureName}Entity?> getById(String id);
  Future<List<{FeatureName}Entity>> getAll();
  Future<void> save({FeatureName}Entity entity);
  Future<void> delete(String id);
}
```

#### 2.3 Create Use Case

File: `lib/features/{feature_name}/domain/use_cases/get_{feature_name}_use_case.dart`

```dart
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';
import 'package:uchat/features/{feature_name}/domain/repositories/{feature_name}_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class Get{FeatureName}UseCase extends SimpleUseCase<{FeatureName}Entity?, String> {
  final {FeatureName}Repository repository;

  Get{FeatureName}UseCase({
    required this.repository,
  });

  @override
  Future<{FeatureName}Entity?> call(String id) async {
    return repository.getById(id);
  }
}
```

### Step 3: Data Layer Implementation

#### 3.1 Create Isar Collection (if using local storage)

File: `lib/features/{feature_name}/data/models/collections/{feature_name}_collection.dart`

```dart
import 'package:isar/isar.dart';
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';

part '{feature_name}_collection.g.dart';

@Collection()
class {FeatureName}Collection {
  final Id id = Isar.autoIncrement;
  late String dbId;
  late String name;
  late DateTime createdAt;
  late bool isActive;

  {FeatureName}Collection();

  factory {FeatureName}Collection.fromEntity({FeatureName}Entity entity) {
    return {FeatureName}Collection()
      ..dbId = entity.id
      ..name = entity.name
      ..createdAt = entity.createdAt
      ..isActive = entity.isActive;
  }

  {FeatureName}Entity toEntity() {
    return {FeatureName}Entity(
      id: dbId,
      name: name,
      createdAt: createdAt,
      isActive: isActive,
    );
  }
}
```

#### 3.2 Create Data Source Interface

File: `lib/features/{feature_name}/data/data_sources/{feature_name}_data_source.dart`

```dart
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';

abstract class {FeatureName}DataSource {
  Future<{FeatureName}Entity?> getFromRemote(String id);
  Future<List<{FeatureName}Entity>> getAllFromRemote();
  Future<{FeatureName}Entity?> getFromLocal(String id);
  Future<void> saveToLocal({FeatureName}Entity entity);
}
```

#### 3.3 Implement Data Source

File: `lib/features/{feature_name}/data/data_sources/remote/{feature_name}_http_service.dart`

```dart
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/{feature_name}/data/data_sources/{feature_name}_data_source.dart';
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';

class {FeatureName}HttpService implements {FeatureName}DataSource {
  final HttpCaller httpCaller;
  final LoggerService log;

  {FeatureName}HttpService({
    required this.httpCaller,
    required this.log,
  });

  @override
  Future<{FeatureName}Entity?> getFromRemote(String id) async {
    try {
      final response = await httpCaller.get('/api/{feature_name}/$id');
      if (response.statusCode == 200) {
        return {FeatureName}Entity.fromJson(response.data);
      }
      return null;
    } catch (e, stackTrace) {
      log.e('Failed to fetch {feature_name} from remote', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<{FeatureName}Entity>> getAllFromRemote() async {
    try {
      final response = await httpCaller.get('/api/{feature_name}');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => {FeatureName}Entity.fromJson(json)).toList();
      }
      return [];
    } catch (e, stackTrace) {
      log.e('Failed to fetch all {feature_name}s from remote', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<{FeatureName}Entity?> getFromLocal(String id) {
    // Implementation for local data source
    throw UnimplementedError();
  }

  @override
  Future<void> saveToLocal({FeatureName}Entity entity) {
    // Implementation for local data source
    throw UnimplementedError();
  }
}
```

#### 3.4 Implement Repository

File: `lib/features/{feature_name}/data/repositories/{feature_name}_repository_impl.dart`

```dart
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/features/{feature_name}/data/data_sources/{feature_name}_data_source.dart';
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';
import 'package:uchat/features/{feature_name}/domain/repositories/{feature_name}_repository.dart';

class {FeatureName}RepositoryImpl implements {FeatureName}Repository {
  final {FeatureName}DataSource dataSource;

  {FeatureName}RepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<{FeatureName}Entity?> getById(String id) async {
    try {
      // Try local first, then remote
      final local = await dataSource.getFromLocal(id);
      if (local != null) {
        return local;
      }

      final remote = await dataSource.getFromRemote(id);
      if (remote != null) {
        await dataSource.saveToLocal(remote);
        return remote;
      }

      return null;
    } catch (e, stackTrace) {
      throw DataFetchException('Failed to get {feature_name} by id: $id', e, stackTrace);
    }
  }

  @override
  Future<List<{FeatureName}Entity>> getAll() async {
    try {
      return await dataSource.getAllFromRemote();
    } catch (e, stackTrace) {
      throw DataFetchException('Failed to get all {feature_name}s', e, stackTrace);
    }
  }

  @override
  Future<void> save({FeatureName}Entity entity) async {
    try {
      await dataSource.saveToLocal(entity);
    } catch (e, stackTrace) {
      throw DataSaveException('Failed to save {feature_name}', e, stackTrace);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      // Implement delete logic
    } catch (e, stackTrace) {
      throw DataDeleteException('Failed to delete {feature_name}', e, stackTrace);
    }
  }
}
```

### Step 4: Presentation Layer Implementation

#### 4.1 Create Arguments (if needed)

File: `lib/features/{feature_name}/presentation/arguments/{feature_name}_arguments.dart`

```dart
class {FeatureName}Arguments {
  final String id;
  final String? additionalData;

  const {FeatureName}Arguments({
    required this.id,
    this.additionalData,
  });
}
```

#### 4.2 Create Controller with GetX

File: `lib/features/{feature_name}/presentation/controllers/{feature_name}_controller.dart`

```dart
import 'package:get/get.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';
import 'package:uchat/features/{feature_name}/domain/use_cases/get_{feature_name}_use_case.dart';

class {FeatureName}Controller extends GetxController {
  final String id;
  final LoggerService log;
  final Get{FeatureName}UseCase get{FeatureName}UseCase;

  {FeatureName}Controller({
    required this.id,
    required this.log,
    required this.get{FeatureName}UseCase,
  });

  // Reactive state using Rx observables
  final Rxn<{FeatureName}Entity> entity = Rxn<{FeatureName}Entity>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Computed properties
  bool get hasError => errorMessage.value.isNotEmpty;
  bool get hasData => entity.value != null;

  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await get{FeatureName}UseCase.call(id);
      entity.value = result;
      
      if (result == null) {
        errorMessage.value = '{FeatureName} not found';
      }
    } catch (e, stackTrace) {
      log.e('Failed to load {feature_name}', e, stackTrace);
      errorMessage.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }

  void refresh() {
    loadData();
  }

  void clearError() {
    errorMessage.value = '';
  }
}
```

#### 4.3 Create Binding

File: `lib/features/{feature_name}/presentation/bindings/{feature_name}_binding.dart`

```dart
import 'package:get/get.dart';
import 'package:uchat/features/{feature_name}/presentation/controllers/{feature_name}_controller.dart';
import 'package:uchat/features/{feature_name}/presentation/arguments/{feature_name}_arguments.dart';

class {FeatureName}Binding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as {FeatureName}Arguments?;
    
    Get.lazyPut<{FeatureName}Controller>(
      () => {FeatureName}Controller(
        id: args?.id ?? '',
        log: Get.find(),
        get{FeatureName}UseCase: Get.find(),
      ),
    );
  }
}
```

#### 4.4 Create Screen

File: `lib/features/{feature_name}/presentation/views/screens/mobile/{feature_name}_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/{feature_name}/presentation/controllers/{feature_name}_controller.dart';

class {FeatureName}Screen extends GetView<{FeatureName}Controller> {
  const {FeatureName}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('{FeatureName}'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refresh,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: context.theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refresh,
                  child: Text('Retry'.tr),
                ),
              ],
            ),
          );
        }

        if (!controller.hasData) {
          return Center(
            child: Text(
              'No data available'.tr,
              style: context.theme.textTheme.bodyLarge,
            ),
          );
        }

        return _buildContent(context);
      }),
    );
  }

  Widget _buildContent(BuildContext context) {
    final entity = controller.entity.value!;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entity.name,
            style: context.theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Created: ${entity.createdAt}'.tr,
            style: context.theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Status: ${entity.isActive ? "Active" : "Inactive"}'.tr,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: entity.isActive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
```

#### 4.5 Create Reusable Widgets (if needed)

File: `lib/features/{feature_name}/presentation/widgets/{feature_name}_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/{feature_name}/domain/entities/{feature_name}_entity.dart';

class {FeatureName}Card extends StatelessWidget {
  final {FeatureName}Entity entity;
  final VoidCallback? onTap;

  const {FeatureName}Card({
    super.key,
    required this.entity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.name,
                      style: context.theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Created: ${_formatDate(entity.createdAt)}',
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              _buildStatusIndicator(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: entity.isActive ? Colors.green : Colors.red,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

### Step 5: Dependency Injection

File: `lib/features/{feature_name}/di/{feature_name}_injection.dart`

```dart
import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/{feature_name}/data/data_sources/{feature_name}_data_source.dart';
import 'package:uchat/features/{feature_name}/data/data_sources/remote/{feature_name}_http_service.dart';
import 'package:uchat/features/{feature_name}/data/repositories/{feature_name}_repository_impl.dart';
import 'package:uchat/features/{feature_name}/domain/repositories/{feature_name}_repository.dart';
import 'package:uchat/features/{feature_name}/domain/use_cases/get_{feature_name}_use_case.dart';

///
/// Initialize {FeatureName} singleton Dependencies
///
Future<void> register{FeatureName}SingletonDependencies({
  required HttpCaller httpCaller,
}) async {
  final getIt = GetIt.instance;

  // Register Data Sources
  getIt.registerLazySingleton<{FeatureName}DataSource>(
    () => {FeatureName}HttpService(
      httpCaller: httpCaller,
      log: getIt<LoggerService>(),
    ),
  );

  // Register Repositories
  getIt.registerLazySingleton<{FeatureName}Repository>(
    () => {FeatureName}RepositoryImpl(
      dataSource: getIt<{FeatureName}DataSource>(),
    ),
  );
}

///
/// Initialize {FeatureName} factory Dependencies
///
Future<void> register{FeatureName}FactoryDependencies({
  required {FeatureName}Repository repository,
}) async {
  final getIt = GetIt.instance;

  // Register Use Cases
  getIt.registerFactory<Get{FeatureName}UseCase>(
    () => Get{FeatureName}UseCase(
      repository: repository,
    ),
  );
}
```

### Step 6: Register Routes

Add to your routing configuration (e.g., `lib/routes/app_pages.dart`):

```dart
import 'package:uchat/features/{feature_name}/presentation/bindings/{feature_name}_binding.dart';
import 'package:uchat/features/{feature_name}/presentation/views/screens/mobile/{feature_name}_screen.dart';

// In GetPages list
GetPage(
  name: Routes.{FEATURE_NAME},
  page: () => const {FeatureName}Screen(),
  binding: {FeatureName}Binding(),
),
```

## GetX Integration

### Reactive State Management

Use Rx observables for reactive state:

```dart
// In controller
final RxInt counter = 0.obs;
final RxList<String> items = <String>[].obs;
final Rxn<User> currentUser = Rxn<User>();

// Update values
counter.value++; // Triggers rebuild
items.add('new item');
currentUser.value = newUser;

// Computed properties
bool get hasUser => currentUser.value != null;
String get userName => currentUser.value?.name ?? 'Guest';
```

### Reactive UI with Obx

```dart
Obx(() => Text('Count: ${controller.counter.value}'))

// Multiple observables
Obx(() {
  if (controller.isLoading.value) {
    return CircularProgressIndicator();
  }
  return Text('Data: ${controller.data.value}');
})

// GetBuilder for less reactive scenarios
GetBuilder<Controller>(
  builder: (controller) => Text('Value: ${controller.value}'),
)
```

### Worker Methods

```dart
// Called whenever value changes
ever(counter, (value) => print('Counter changed: $value'));

// Called once when value becomes true
once(isLoggedIn, (value) => navigateToHome());

// Debounced (called after delay)
debounce(searchQuery, (query) => performSearch(query), time: Duration(milliseconds: 500));

// Interval (called repeatedly)
interval(timer, (value) => updateTimer(), time: Duration(seconds: 1));
```

## Isar Integration

### Define Collection

```dart
@Collection()
class MyCollection {
  final Id id = Isar.autoIncrement;
  
  @Index()
  late String name;
  
  @Index(unique: true)
  late String uniqueId;
  
  final DateTime? createdAt;
  final bool isActive;
}
```

### Database Access

```dart
// Open Isar instance
final isar = await Isar.open([MyCollectionSchema]);

// CRUD Operations
// Create
await isar.writeTxn(() async {
  await isar.myCollections.put(MyCollection()..name = 'Test');
});

// Read
final item = await isar.myCollections.get(id);
final allItems = await isar.myCollections.where().findAll();

// Update
await isar.writeTxn(() async {
  item?.name = 'Updated';
  await isar.myCollections.put(item!);
});

// Delete
await isar.writeTxn(() async {
  await isar.myCollections.delete(id);
});

// Query with filters
final activeItems = await isar.myCollections
    .where()
    .isActiveEqualTo(true)
    .sortByCreatedAt()
    .findAll();
```

### Generate Code

After defining collections, run:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Best Practices

### Layer Separation Rules

1. **Domain Layer**
   - No imports from data or presentation layers
   - Only contains pure business logic
   - No framework dependencies (GetX, Flutter, etc.)
   - Use abstract classes for repositories

2. **Data Layer**
   - Implements domain repository interfaces
   - Can import domain entities
   - Handles external dependencies (HTTP, Database)
   - Converts models to entities

3. **Presentation Layer**
   - Can import domain entities and use cases
   - NEVER imports data layer directly
   - Uses GetX for state management
   - Handles UI logic only

### Dependency Direction

```
┌─────────────────┐
│  Presentation   │
│   (GetX UI)     │
└────────┬────────┘
         │ depends on
         ▼
┌─────────────────┐
│     Domain      │
│ (Business Logic)│
└────────┬────────┘
         │ implemented by
         ▼
┌─────────────────┐
│      Data       │
│ (API, DB, etc) │
└─────────────────┘
```

### Naming Conventions

- **Files**: snake_case (e.g., `user_profile_controller.dart`)
- **Classes**: PascalCase (e.g., `UserProfileController`)
- **Methods/Variables**: camelCase (e.g., `getUserById`, `isLoading`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `MAX_RETRY_COUNT`)
- **Private members**: prefix with underscore (e.g., `_loadData()`)

### File Organization

```
lib/features/{feature}/
├── domain/
│   ├── entities/
│   │   └── {feature}_entity.dart
│   ├── repositories/
│   │   └── {feature}_repository.dart
│   ├── use_cases/
│   │   ├── get_{feature}_use_case.dart
│   │   └── update_{feature}_use_case.dart
│   └── params/
│       └── {feature}_params.dart
├── data/
│   ├── data_sources/
│   │   ├── {feature}_data_source.dart
│   │   └── remote/
│   │       └── {feature}_http_service.dart
│   ├── models/
│   │   └── collections/
│   │       └── {feature}_collection.dart
│   └── repositories/
│       └── {feature}_repository_impl.dart
├── presentation/
│   ├── arguments/
│   │   └── {feature}_arguments.dart
│   ├── bindings/
│   │   └── {feature}_binding.dart
│   ├── controllers/
│   │   └── {feature}_controller.dart
│   ├── views/
│   │   ├── screens/
│   │   │   └── mobile/
│   │   │       └── {feature}_screen.dart
│   │   └── widgets/
│   │       └── {feature}_card.dart
│   └── widgets/
│       └── {feature}_widget.dart
└── di/
    └── {feature}_injection.dart
```

### Error Handling

Use custom exceptions in `lib/core/exceptions/`:

```dart
class ApiException implements Exception {
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  ApiException(this.message, [this.error, this.stackTrace]);

  @override
  String toString() => 'ApiException: $message';
}

class DataFetchException implements Exception {
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  DataFetchException(this.message, [this.error, this.stackTrace]);
}
```

Handle errors in controllers:

```dart
try {
  final result = await useCase.call(params);
  data.value = result;
} on ApiException catch (e) {
  errorMessage.value = e.message;
  log.e('API error', e.error, e.stackTrace);
} catch (e, stackTrace) {
  errorMessage.value = 'An unexpected error occurred';
  log.e('Unexpected error', e, stackTrace);
}
```

### Testing Structure

Tests mirror the source structure:

```
test/features/{feature}/
├── domain/
│   ├── entities/
│   │   └── {feature}_entity_test.dart
│   ├── repositories/
│   │   └── {feature}_repository_test.dart
│   └── use_cases/
│       └── get_{feature}_use_case_test.dart
├── data/
│   └── repositories/
│       └── {feature}_repository_impl_test.dart
└── presentation/
    └── controllers/
        └── {feature}_controller_test.dart
```

Use Mocktail for mocking:

```dart
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class Mock{FeatureName}Repository extends Mock implements {FeatureName}Repository {}

void main() {
  late Mock{FeatureName}Repository mockRepository;
  late Get{FeatureName}UseCase useCase;

  setUp(() {
    mockRepository = Mock{FeatureName}Repository();
    useCase = Get{FeatureName}UseCase(repository: mockRepository);
  });

  group('Get{FeatureName}UseCase', () {
    test('should return {feature_name} entity when repository returns data', () async {
      // Given
      const testEntity = {FeatureName}Entity(
        id: '1',
        name: 'Test',
        createdAt: null,
      );
      when(() => mockRepository.getById('1')).thenAnswer((_) async => testEntity);

      // When
      final result = await useCase.call('1');

      // Then
      expect(result, equals(testEntity));
      verify(() => mockRepository.getById('1')).called(1);
    });
  });
}
```

## Complete Example: User Profile Feature

This example demonstrates a complete feature implementation following all the patterns above.

### Domain Layer

**Entity**: `lib/features/profile/domain/entities/profile_entity.dart` (already exists in project)

**Repository Interface**: `lib/features/profile/domain/repositories/profile_local_repository.dart` (already exists)

**Use Case**: `lib/features/profile/domain/use_cases/get_profile_local_use_case.dart` (already exists)

### Data Layer

**Repository Implementation**: `lib/features/profile/data/repositories/profile_local_repository_impl.dart` (already exists)

### Presentation Layer

**Controller**: `lib/features/profile/presentation/controllers/profile_controller.dart` (already exists)

**Binding**: `lib/features/profile/presentation/bindings/profile_binding.dart`

```dart
import 'package:get/get.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_controller.dart';
import 'package:uchat/features/profile/presentation/arguments/profile_arguments.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as ProfileArguments?;
    
    Get.lazyPut<ProfileControllerV2>(
      () => ProfileControllerV2(
        accountId: args?.accountId ?? '',
        args: args,
        log: Get.find(),
        taxonomyService: Get.find(),
        getProfileLocalUseCase: Get.find(),
        getProfileServerUseCase: Get.find(),
        updateProfileUseCase: Get.find(),
        startCallUseCase: Get.find(),
        getRoomByAccountIdUseCase: Get.find(),
        getRoomSubscriptionUseCase: Get.find(),
        openDirectChatAndSaveToDbUseCase: Get.find(),
        addFriendInGroupUseCase: Get.find(),
        addContactUseCase: Get.find(),
        blockContactUseCase: Get.find(),
        unblockContactUseCase: Get.find(),
        toggleMuteRoomUseCase: Get.find(),
      ),
    );
  }
}
```

**Screen**: `lib/features/profile/presentation/views/screens/mobile/profile_screen.dart` (already exists)

### Dependency Injection

**Injection**: `lib/features/profile/di/profile_injection.dart` (already exists)

## Thai Localization Considerations

### Text Handling

Use the Thai sanitizer utility for proper text handling:

```dart
import 'package:uchat/utils/thai_sanitizer.dart';

String sanitizedText = ThaiSanitizer.normalize(userInput);
```

### Font Loading

Ensure Thai fonts are loaded in `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: NotoSansThai
      fonts:
        - asset: assets/fonts/NotoSansThai-Regular.ttf
        - asset: assets/fonts/NotoSansThai-Bold.ttf
          weight: 700
```

### Localization Keys

Use `.tr` for all user-facing strings:

```dart
Text('Welcome'.tr)
Text('Hello @name'.trParams({'name': userName}))
```

## Development Commands

Always use FVM for Flutter commands:

```bash
# Install dependencies
fvm flutter pub get

# Run the app
fvm flutter run

# Run tests
fvm flutter test

# Analyze code
fvm flutter analyze

# Build for production
fvm flutter build apk --release

# Generate code (Isar, freezed, etc.)
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Clean rebuild
./.tools/clean_rebuild.sh
```

## Common Patterns

### Loading State

```dart
final RxBool isLoading = false.obs;

Future<void> loadData() async {
  try {
    isLoading.value = true;
    // Load data
  } finally {
    isLoading.value = false;
  }
}
```

### Error State

```dart
final RxString errorMessage = ''.obs;

bool get hasError => errorMessage.value.isNotEmpty;

void showError(String message) {
  errorMessage.value = message;
}

void clearError() {
  errorMessage.value = '';
}
```

### Pagination

```dart
final RxList<Item> items = <Item>[].obs;
final RxBool isLoadingMore = false.obs;
final RxBool hasReachedMax = false.obs;
int _currentPage = 1;

Future<void> loadMore() async {
  if (isLoadingMore.value || hasReachedMax.value) return;
  
  isLoadingMore.value = true;
  try {
    final newItems = await repository.getPage(_currentPage);
    if (newItems.isEmpty) {
      hasReachedMax.value = true;
    } else {
      items.addAll(newItems);
      _currentPage++;
    }
  } finally {
    isLoadingMore.value = false;
  }
}
```

### Search/Filter

```dart
final RxString searchQuery = ''.obs;
final RxList<Item> allItems = <Item>[].obs;
final RxList<Item> filteredItems = <Item>[].obs;

@override
  void onInit() {
  super.onInit();
  debounce(searchQuery, _filterItems, time: Duration(milliseconds: 300));
}

void _filterItems(String query) {
  if (query.isEmpty) {
    filteredItems.value = allItems;
  } else {
    filteredItems.value = allItems
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
```

## Troubleshooting

### Build Issues

If you encounter build errors:

```bash
# Run clean rebuild script
./.tools/clean_rebuild.sh

# Or manually clean
fvm flutter clean
fvm flutter pub get
cd ios && pod install && cd ..
```

### Isar Code Generation

If Isar collections are not generated:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Dependency Conflicts

Check for dependency conflicts:

```bash
fvm flutter pub deps
```

### Linting Issues

Fix linting issues:

```bash
fvm flutter analyze
```

Common linting rules to follow:
- Use single quotes for strings
- Use `const` constructors
- Avoid `print` statements (use logging instead)
- Follow naming conventions

## Additional Resources

- **AGENTS.md**: Project-specific guidelines and rules for development environment setup, code structure, architecture, build processes, testing, linting, and best practices
- **GetX Documentation**: https://github.com/jonataslaw/getx
- **Isar Documentation**: https://isar.dev
- **Clean Architecture**: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html

## Checklist for New Features

Before implementing a new feature, ensure:

- [ ] Feature directory structure created
- [ ] Domain layer: Entity defined
- [ ] Domain layer: Repository interface created
- [ ] Domain layer: Use cases implemented
- [ ] Data layer: Data sources implemented
- [ ] Data layer: Repository implementation created
- [ ] Presentation layer: Controller with GetX created
- [ ] Presentation layer: Binding implemented
- [ ] Presentation layer: Screen/widget created
- [ ] Dependency injection configured
- [ ] Routes registered
- [ ] Tests written (aim for 100% coverage)
- [ ] Linting passes (`fvm flutter analyze`)
- [ ] Thai localization considered
- [ ] Error handling implemented
- [ ] Code follows project conventions

Last updated: 2025-02-05
