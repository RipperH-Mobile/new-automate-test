import 'package:any_link_preview/any_link_preview.dart';

/// Wrapper class for AnyLinkPreview to make it testable
class LinkPreviewWrapper {
  const LinkPreviewWrapper();

  /// Get metadata for a URL
  Future<Metadata?> getMetadata({required String link}) async {
    return AnyLinkPreview.getMetadata(link: link);
  }
}