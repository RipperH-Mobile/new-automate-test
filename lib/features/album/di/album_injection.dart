import 'package:get_it/get_it.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/features/album/domain/use_cases/cancel_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/create_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/delete_images_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_all_image_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_image_for_add_to_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/download_image_from_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_albums_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_images_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/get_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/get_unfinished_album_task_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/rename_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_download_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/retry_upload_album_image_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/share_image_from_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/upload_image_to_album_use_case.dart';

Future<void> registerAlbumSingletonDependencies() async {
  // TODO uncomment these lines when dependency injection refactor is done.
  // Currently these singleton can't be register here because these are used in injector.dart
  // Register data sources.
  // getIt.registerSingleton<AlbumApiService>(
  //   AlbumApiService(
  //     httpCaller: getIt<HttpCaller>(),
  //   ),
  // );
  // getIt.registerSingleton<AlbumSocketService>(
  //   AlbumSocketService(
  //     socketCaller: getIt<SocketCaller>(),
  //   ),
  // );

  // Register repository.
  // getIt.registerSingleton<AlbumLocalRepository>(
  //   AlbumLocalRepositoryImpl(
  //     albumDb: getIt<AlbumDb>(),
  //     albumImageDb: getIt<AlbumImageDb>(),
  //     albumTaskDb: getIt<AlbumTaskDb>(),
  //   ),
  // );
}

Future<void> registerAlbumFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register use cases.
  getIt
    ..registerFactory(
      () => CancelAlbumTaskUseCase(),
    )
    ..registerFactory(
      () => CreateAlbumUseCase(),
    )
    ..registerFactory(
      () => DeleteAlbumTaskUseCase(),
    )
    ..registerFactory(
      () => DeleteAlbumUseCase(
        albumServerRepository: getIt<AlbumServerRepository>(),
        albumLocalRepository: getIt<AlbumLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => DeleteImagesInAlbumUseCase(),
    )
    ..registerFactory(
      () => DownloadAllImageInAlbumUseCase(),
    )
    ..registerFactory(
      () => DownloadImageForAddToAlbumUseCase(),
    )
    ..registerFactory(
      () => DownloadImageFromAlbumUseCase(),
    )
    ..registerFactory(
      () => FetchAlbumsUseCase(),
    )
    ..registerFactory(
      () => FetchImagesInAlbumUseCase(),
    )
    ..registerFactory(
      () => GetAlbumUseCase(),
    )
    ..registerFactory(
      () => GetUnfinishedAlbumTaskUseCase(),
    )
    ..registerFactory(
      () => RenameAlbumUseCase(),
    )
    ..registerFactory(
      () => RetryDownloadImageToAlbumUseCase(),
    )
    ..registerFactory(
      () => RetryUploadImageToAlbumUseCase(),
    )
    ..registerFactory(
      () => ShareImageFromAlbumUseCase(),
    )
    ..registerFactory(
      () => UploadImageToAlbumUseCase(),
    );
}
