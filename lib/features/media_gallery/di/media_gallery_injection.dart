import 'package:get_it/get_it.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service_impl.dart';

Future<void> registerMediaGallerySingletonDependencies() async {
  final getIt = GetIt.instance;

  // Register all required services.
  getIt.registerSingleton<MediaGalleryService>(MediaGalleryServiceImpl());
}
