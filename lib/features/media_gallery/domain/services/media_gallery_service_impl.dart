import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/media_gallery/domain/events/update_gallery_asset_event.dart';
import 'package:uchat/features/media_gallery/domain/model/album_asset_model.dart';
import 'package:uchat/features/media_gallery/domain/services/media_gallery_service.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';

/// Implementation of MediaGalleryService that manages album and asset caching
/// Handles photo library access, permission management, and asset preloading
class MediaGalleryServiceImpl extends MediaGalleryService {
  final _log = useLogger();
  final _logTag = 'media_gallery_service';
  // ==================== State Variables ====================

  /// Currently selected album
  AlbumAssetModel? _currentAlbum;

  /// Current media filter type (image, video, or both)
  MediaGalleryFilterMediaType _currentFilterMediaType = MediaGalleryFilterMediaType.imageAndVideo;

  /// List of all cached albums
  List<AlbumAssetModel> _cachedAlbums = [];

  /// Map of album ID to list of cached assets
  /// Key: Album ID, Value: List of AssetEntity
  final Map<String, List<AssetEntity>> _cachedAlbumAssets = {};

  /// Manager for preloading and caching asset thumbnails
  final PhotoCachingManager _photoCacheManager = PhotoCachingManager();

  /// Whether photo library permission is granted
  bool _isGranted = false;

  /// Current permission state from PhotoManager
  PermissionState _permissionState = PermissionState.notDetermined;

  /// Lock to prevent concurrent album loading
  bool _isLoadingAlbums = false;

  /// Pending completer for album loading requests
  Completer<bool>? _albumLoadingCompleter;

  MediaGalleryServiceImpl() {
    initService();
  }

  // ==================== Constants ====================

  /// Default limit for pagination
  static const int _defaultLimit = 40;

  /// Grid column count for calculating thumbnail size
  static const int _gridColumnCount = 3;

  // ==================== Getters ====================

  bool _isLoadingAllAdditionalAlbumInfo = false;

  @override
  bool get isGranted => _isGranted;

  /// Returns cached albums, filtered for limited permission state
  /// In limited permission mode, only "All Photos" album is accessible
  @override
  List<AlbumAssetModel> get cachedAlbums {
    if (_isLimitedPermission && _cachedAlbums.isNotEmpty) {
      return _cachedAlbums.where((album) => album.isAll).toList();
    }
    return _cachedAlbums;
  }

  /// Returns current album, with special handling for limited permission
  @override
  AlbumAssetModel? get currentAlbum {
    if (_isLimitedPermission) {
      return _findAllAlbum();
    }
    return _currentAlbum;
  }

  @override
  Map<String, List<AssetEntity>> get cachedAlbumAssets => _cachedAlbumAssets;

  @override
  PermissionState get permissionState => _permissionState;

  // ==================== Private Helpers ====================

  // --- Permission Helpers ---

  /// Check if permission state is "limited" (iOS 14+ limited photo access)
  bool get _isLimitedPermission => _permissionState == PermissionState.limited;

  /// Check if permission is granted (authorized or limited)
  bool get _hasPermission =>
      _permissionState == PermissionState.authorized || _permissionState == PermissionState.limited;

  // --- Album Finding Helpers ---

  /// Get the "All Photos" album ID
  ///
  /// Returns:
  /// - Album ID if found
  /// - Empty string if no albums cached
  /// - null if albums exist but "All Photos" not found
  String? get _allAlbumId {
    if (_cachedAlbums.isEmpty) return '';
    return _findAllAlbum()?.albumId;
  }

  /// Find the "All Photos" album from cached albums
  ///
  /// This is the default album that contains all photos from the library.
  /// On iOS with limited permission, this is the only accessible album.
  ///
  /// Returns:
  /// - "All Photos" album if found
  /// - First album as fallback if "All Photos" doesn't exist
  /// - null if no albums are cached
  AlbumAssetModel? _findAllAlbum() {
    if (_cachedAlbums.isEmpty) return null;

    try {
      // Find album marked as "isAll" (All Photos album)
      return _cachedAlbums.firstWhere(
        (album) => album.isAll,
        orElse: () => _cachedAlbums.first, // Fallback to first album
      );
    } catch (e) {
      return null;
    }
  }

  /// Find album by its unique ID
  ///
  /// Parameters:
  /// - [albumId]: The unique identifier of the album to find
  ///
  /// Returns:
  /// - Album if found
  /// - null if album doesn't exist or error occurs
  AlbumAssetModel? _findAlbumById(String albumId) {
    try {
      return _cachedAlbums.firstWhere((alb) => alb.albumId == albumId);
    } catch (e) {
      return null;
    }
  }

  /// Resolve album ID with fallback to "All Photos"
  ///
  /// This method ensures we always have a valid album ID to work with.
  /// If no specific album is requested, it defaults to "All Photos".
  ///
  /// Parameters:
  /// - [albumId]: Requested album ID (can be null or empty)
  ///
  /// Returns:
  /// - Provided album ID if not null/empty
  /// - "All Photos" album ID as fallback
  ///
  /// Throws:
  /// - Exception if no albums are available
  String _resolveAlbumId(String? albumId) {
    // Use provided ID if available
    if (albumId != null && albumId.isNotEmpty) {
      return albumId;
    }

    // Fall back to "All Photos" album
    final allId = _allAlbumId;
    if (allId == null || allId.isEmpty) {
      throw Exception('No albums available');
    }

    return allId;
  }

  // --- Validation Helpers ---

  /// Ensure albums are loaded, re-fetch if needed
  ///
  /// This is a common pattern used across multiple methods.
  /// It checks if albums need to be (re)loaded based on:
  /// - Empty cache
  /// - Filter type change
  /// - Explicit refresh request
  ///
  /// Why This Helps:
  /// - Reduces code duplication
  /// - Centralizes album loading logic
  /// - Ensures consistent behavior
  ///
  /// Parameters:
  /// - [requestType]: Media filter type to use
  /// - [refresh]: Force refresh even if cached
  ///
  /// Returns:
  /// - true if albums were successfully loaded/verified
  /// - false if loading failed
  Future<bool> _ensureAlbumsLoaded({
    required MediaGalleryFilterMediaType requestType,
    bool refresh = false,
  }) async {
    try {
      // If already loading albums, wait for the ongoing operation
      if (_isLoadingAlbums && _albumLoadingCompleter != null) {
        _log.d('$_logTag: Waiting for ongoing album load operation');
        return await _albumLoadingCompleter!.future;
      }

      // Check if re-fetch is needed
      final filterChanged = _currentFilterMediaType != requestType;
      final needsRefresh = _cachedAlbums.isEmpty || filterChanged || refresh;

      if (needsRefresh) {
        // Set lock and create completer for concurrent calls
        _isLoadingAlbums = true;
        _albumLoadingCompleter = Completer<bool>();

        try {
          await getAlbums(requestType: requestType, refresh: needsRefresh);
          final result = _cachedAlbums.isNotEmpty;

          // Complete the completer for waiting calls
          if (!_albumLoadingCompleter!.isCompleted) {
            _albumLoadingCompleter!.complete(result);
          }

          return result;
        } catch (e) {
          // Complete with error for waiting calls
          if (!_albumLoadingCompleter!.isCompleted) {
            _albumLoadingCompleter!.complete(false);
          }
          rethrow;
        } finally {
          // Release lock
          _isLoadingAlbums = false;
          _albumLoadingCompleter = null;
        }
      }

      // Verify we have albums after load
      return _cachedAlbums.isNotEmpty;
    } catch (e) {
      _log.e('$_logTag: Failed to ensure albums loaded', e);
      return false;
    }
  }

  /// Validate and get album by ID, throw clear error if not found
  ///
  /// Common pattern: resolve album ID → find album → validate exists
  /// This helper combines these steps with better error messages.
  ///
  /// Why This Helps:
  /// - Eliminates repetitive validation code
  /// - Provides consistent error messages
  /// - Makes calling code cleaner
  ///
  /// Parameters:
  /// - [albumId]: Album to find (null = "All Photos")
  ///
  /// Returns:
  /// - Valid AlbumAssetModel
  ///
  /// Throws:
  /// - Exception with descriptive message if album not found
  AlbumAssetModel _getValidatedAlbum(String? albumId) {
    // Resolve which album to use
    final targetAlbumId = _resolveAlbumId(albumId);

    // Find and validate album exists
    final album = _findAlbumById(targetAlbumId);
    if (album == null) {
      throw Exception('Album not found: $targetAlbumId');
    }

    return album;
  }

  // --- Cache Management Helpers ---

  /// Determine if cached assets should be used for this request
  ///
  /// Cache is NOT used when:
  /// - Explicitly refreshing (refresh = true)
  /// - Filter type changed (e.g., from images to videos)
  /// - Loading more assets (loadMore = true)
  /// - No assets cached for this album
  ///
  /// Parameters:
  /// - [albumId]: Album to check cache for
  /// - [refresh]: Whether this is a refresh request
  /// - [loadMore]: Whether loading more assets (pagination)
  /// - [filterChanged]: Whether media filter type changed
  ///
  /// Returns:
  /// - true if cached assets should be used
  /// - false if new assets should be fetched
  bool _shouldUseCachedAssets({
    required String albumId,
    required bool refresh,
    required bool loadMore,
    required bool filterChanged,
  }) {
    // Always fetch fresh data on refresh or filter change
    if (refresh || filterChanged) return false;

    // Always fetch more data when paginating
    if (loadMore) return false;

    // Check if we have cached assets for this album
    final cachedAssets = _cachedAlbumAssets[albumId];
    return cachedAssets != null && cachedAssets.isNotEmpty;
  }

  /// Calculate the start and end index for pagination
  ///
  /// This determines which range of assets to fetch from the album.
  /// For example: start=0, end=40 fetches the first 40 assets.
  /// On next page: start=40, end=80 fetches the next 40 assets.
  ///
  /// Parameters:
  /// - [albumId]: Album to paginate
  /// - [limit]: Number of assets to fetch
  /// - [refresh]: If true, start from 0
  /// - [filterChanged]: If true, start from 0
  ///
  /// Returns:
  /// - Record with (start: int, end: int) for pagination range
  ({int start, int end}) _calculatePaginationRange({
    required String albumId,
    required int limit,
    required bool refresh,
    required bool filterChanged,
  }) {
    // Start from 0 if refreshing or filter changed
    // Otherwise, start from current cached asset count
    final currentCount = (refresh || filterChanged) ? 0 : (_cachedAlbumAssets[albumId]?.length ?? 0);

    return (
      start: currentCount,
      end: currentCount + limit,
    );
  }

  /// Update the asset cache for a specific album
  ///
  /// This method manages the in-memory cache of assets.
  /// It can either append new assets or clear and replace the cache.
  ///
  /// Parameters:
  /// - [albumId]: Album to update cache for
  /// - [newAssets]: New assets to add to cache
  /// - [shouldClearCache]: If true, clears existing cache before adding
  void _updateAssetCache({
    required String albumId,
    required List<AssetEntity> newAssets,
    required bool shouldClearCache,
  }) {
    // Get existing cached assets or create new list
    final cachedAssets = _cachedAlbumAssets[albumId] ?? [];

    // Clear cache if requested (e.g., on refresh or filter change)
    if (shouldClearCache) {
      cachedAssets.clear();
    }

    for (final asset in newAssets) {
      final isContained = cachedAssets.contains(asset);
      if (isContained) continue;

      // Add new asset to cache
      cachedAssets.add(asset);
    }

    // Update cache map
    _cachedAlbumAssets[albumId] = cachedAssets;
  }

  // --- Event Notification Helpers ---

  /// Notify listeners that gallery assets have been updated
  ///
  /// This fires an event through the event bus to inform UI components
  /// that they should refresh their display.
  ///
  /// Parameters:
  /// - [albumId]: Album that was updated
  void _notifyGalleryUpdate(String albumId) {
    eventBus.fire(UpdateGalleryAssetEvent(albumId: albumId, refresh: true));
  }

  // ==================== Permission Management ====================

  /// Check current photo library permission state
  ///
  /// This method queries the system for current photo access permissions.
  /// It does NOT request permission from the user.
  ///
  /// Permission States:
  /// - authorized: Full access to all photos
  /// - limited: Limited access (iOS 14+, user selected specific photos)
  /// - denied: User denied permission
  /// - notDetermined: User hasn't been asked yet
  ///
  /// Side Effects:
  /// - Updates internal permission state
  /// - Clears cache if permission is revoked
  ///
  /// Returns:
  /// - true if authorized or limited access is granted
  /// - false if permission is denied or not determined
  @override
  Future<bool> checkPermission() async {
    try {
      // Query system for current permission state
      final permission = await PhotoManager.getPermissionState(
        requestOption: const PermissionRequestOption(),
      );

      // Update internal state
      _permissionState = permission;
      _isGranted = _hasPermission;

      // Clear cached data if permission was revoked
      if (!_isGranted) {
        await clearCache();
      }

      return _isGranted;
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error checking photo permissions', e, stackTrace);
      return false;
    }
  }

  /// Request photo library permission from user
  ///
  /// This shows the system permission dialog to the user.
  /// On iOS 14+, user can choose to grant full or limited access.
  ///
  /// Returns:
  /// - true if user granted permission (full or limited)
  /// - false if user denied or error occurred
  @override
  Future<bool> requestPermission() async {
    try {
      // Request permission through our permission controller
      await PermissionController.instance.checkGalleryPermission();
      final permission = await PhotoManager.getPermissionState(
        requestOption: const PermissionRequestOption(),
      );

      _permissionState = permission;
      _isGranted = _hasPermission;

      if (_isGranted) {
        _setupChangeListener();
      }

      return _isGranted;
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error requesting photo permissions', e, stackTrace);
      return false;
    }
  }

  // ==================== Album Management ====================

  /// Fetch and cache all albums from photo library
  ///
  /// Retrieves the list of all photo albums/folders from device.
  ///
  /// **Album Types Returned:**
  /// - "All Photos" / "Recent" (system default album)
  /// - User-created albums ("Vacation 2024", "Family", etc.)
  /// - Smart albums ("Favorites", "Screenshots", "Selfies", etc.)
  ///
  /// **Smart Caching:**
  /// - Returns cached if filter unchanged (avoids re-fetch)
  /// - Re-fetches if filter changes (images → videos)
  /// - Re-fetches if explicitly requested (refresh: true)
  ///
  /// **Why Cache Albums?**
  /// - Album list rarely changes (vs assets which change often)
  /// - Faster album picker display
  /// - Reduces battery drain from photo library I/O
  ///
  /// **Parameters:**
  /// - [requestType]: Filter by media type (default: both images & videos)
  /// - [refresh]: Force re-fetch even if cached
  ///
  /// **Returns:**
  /// - List of albums with basic info (name, ID, isAll flag)
  /// - Empty list if error or no permission
  ///
  /// **Side Effects:**
  /// - Updates _currentFilterMediaType
  /// - Populates _cachedAlbums
  /// - Sets _currentAlbum to "All Photos"
  @override
  Future<List<AlbumAssetModel>> getAlbums({
    MediaGalleryFilterMediaType requestType = MediaGalleryFilterMediaType.imageAndVideo,
    bool refresh = false,
  }) async {
    try {
      // Check if we can use cached albums
      // Why? Avoid slow I/O to photo library if data hasn't changed
      final filterUnchanged = _currentFilterMediaType == requestType;
      final hasCache = cachedAlbums.isNotEmpty;

      if (hasCache && filterUnchanged && !refresh) {
        _log.i('$_logTag: Using ${cachedAlbums.length} cached albums');
        return cachedAlbums;
      }

      // Update filter for future requests
      // Why store? Need to detect when filter changes later
      _currentFilterMediaType = requestType;

      // Fetch from native photo library
      // Why separate method? Isolates platform-specific code
      final albums = await _fetchAlbumsFromPhotoManager(requestType);

      // Convert to our app models
      // Why convert? Type safety and additional functionality
      final albumModels = _convertToAlbumModels(albums);

      // Cache for future use
      _cachedAlbums = albumModels;

      // Set default album to "All Photos"
      // Why? Most users start with all photos view
      _currentAlbum = _findAllAlbum();

      // Fetch additional album info in background
      _fetchAllAdditionalAlbumInfoBackground();

      return albumModels;
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error fetching albums', e, stackTrace);
      return []; // Fail gracefully
    }
  }

  /// Fetch albums from PhotoManager (native platform API)
  ///
  /// Low-level method interfacing with device photo library.
  ///
  /// **Platform Behavior:**
  /// - iOS: Uses PHAssetCollection API
  /// - Android: Uses MediaStore API
  ///
  /// **Why Separate Method?**
  /// - Isolates platform-specific code
  /// - Makes testing easier (can mock this)
  /// - Centralizes PhotoManager configuration
  ///
  /// **Filter Configuration:**
  /// - Uses app-wide filter options (UChatConstant)
  /// - Excludes hidden/trashed assets
  /// - Respects system privacy settings
  ///
  /// **Parameters:**
  /// - [requestType]: Media type filter
  ///
  /// **Returns:**
  /// - Native AssetPathEntity objects
  Future<List<AssetPathEntity>> _fetchAlbumsFromPhotoManager(
    MediaGalleryFilterMediaType requestType,
  ) async {
    return PhotoManager.getAssetPathList(
      type: requestType.requestType, // Convert enum to PhotoManager type
      hasAll: true, // Include "All Photos" album (critical!)
      filterOption: FilterOptionGroup(
        // Apply app-wide filtering rules
        // Why? Consistent behavior across all gallery features
        imageOption: UChatConstant.galleryImageFilterOption,
        videoOption: UChatConstant.galleryVideoFilterOption,
      ),
    );
  }

  /// Convert native album models to app-specific models
  ///
  /// Transforms PhotoManager's AssetPathEntity to our AlbumAssetModel.
  ///
  /// **Why Transform?**
  /// - Type safety (our model has validation)
  /// - Additional fields (isFetchedAdditional, firstAsset, etc.)
  /// - Decouples app from PhotoManager API changes
  /// - Easier to test and mock
  ///
  /// **What's Preserved:**
  /// - albumInfo: Keep reference to native object (needed for fetching assets)
  /// - All essential data: ID, name, isAll flag
  ///
  /// **Parameters:**
  /// - [albums]: Native album objects from PhotoManager
  ///
  /// **Returns:**
  /// - List of type-safe app models
  List<AlbumAssetModel> _convertToAlbumModels(List<AssetPathEntity> albums) {
    return albums.map((album) {
      return AlbumAssetModel(
        albumId: album.id, // Platform-specific unique ID
        albumName: album.name, // User-visible name
        albumInfo: album, // Keep native reference for asset fetching
        isAll: album.isAll, // Flag for "All Photos" album
      );
    }).toList();
  }

  Future<void> _fetchAllAdditionalAlbumInfoBackground() async {
    if (_isLoadingAllAdditionalAlbumInfo || _cachedAlbums.isEmpty) {
      return;
    }

    _isLoadingAllAdditionalAlbumInfo = true;

    try {
      // Take a snapshot of current albums to avoid issues with concurrent modifications
      final albumsSnapshot = List<AlbumAssetModel>.from(_cachedAlbums);

      final futures = <Future>[];
      for (final album in albumsSnapshot) {
        if (_permissionState == PermissionState.limited && !album.isAll) {
          continue;
        }

        futures.add(() async {
          final totalAsset = await album.albumInfo.assetCountAsync;

          List<AssetEntity> coverAsset = <AssetEntity>[];
          if (totalAsset > 0) {
            coverAsset = await album.albumInfo.getAssetListRange(
              start: 0,
              end: 1,
            );
          }

          final firstAsset = coverAsset.isNotEmpty ? coverAsset.first : null;
          final updatedAlbum = album.copyWith(
            firstAsset: firstAsset,
            totalAssets: totalAsset,
            isFetchedAdditional: true,
          );

          // Only update if the album still exists in cache (not replaced by concurrent getAlbums call)
          final index = _cachedAlbums.indexWhere((alb) => alb.albumId == album.albumId);
          if (index != -1 && _cachedAlbums.length > index) {
            _cachedAlbums[index] = updatedAlbum;
          }
        }());
      }

      await Future.wait(futures);
    } catch (e, s) {
      _log.e('$_logTag: Error fetching additional album info in background', e, s);
    } finally {
      _isLoadingAllAdditionalAlbumInfo = false;
    }
  }

  // ==================== Asset Management ====================

  /// Fetch assets (photos/videos) from a specific album with pagination
  ///
  /// This is the core method for loading media files from an album.
  ///
  /// **Key Features:**
  /// - Pagination: Load assets in manageable chunks (default 40)
  /// - Caching: Avoid redundant fetches from photo library
  /// - Filtering: Support image-only, video-only, or both
  /// - Refreshing: Force reload to get latest from device
  ///
  /// **How It Works:**
  /// 1. Validate albums are loaded (with correct filter)
  /// 2. Find the target album (defaults to "All Photos")
  /// 3. Check if we can use cached assets
  /// 4. If not cached, fetch new assets from photo library
  /// 5. Update cache and notify listeners
  ///
  /// **Caching Logic:**
  /// - Uses cache if: same album + same filter + not refreshing + not paginating
  /// - Clears cache if: refreshing or filter changed
  /// - Appends to cache if: paginating (loadMore)
  ///
  /// **Parameters:**
  /// - [albumId]: Album to fetch from (null/empty = "All Photos")
  /// - [limit]: Number of assets per page (default: 40)
  /// - [refresh]: Force reload, clearing cache (default: false)
  /// - [loadMore]: Load next page for pagination (default: false)
  /// - [requestType]: Media filter (image/video/both, default: both)
  ///
  /// **Returns:**
  /// - List of AssetEntity (photos/videos)
  /// - Empty list if error or no assets found
  ///
  /// **Usage Examples:**
  /// ```dart
  /// // Load first page from "All Photos"
  /// await getImagesFromAlbum();
  ///
  /// // Load next page (pagination)
  /// await getImagesFromAlbum(loadMore: true);
  ///
  /// // Force refresh latest photos
  /// await getImagesFromAlbum(refresh: true);
  ///
  /// // Load from specific album
  /// await getImagesFromAlbum(albumId: 'Screenshots-123');
  ///
  /// // Load only videos
  /// await getImagesFromAlbum(
  ///   requestType: MediaGalleryFilterMediaType.video,
  /// );
  /// ```
  @override
  Future<List<AssetEntity>> getImagesFromAlbum({
    String? albumId,
    int limit = _defaultLimit,
    bool refresh = false,
    bool loadMore = false,
    MediaGalleryFilterMediaType requestType = MediaGalleryFilterMediaType.imageAndVideo,
  }) async {
    try {
      if (requestType != _currentFilterMediaType) {
        refresh = true;
      }

      // Step 1: Validate albums are loaded with correct filter
      // This handles: empty cache, filter changes, explicit refresh
      final albumsLoaded = await _ensureAlbumsLoaded(requestType: requestType, refresh: refresh);
      if (!albumsLoaded) {
        _log.w('$_logTag: Failed to load albums');
        return [];
      }

      // Step 2: Validate and get target album
      // This resolves album ID and validates it exists
      final album = _getValidatedAlbum(albumId);
      final targetAlbumId = album.albumId;

      // Step 3: Fetch album metadata if needed
      // Why? Cover image and asset count needed for UI display
      if (refresh || !album.isFetchedAdditional) {
        final updatedAlbum = await getAdditionalAlbumInfo(albumId: targetAlbumId);
        _currentAlbum = updatedAlbum;
      }

      // Step 4: Check if we can use cached assets
      // Cache used when: not refreshing, not paginating, not filter changed
      final filterChanged = _currentFilterMediaType != requestType;
      if (_shouldUseCachedAssets(
        albumId: targetAlbumId,
        refresh: refresh,
        loadMore: loadMore,
        filterChanged: filterChanged,
      )) {
        return _cachedAlbumAssets[targetAlbumId] ?? [];
      }

      // Step 5: Calculate pagination range
      // Determines which assets to fetch: start/end indices
      final range = _calculatePaginationRange(
        albumId: targetAlbumId,
        limit: limit,
        refresh: refresh,
        filterChanged: filterChanged,
      );

      // Step 6: Fetch assets from photo library
      // This is the actual I/O operation to device's photo library
      final newAssets = await album.albumInfo.getAssetListRange(
        start: range.start,
        end: range.end,
      );

      // Step 7: Update in-memory cache
      // Clear cache if refreshing/filter changed, otherwise append
      _updateAssetCache(
        albumId: targetAlbumId,
        newAssets: newAssets,
        shouldClearCache: refresh || filterChanged,
      );

      // Step 8: Notify UI listeners if this was a refresh
      // UI components listen for this to update their display
      if (refresh) {
        _notifyGalleryUpdate(targetAlbumId);
      }

      return newAssets;
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error fetching images from album', e, stackTrace);
      return []; // Fail gracefully with empty list
    }
  }

  /// Change to a different album
  ///
  /// Switches the active album view. This is called when user
  /// selects a different album from the album picker.
  ///
  /// **Smart Caching:**
  /// - If assets already cached → returns immediately (fast!)
  /// - If not cached → fetches first page of assets
  ///
  /// **Why This Matters:**
  /// - Instant switching for previously viewed albums
  /// - Lazy loading for new albums (only fetch when needed)
  ///
  /// **Parameters:**
  /// - [albumId]: Album to switch to (required)
  /// - [limit]: Assets to fetch if not cached (default: 40)
  ///
  /// **Side Effects:**
  /// - Updates _currentAlbum reference
  /// - May populate cache if album not previously viewed
  @override
  Future<void> changeAlbum({
    required String albumId,
    int limit = _defaultLimit,
  }) async {
    try {
      // Ensure we have albums loaded
      final albumsLoaded = await _ensureAlbumsLoaded(requestType: _currentFilterMediaType);
      if (!albumsLoaded) return;

      // Validate album exists
      final album = _getValidatedAlbum(albumId);

      // Update current album reference
      _currentAlbum = album;

      // Check if assets already in cache
      // Why check? Avoid redundant fetch for performance
      final hasCache = _cachedAlbumAssets.containsKey(albumId) && _cachedAlbumAssets[albumId]!.isNotEmpty;
      if (hasCache) {
        _log.d('$_logTag: Using cached assets for album: ${album.albumName}');
        return; // Fast path: already have assets
      }

      // Slow path: fetch assets since not cached
      _log.d('$_logTag: Fetching assets for new album: ${album.albumName}');
      await getImagesFromAlbum(albumId: albumId, limit: limit);
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error changing album', e, stackTrace);
    }
  }

  /// Fetch additional metadata for an album
  ///
  /// Loads supplementary album information not included in basic album list:
  /// - Cover image (first asset thumbnail)
  /// - Total asset count
  ///
  /// **Why Separate Method?**
  /// - Initial album list fetch is fast (no asset loading)
  /// - Metadata fetch is slower (requires asset I/O)
  /// - Allows progressive loading: list first, details later
  ///
  /// **Use Cases:**
  /// - Album picker UI needs cover images
  /// - UI needs to show "123 photos" count
  /// - Before displaying album contents
  ///
  /// **Caching:**
  /// - Marked as fetched (isFetchedAdditional) to avoid re-fetch
  /// - Updated in _cachedAlbums for persistence
  ///
  /// **Parameters:**
  /// - [albumId]: Album to fetch metadata for (null = "All Photos")
  ///
  /// **Returns:**
  /// - Updated AlbumAssetModel with metadata populated
  ///
  /// **Throws:**
  /// - Exception if album not found
  @override
  Future<AlbumAssetModel> getAdditionalAlbumInfo({String? albumId}) async {
    try {
      // Ensure albums loaded
      await _ensureAlbumsLoaded(requestType: _currentFilterMediaType);

      // Get target album (handles null → "All Photos")
      final album = albumId == null || albumId.isEmpty ? _findAllAlbum() : _findAlbumById(albumId);

      if (album == null) {
        throw Exception('Album not found: $albumId');
      }

      // Fetch cover image (first asset only)
      // Why only first? That's all we need for thumbnail
      final coverAssets = await album.albumInfo.getAssetListRange(
        start: 0,
        end: 1,
      );

      // Fetch total count asynchronously
      // Why async? Can be slow for large albums (10k+ photos)
      final totalAssets = await album.albumInfo.assetCountAsync;

      // Extract cover asset (null if album empty)
      final firstAsset = coverAssets.isNotEmpty ? coverAssets.first : null;

      // Create enriched album model
      final updatedAlbum = album.copyWith(
        firstAsset: firstAsset,
        totalAssets: totalAssets,
        isFetchedAdditional: true, // Mark to prevent re-fetch
      );

      // Update cache with enriched data
      // Why? Future calls can use cached metadata
      final index = _cachedAlbums.indexWhere((alb) => alb.albumId == album.albumId);
      if (index != -1) {
        _cachedAlbums[index] = updatedAlbum;
      }

      return updatedAlbum;
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error fetching additional album data', e, stackTrace);
      rethrow; // Let caller handle error
    }
  }

  // ==================== Thumbnail Preloading ====================

  /// Preload thumbnails for given assets to improve scrolling performance
  ///
  /// This method fetches and caches thumbnail images for assets before
  /// they're displayed on screen. This prevents UI lag during scrolling
  /// by loading thumbnails ahead of time.
  ///
  /// Technical Details:
  /// - Uses photo_manager's built-in caching system
  /// - Thumbnail size calculated from screen width / grid columns
  /// - JPEG format for optimal size/quality balance
  /// - Requests are cancellable (previous requests auto-cancelled)
  ///
  /// Performance Impact:
  /// - Smooth scrolling even with thousands of photos
  /// - Reduces memory usage (thumbnails vs full images)
  /// - Network-efficient (cached locally after first load)
  ///
  /// Parameters:
  /// - [assets]: List of assets to preload thumbnails for
  /// - [options]: Optional thumbnail configuration (size, format, quality)
  ///
  /// Use Cases:
  /// - After loading new page of assets (pagination)
  /// - After switching albums
  /// - After service initialization
  /// - After refresh/filter changes
  ///
  /// Error Handling:
  /// - Cancels ongoing requests if new preload starts
  /// - Silent failures (won't block UI)
  /// - Thumbnails load on-demand if preload fails
  @override
  Future<void> preloadThumbnail(
    List<AssetEntity> assets, {
    ThumbnailOption? options,
  }) async {
    try {
      if (assets.isEmpty) return;

      // Calculate optimal thumbnail size based on grid layout
      // For 3-column grid on 375px width = 125px per thumbnail
      int previewSize;
      try {
        previewSize = (Get.width / _gridColumnCount).toInt();
      } catch (e) {
        previewSize = 200; // Fallback size
      }

      // Use custom options or create default based on screen size
      final thumbnailOption = options ??
          ThumbnailOption(
            size: ThumbnailSize(previewSize, previewSize),
            format: ThumbnailFormat.jpeg, // Best size/quality ratio
          );

      // Request caching through photo_manager
      // This will download and cache all thumbnails
      await _photoCacheManager.requestCacheAssets(
        assets: assets,
        option: thumbnailOption,
      );
    } catch (e, stackTrace) {
      // Cancel if error occurs to free resources
      await _photoCacheManager.cancelCacheRequest();
      _log.e('$_logTag: Error preloading thumbnails', e, stackTrace);
    }
  }

  // ==================== Service Lifecycle ====================

  /// Initialize the media gallery service
  ///
  /// **Main entry point** - call this once when app starts or user opens gallery.
  ///
  /// **Complete Setup Flow:**
  /// 1. Check/request photo library permissions
  /// 2. Load all albums from device
  /// 3. Set "All Photos" as default
  /// 4. Load first page of assets
  /// 5. Preload thumbnails for smooth display
  /// 6. Start listening for photo library changes
  ///
  /// **Why This Order?**
  /// - Permission first (nothing works without it)
  /// - Albums next (fast, no asset I/O)
  /// - Assets after (slower, requires album data)
  /// - Thumbnails last (optimization, non-blocking)
  /// - Listener always (auto-update when photos change)
  ///
  /// **Permission Handling:**
  /// - Returns early if no permission
  /// - Service will be limited until permission granted
  /// - Can call again after user grants permission
  ///
  /// **Auto-Update Feature:**
  /// - Listens for device photo library changes
  /// - Triggers refresh when user adds/deletes photos
  /// - Works even when app in background
  ///
  /// **When to Call:**
  /// - App startup (if gallery needed immediately)
  /// - User opens gallery feature first time
  /// - After user grants permission in settings
  /// - After user logs in (multi-user apps)
  ///
  /// **Side Effects:**
  /// - Populates all caches
  /// - Activates change notifications
  /// - May trigger permission dialog
  @override
  Future<void> initService() async {
    try {
      // Step 0: Reset state and release caches
      // Why? Clean slate on init
      await clearCache();
      _currentAlbum = null;
      _currentFilterMediaType = MediaGalleryFilterMediaType.imageAndVideo;

      // Step 1: Check permissions
      // Why first? Can't do anything without permission
      final hasPermission = await checkPermission();
      if (!hasPermission) {
        _log.w('$_logTag: No photo library permission, service limited');
        return; // Exit early, service won't be fully functional
      }

      // Step 2: Load all albums
      // Why? Need albums before we can load assets
      await getAlbums(requestType: _currentFilterMediaType);
      _log.d('$_logTag: Loaded ${_cachedAlbums.length} albums');

      // Step 3: Set default album
      // Why "All Photos"? Most users start here
      _currentAlbum = _findAllAlbum();
      if (_currentAlbum == null) {
        _log.w('$_logTag: No "All Photos" album found');
        return;
      }

      // Step 4: Load initial assets
      // Why refresh:true? Force fresh data on init
      final assets = await getImagesFromAlbum(albumId: _currentAlbum!.albumId, refresh: true);
      _log.d('$_logTag: Loaded ${assets.length} initial assets');

      // Step 5: Preload thumbnails
      // Why? Smooth scrolling from first interaction
      await preloadThumbnail(assets);

      // Step 6: Listen for photo library changes
      // Why? Auto-refresh when user takes new photos
      _setupChangeListener();

      _log.i('$_logTag: Media gallery service initialized successfully');
    } catch (e, stackTrace) {
      _log.e('$_logTag: Failed to initialize media gallery service', e, stackTrace);
      // Don't rethrow - allow app to continue with limited gallery
    }
  }

  void _setupChangeListener() async {
    await _removeChangeListener();
    PhotoManager.addChangeCallback(onChangeCallback);
    await PhotoManager.startChangeNotify();
    _log.i('$_logTag: Photo library change listener set up');
  }

  Future<void> _removeChangeListener() async {
    PhotoManager.removeChangeCallback(onChangeCallback);
    await PhotoManager.stopChangeNotify();
    _log.i('$_logTag: Photo library change listener removed');
  }

  /// Dispose the service and release all resources
  ///
  /// **Complete Cleanup** - call this when gallery no longer needed.
  ///
  /// **What Gets Cleaned:**
  /// - All memory caches (albums & assets)
  /// - Disk cache (thumbnails)
  /// - Photo library change listener
  /// - Ongoing operations (thumbnail preloads)
  ///
  /// **Why Call This?**
  /// - Prevent memory leaks
  /// - Release system resources
  /// - Stop background listeners
  /// - Free up disk space
  ///
  /// **When to Call:**
  /// - App closing/terminating
  /// - User logs out (multi-user apps)
  /// - Gallery feature permanently closed
  /// - Before re-initializing service
  ///
  /// **After Calling:**
  /// - Service must be re-initialized to use again
  /// - All cached data lost
  /// - Photo changes won't trigger updates
  ///
  /// **Safe to Call Multiple Times:**
  /// - Won't crash if already disposed
  /// - Won't error if never initialized
  @override
  Future<void> disposeService() async {
    try {
      // Step 1: Clear all caches
      // Why first? Releases most memory immediately
      await clearCache();

      // Step 2: Stop change notifications
      // Why? Prevent callbacks to disposed service
      PhotoManager.removeChangeCallback(onChangeCallback);
      await PhotoManager.stopChangeNotify();

      _log.i('$_logTag: Media gallery service disposed successfully');
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error disposing service', e, stackTrace);
      // Continue despite errors - best effort cleanup
    }
  }

  /// Clear ALL cached data and cancel ongoing operations
  ///
  /// **Nuclear Option** - removes everything from memory and disk.
  ///
  /// **What Gets Cleared:**
  /// - Memory: _cachedAlbums, _cachedAlbumAssets
  /// - Disk: PhotoManager file cache
  /// - Operations: Ongoing thumbnail preloads
  ///
  /// **Difference from releaseCache():**
  /// - clearCache(): Removes EVERYTHING (this method)
  /// - releaseCache(): Trims to recent 80 assets (optimization)
  ///
  /// **Use When:**
  /// - Permission changes (Limited → Full Access)
  /// - User explicitly pulls to refresh
  /// - Major photo library changes
  /// - Before disposing service
  /// - Out of memory situations
  ///
  /// **Performance Impact:**
  /// - Next fetch will be slower (full reload)
  /// - UI shows loading indicators
  /// - Worth it for ensuring data freshness
  ///
  /// **Recovery:**
  /// - Service auto-reloads on next operation
  /// - No manual intervention needed
  /// - All data repopulated from photo library
  @override
  Future<void> clearCache() async {
    try {
      // Clear in-memory structures
      // Why separate clears? Explicit and verifiable
      _cachedAlbumAssets.clear();
      _cachedAlbums.clear();

      // Reset loading locks to prevent stuck state
      _isLoadingAlbums = false;
      if (_albumLoadingCompleter != null && !_albumLoadingCompleter!.isCompleted) {
        _albumLoadingCompleter!.complete(false);
      }
      _albumLoadingCompleter = null;

      _log.d('$_logTag: Cleared in-memory caches');

      // Cancel any ongoing thumbnail preloads
      // Why? They reference old assets, waste resources
      await _photoCacheManager.cancelCacheRequest();

      // Clear PhotoManager's disk cache
      // Why? Frees disk space, ensures fresh thumbnails
      await PhotoManager.clearFileCache();
      _log.d('$_logTag: Cleared disk cache');

      _log.i('$_logTag: Cache cleared completely');
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error clearing cache', e, stackTrace);
      // Don't rethrow - partial clear is better than none
    }
  }

  /// Release memory by trimming to recent assets only
  ///
  /// **Memory Optimization** - keeps only what's needed for current view.
  ///
  /// **What Happens:**
  /// 1. Cancel ongoing operations (free resources)
  /// 2. Clear disk cache (free disk space)
  /// 3. Trim each album to first 80 assets
  /// 4. Preload thumbnails for trimmed "All Photos"
  ///
  /// **Why 80 Assets?**
  /// - Covers 2-3 screens (3-column grid = ~27 per screen)
  /// - Small enough: Saves significant memory
  /// - Large enough: Smooth back-scrolling
  /// - Sweet spot: Balances UX vs memory efficiency
  ///
  /// **Memory Savings:**
  /// - Each full asset = 1-5MB in memory
  /// - 80 assets = ~80-400MB (manageable)
  /// - 1000+ assets = 1-5GB (crashes on low-end devices!)
  ///
  /// **What Happens to Trimmed Assets?**
  /// - Removed from memory (not deleted from device)
  /// - Re-fetched if user scrolls back
  /// - Pagination seamlessly loads them again
  ///
  /// **When to Call:**
  /// - After loading 500+ assets (many pagination calls)
  /// - When app receives memory warning
  /// - Before memory-intensive operations
  /// - Periodically in long browsing sessions
  ///
  /// **Trade-off:**
  /// - Pro: Prevents OutOfMemory crashes
  /// - Con: Slight delay if user scrolls to trimmed section
  /// - Verdict: Much better than app crash!
  @override
  Future<void> releaseCache({bool clearPackageCache = false}) async {
    try {
      // Step 1: Cancel ongoing operations
      // Why? Free up resources for trimming operation
      await _photoCacheManager.cancelCacheRequest();

      // Step 2: Clear disk cache
      // Why? Disk space often limited on mobile
      // But don't clear package cache unless specified
      // Because it will clear all cached file so when close and open again, need to reload all files
      if (clearPackageCache) {
        await PhotoManager.clearFileCache();
        _log.d('$_logTag: Cleared disk cache for memory release');
      }

      // Step 3: Trim asset caches
      int totalTrimmed = 0;
      for (var entry in _cachedAlbumAssets.entries) {
        final albumId = entry.key;
        final assets = entry.value;
        final originalCount = assets.length;

        // Only trim if exceeds threshold
        // Why? Don't trim what's already optimal
        if (assets.length > 80) {
          // Keep first 80 (most recent/relevant)
          // Why first? User typically browses recent photos
          _cachedAlbumAssets[albumId] = assets.sublist(0, 80);
          totalTrimmed += (originalCount - 80);

          _log.d('$_logTag: Trimmed $albumId: $originalCount → 80 assets');
        }
      }

      // Step 4: Preload thumbnails for "All Photos"
      // Why? Most users return to "All Photos" view
      final allAlbumId = _allAlbumId;
      if (allAlbumId != null && allAlbumId.isNotEmpty) {
        _currentAlbum = _findAllAlbum();
        final assets = _cachedAlbumAssets[allAlbumId] ?? [];

        if (assets.isNotEmpty) {
          await preloadThumbnail(assets);
          _log.d('$_logTag: Preloaded ${assets.length} thumbnails for "All Photos"');
        }
      }

      _log.i('$_logTag: Cache released: trimmed $totalTrimmed assets');
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error releasing cache', e, stackTrace);
      // Don't fail - partial optimization better than none
    }
  }

  // ==================== Refresh & Updates ====================

  /// Callback for photo library changes
  ///
  /// **Auto-called by PhotoManager** when device photo library changes.
  ///
  /// **Change Types Detected:**
  /// - New photos taken by camera
  /// - Photos imported from cloud/computer
  /// - Photos/videos deleted
  /// - Albums created/renamed/deleted
  /// - Photos moved between albums
  ///
  /// **How It Works:**
  /// 1. PhotoManager monitors native platform events
  /// 2. Native system notifies when library changes
  /// 3. PhotoManager calls this callback with details
  /// 4. We compare counts and trigger refresh if needed
  ///
  /// **Smart Filtering:**
  /// - Ignores non-change events (e.g., metadata updates)
  /// - Only refreshes if asset count actually changed
  /// - Why? Avoid unnecessary refreshes on irrelevant changes
  ///
  /// **Performance:**
  /// - Lightweight: Just compares integers
  /// - Async: Refresh doesn't block this callback
  /// - Efficient: Only refreshes current album, not all
  ///
  /// **Real-World Scenarios:**
  /// - User takes photo → count increases → gallery refreshes ✓
  /// - User edits photo → count unchanged → no refresh (correct!)
  /// - User deletes 5 photos → count decreases → gallery refreshes ✓
  /// - User favorites photo → metadata only → no refresh (correct!)
  ///
  /// **Parameters (from MethodCall):**
  /// - type: 'change', 'added', 'deleted'
  /// - oldCount: Asset count before change
  /// - newCount: Asset count after change
  void onChangeCallback(MethodCall methodCall) {
    _log.i('$_logTag: onChangeCallback called ($methodCall)');
    // We only care about 'change' events
    if (methodCall.method != 'change') {
      return;
    }

    // Extract change data
    final argument = methodCall.arguments;
    if (argument is! Map) {
      _log.d('$_logTag: Invalid callback argument type');
      return;
    }

    /// TODO: change how to check the change, instead of checking the count, we can check the actual changed assets
    /// because sometimes the count may not change but the assets have changed (e.g. move asset between albums)
    ///
    /// In the case of add a new asset and delete an asset at the same time, the count will not change but the assets have changed
    /// So we need to check the actual changed assets instead of just checking the count

    // List of change types we care about
    final createList = argument['create'] ?? [];
    final deleteList = argument['delete'] ?? [];
    final updateList = argument['update'] ?? [];

    // If no actual asset changes, skip refresh
    // Why? Avoid unnecessary refreshes

    // Trigger refresh if any assets were created, deleted, or updated
    if (createList.isNotEmpty || deleteList.isNotEmpty || updateList.isNotEmpty) {
      _log.i(
          '$_logTag: Detected asset changes - create: ${createList.length}, delete: ${deleteList.length}, update: ${updateList.length}');
      // Async refresh - doesn't block callback
      refreshCurrentAlbum();
      return;
    }
  }

  /// Refresh assets for current album
  ///
  /// **Smart Refresh** - reloads only what's currently displayed.
  ///
  /// **What Gets Refreshed:**
  /// - Current album's assets
  /// - First page only (limit: 40)
  /// - Thumbnails for smooth display
  ///
  /// **What Doesn't Get Refreshed:**
  /// - Other albums (lazy loaded when viewed)
  /// - Album list (rarely changes)
  /// - Why? Efficiency - only update what user sees
  ///
  /// **Flow:**
  /// 1. Verify albums are loaded
  /// 2. Get current album (or fallback to "All Photos")
  /// 3. Fetch fresh assets (clears cache for this album)
  /// 4. Preload thumbnails
  /// 5. Event bus notifies UI to update
  ///
  /// **When Called:**
  /// - Auto: onChangeCallback detects library changes
  /// - Manual: User pulls to refresh in UI
  /// - After: Permission granted
  /// - After: User returns from camera
  ///
  /// **Parameters:**
  /// - [limit]: Assets to load (default: 40 = first page)
  ///
  /// **Side Effects:**
  /// - Clears asset cache for current album only
  /// - Re-fetches from photo library (I/O operation)
  /// - Updates _cachedAlbumAssets
  /// - Preloads new thumbnails
  /// - Fires UpdateGalleryAssetEvent (UI updates)
  ///
  /// **Performance:**
  /// - Async: Doesn't block calling code
  /// - Targeted: Only current album, not all albums
  /// - Efficient: Reuses album list (no re-fetch)
  /// - Smart: First page only (user rarely at page 50)
  @override
  Future<void> refreshCurrentAlbum({int limit = _defaultLimit}) async {
    try {
      final albumName = _currentAlbum?.albumName ?? 'unknown';
      _log.d('$_logTag: Starting refresh for album: $albumName');

      // Step 1: Ensure albums are loaded
      // Why? Current album might be stale if not loaded
      await _ensureAlbumsLoaded(requestType: _currentFilterMediaType);

      // Step 2: Get current album with fallback
      // Why fallback? _currentAlbum might be null on first load
      final album = _currentAlbum ?? _findAllAlbum();
      if (album == null) {
        throw Exception('No albums available to refresh');
      }

      // Step 3: Fetch fresh assets with cache clear
      // refresh: true → clears cache, forces new fetch
      final assets = await getImagesFromAlbum(
        albumId: album.albumId,
        limit: limit,
        refresh: true, // Critical: clears cache for fresh data
      );

      // Step 4: Preload thumbnails for smooth UI
      // Why? User expects instant display after refresh
      await preloadThumbnail(assets);

      _log.i('$_logTag: Refreshed ${assets.length} assets for ${album.albumName}');
    } catch (e, stackTrace) {
      _log.e('$_logTag: Error refreshing album', e, stackTrace);
      // Don't rethrow - let app continue with stale data
    }
  }
}
