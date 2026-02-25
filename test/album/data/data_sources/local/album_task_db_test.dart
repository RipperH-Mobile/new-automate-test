import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/data/data_source/local/album_task_db.dart';
import 'package:uchat/features/album/data/models/collections/album_task_collection.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late Isar isar;
  late AlbumTaskDb albumTaskDb;
  late MockLoggerService mockLoggerService;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [AlbumTaskCollectionSchema],
      directory: './',
      name: 'album_task_db_test',
    );

    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    albumTaskDb = AlbumTaskDb(customDbInstance: isar);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.albumTasks.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putAlbumTask cases', () {
    test('Given no task in local db, When invoked with new task, Should save task to local db', () async {
      // Given
      final task = AlbumTaskCollection(
        taskId: 'taskId1',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.inProgress,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );

      // When
      await albumTaskDb.putAlbumTask(task);

      // Then
      final fetchedTasks = await albumTaskDb.getAlbumTasksInRoom(task.roomId!);
      expect(fetchedTasks.length, 1);
      expect(fetchedTasks.first.taskId, 'taskId1');
    });

    test('Given task is already in local db, When invoked with new task data, Should save new task data to local db',
        () async {
      // Given
      final task = AlbumTaskCollection(
        taskId: 'taskId1',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.inProgress,
        type: AlbumTaskType.upload,
        currentProgress: 0,
        totalImages: 10,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      await albumTaskDb.putAlbumTask(task);
      final newTask = AlbumTaskCollection(
        taskId: 'taskId1',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.completed,
        type: AlbumTaskType.upload,
        currentProgress: 10,
        totalImages: 10,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );

      // When
      await albumTaskDb.putAlbumTask(newTask);

      // Then
      final fetchedTasks = await isar.albumTasks.getByTaskId('taskId1');
      expect(fetchedTasks?.taskId, 'taskId1');
      expect(fetchedTasks?.currentProgress, 10);
      expect(fetchedTasks?.status, AlbumTaskStatus.completed);
    });
  });

  group('getAlbumTasksInRoom cases', () {
    test('Given no task in local db, When invoked, Should return empty list', () async {
      // When
      final tasks = await albumTaskDb.getAlbumTasksInRoom('roomId1');

      // Then
      expect(tasks, isEmpty);
    });

    test(
        'Given some task in local db, When invoked with room id, Should return list of in progress or failed task in that room',
        () async {
      // Given
      final task1 = AlbumTaskCollection(
        taskId: 'taskId1',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.inProgress,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task2 = AlbumTaskCollection(
        taskId: 'taskId2',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.completed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task3 = AlbumTaskCollection(
        taskId: 'taskId3',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.failed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      await albumTaskDb.putAlbumTask(task1);
      await albumTaskDb.putAlbumTask(task2);
      await albumTaskDb.putAlbumTask(task3);

      // When
      final result = await albumTaskDb.getAlbumTasksInRoom('roomId1');

      // Then
      expect(result.length, 2);
      expect(result.any((e) => e.taskId == task1.taskId), true);
      expect(result.any((e) => e.taskId == task2.taskId), false);
      expect(result.any((e) => e.taskId == task3.taskId), true);
    });
  });

  group('getAlbumTasksInRoomWithAlbumId cases', () {
    test('Given no task in local db, When invoked, Should return empty list', () async {
      // When
      final tasks = await albumTaskDb.getAlbumTasksInRoomWithAlbumId('roomId1', 'albumId1');

      // Then
      expect(tasks, isEmpty);
    });

    test(
        'Given some task in local db, When invoked with room id and album id, Should return list of in progress or failed task in that room and album',
        () async {
      // Given
      final task1 = AlbumTaskCollection(
        taskId: 'taskId1',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.inProgress,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task2 = AlbumTaskCollection(
        taskId: 'taskId2',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.completed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task3 = AlbumTaskCollection(
        taskId: 'taskId3',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.failed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task4 = AlbumTaskCollection(
        taskId: 'taskId4',
        albumId: 'albumId2',
        roomId: 'roomId1',
        status: AlbumTaskStatus.failed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      await albumTaskDb.putAlbumTask(task1);
      await albumTaskDb.putAlbumTask(task2);
      await albumTaskDb.putAlbumTask(task3);
      await albumTaskDb.putAlbumTask(task4);

      // When
      final result = await albumTaskDb.getAlbumTasksInRoomWithAlbumId('roomId1', 'albumId1');

      // Then
      expect(result.length, 2);
      expect(result.any((e) => e.taskId == task1.taskId), true);
      expect(result.any((e) => e.taskId == task2.taskId), false);
      expect(result.any((e) => e.taskId == task3.taskId), true);
      expect(result.any((e) => e.taskId == task4.taskId), false);
    });
  });

  group('deleteFailedAlbumTaskWithAlbumId cases', () {
    test('Given some task in local db, When invoked with album id, Should remove all failed task for that album',
        () async {
      // Given
      final task1 = AlbumTaskCollection(
        taskId: 'taskId1',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.inProgress,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task2 = AlbumTaskCollection(
        taskId: 'taskId2',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.completed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task3 = AlbumTaskCollection(
        taskId: 'taskId3',
        albumId: 'albumId1',
        roomId: 'roomId1',
        status: AlbumTaskStatus.failed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      final task4 = AlbumTaskCollection(
        taskId: 'taskId4',
        albumId: 'albumId2',
        roomId: 'roomId1',
        status: AlbumTaskStatus.failed,
        type: AlbumTaskType.upload,
        createdAt: DateTime(2000, 1, 1),
        updatedAt: DateTime(2000, 1, 1),
      );
      await albumTaskDb.putAlbumTask(task1);
      await albumTaskDb.putAlbumTask(task2);
      await albumTaskDb.putAlbumTask(task3);
      await albumTaskDb.putAlbumTask(task4);

      // When
      await albumTaskDb.deleteFailedAlbumTaskWithAlbumId('albumId1');

      // Then
      final albumId1Task = await isar.albumTasks.where().albumIdEqualTo('albumId1').findAll();
      expect(albumId1Task.any((e) => e.taskId == task1.taskId), true);
      expect(albumId1Task.any((e) => e.taskId == task2.taskId), true);
      expect(albumId1Task.any((e) => e.taskId == task3.taskId), false);
      final albumId2Task = await isar.albumTasks.where().albumIdEqualTo('albumId2').findAll();
      expect(albumId2Task.any((e) => e.taskId == task4.taskId), true);
    });
  });
}
