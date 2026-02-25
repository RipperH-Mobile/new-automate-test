import 'down_sampled_image.dart';
import 'downsized_image.dart';
import 'full_image.dart';
import 'looping_image.dart';
import 'original_image.dart';
import 'preview_image.dart';
import 'still_image.dart';
import 'webp_image.dart';

class GiphyImages {
  final GiphyStillImage? fixedHeightStill;
  final GiphyStillImage? originalStill;
  final GiphyFullImage? fixedWidth;
  final GiphyStillImage? fixedHeightSmallStill;
  final GiphyDownSampledImage? fixedHeightDownSampled;
  final GiphyPreviewImage? preview;
  final GiphyFullImage? fixedHeightSmall;
  final GiphyStillImage? downsizedStill;
  final GiphyDownsizedImage? downsized;
  final GiphyDownsizedImage? downsizedLarge;
  final GiphyStillImage? fixedWidthSmallStill;
  final GiphyWebPImage? previewWebp;
  final GiphyStillImage? fixedWidthStill;
  final GiphyFullImage? fixedWidthSmall;
  final GiphyPreviewImage? downsizedSmall;
  final GiphyDownSampledImage? fixedWidthDownSampled;
  final GiphyPreviewImage? downsizedMedium;
  final GiphyOriginalImage? original;
  final GiphyFullImage? fixedHeight;
  final GiphyPreviewImage? hd;
  final GiphyLoopingImage? looping;
  final GiphyPreviewImage? originalMp4;
  final GiphyDownsizedImage? previewGif;
  final GiphyStillImage? w480Still;

  GiphyImages({
    this.fixedHeightStill,
    this.originalStill,
    this.fixedWidth,
    this.fixedHeightSmallStill,
    this.fixedHeightDownSampled,
    this.preview,
    this.fixedHeightSmall,
    this.downsizedStill,
    this.downsized,
    this.downsizedLarge,
    this.fixedWidthSmallStill,
    this.previewWebp,
    this.fixedWidthStill,
    this.fixedWidthSmall,
    this.downsizedSmall,
    this.fixedWidthDownSampled,
    this.downsizedMedium,
    this.original,
    this.fixedHeight,
    this.hd,
    this.looping,
    this.originalMp4,
    this.previewGif,
    this.w480Still,
  });

  factory GiphyImages.fromJson(Map<String, dynamic> json) {
    GiphyStillImage? fixedHeightStill;
    if (json['fixed_height_still'] != null && json['fixed_height_still'].toString() != '{}') {
      fixedHeightStill = GiphyStillImage.fromJson(
        json['fixed_height_still'] as Map<String, dynamic>,
      );
    }

    GiphyStillImage? originalStill;
    if (json['original_still'] != null && json['original_still'].toString() != '{}') {
      originalStill = GiphyStillImage.fromJson(
        json['original_still'] as Map<String, dynamic>,
      );
    }

    GiphyFullImage? fixedWidth;
    if (json['fixed_width'] != null && json['fixed_width'].toString() != '{}') {
      fixedWidth = GiphyFullImage.fromJson(
        json['fixed_width'] as Map<String, dynamic>,
      );
    }

    GiphyStillImage? fixedHeightSmallStill;
    if (json['fixed_height_small_still'] != null && json['fixed_height_small_still'].toString() != '{}') {
      fixedHeightSmallStill = GiphyStillImage.fromJson(
        json['fixed_height_small_still'] as Map<String, dynamic>,
      );
    }

    GiphyDownSampledImage? fixedHeightDownsampled;
    if (json['fixed_height_downsampled'] != null && json['fixed_height_downsampled'].toString() != '{}') {
      fixedHeightDownsampled = GiphyDownSampledImage.fromJson(
        json['fixed_height_downsampled'] as Map<String, dynamic>,
      );
    }

    GiphyPreviewImage? preview;
    if (json['preview'] != null && json['preview'].toString() != '{}') {
      preview = GiphyPreviewImage.fromJson(
        json['preview'] as Map<String, dynamic>,
      );
    }

    GiphyFullImage? fixedHeightSmall;
    if (json['fixed_height_small'] != null && json['fixed_height_small'].toString() != '{}') {
      fixedHeightSmall = GiphyFullImage.fromJson(
        json['fixed_height_small'] as Map<String, dynamic>,
      );
    }

    GiphyStillImage? downsizedStill;
    if (json['downsized_still'] != null && json['downsized_still'].toString() != '{}') {
      downsizedStill = GiphyStillImage.fromJson(
        json['downsized_still'] as Map<String, dynamic>,
      );
    }

    GiphyDownsizedImage? downsized;
    if (json['downsized'] != null && json['downsized'].toString() != '{}') {
      downsized = GiphyDownsizedImage.fromJson(
        json['downsized'] as Map<String, dynamic>,
      );
    }

    GiphyDownsizedImage? downsizedLarge;
    if (json['downsized_large'] != null && json['downsized_large'].toString() != '{}') {
      downsizedLarge = GiphyDownsizedImage.fromJson(
        json['downsized_large'] as Map<String, dynamic>,
      );
    }

    GiphyStillImage? fixedWidthSmallStill;
    if (json['fixed_width_small_still'] != null && json['fixed_width_small_still'].toString() != '{}') {
      fixedWidthSmallStill = GiphyStillImage.fromJson(
        json['fixed_width_small_still'] as Map<String, dynamic>,
      );
    }

    GiphyWebPImage? previewWebp;
    if (json['preview_webp'] != null && json['preview_webp'].toString() != '{}') {
      previewWebp = GiphyWebPImage.fromJson(
        json['preview_webp'] as Map<String, dynamic>,
      );
    }

    GiphyStillImage? fixedWidthStill;
    if (json['fixed_width_still'] != null && json['fixed_width_still'].toString() != '{}') {
      fixedWidthStill = GiphyStillImage.fromJson(
        json['fixed_width_still'] as Map<String, dynamic>,
      );
    }

    GiphyFullImage? fixedWidthSmall;
    if (json['fixed_width_small'] != null && json['fixed_width_small'].toString() != '{}') {
      fixedWidthSmall = GiphyFullImage.fromJson(
        json['fixed_width_small'] as Map<String, dynamic>,
      );
    }

    GiphyPreviewImage? downsizedSmall;
    if (json['downsized_small'] != null && json['downsized_small'].toString() != '{}') {
      downsizedSmall = GiphyPreviewImage.fromJson(
        json['downsized_small'] as Map<String, dynamic>,
      );
    }

    GiphyDownSampledImage? fixedWidthDownsampled;
    if (json['fixed_width_downsampled'] != null && json['fixed_width_downsampled'].toString() != '{}') {
      fixedWidthDownsampled = GiphyDownSampledImage.fromJson(
        json['fixed_width_downsampled'] as Map<String, dynamic>,
      );
    }

    GiphyPreviewImage? downsizedMedium;
    if (json['downsized_medium'] != null && json['downsized_medium'].toString() != '{}') {
      downsizedMedium = GiphyPreviewImage.fromJson(
        json['downsized_medium'] as Map<String, dynamic>,
      );
    }

    GiphyOriginalImage? original;
    if (json['original'] != null && json['original'].toString() != '{}') {
      original = GiphyOriginalImage.fromJson(
        json['original'] as Map<String, dynamic>,
      );
    }

    GiphyFullImage? fixedHeight;
    if (json['fixed_height'] != null && json['fixed_height'].toString() != '{}') {
      fixedHeight = GiphyFullImage.fromJson(
        json['fixed_height'] as Map<String, dynamic>,
      );
    }

    GiphyPreviewImage? hd;
    if (json['hd'] != null && json['hd'].toString() != '{}') {
      hd = GiphyPreviewImage.fromJson(
        json['hd'] as Map<String, dynamic>,
      );
    }

    GiphyLoopingImage? looping;
    if (json['looping'] != null && json['looping'].toString() != '{}') {
      looping = GiphyLoopingImage.fromJson(
        json['looping'] as Map<String, dynamic>,
      );
    }

    GiphyPreviewImage? originalMp4;
    if (json['original_mp4'] != null && json['original_mp4'].toString() != '{}') {
      originalMp4 = GiphyPreviewImage.fromJson(
        json['original_mp4'] as Map<String, dynamic>,
      );
    }

    GiphyDownsizedImage? previewGif;
    if (json['preview_gif'] != null && json['preview_gif'].toString() != '{}') {
      previewGif = GiphyDownsizedImage.fromJson(
        json['preview_gif'] as Map<String, dynamic>,
      );
    }

    GiphyStillImage? w480Still;
    if (json['480w_still'] != null && json['480w_still'].toString() != '{}') {
      w480Still = GiphyStillImage.fromJson(
        json['480w_still'] as Map<String, dynamic>,
      );
    }

    return GiphyImages(
      fixedHeightStill: fixedHeightStill,
      originalStill: originalStill,
      fixedWidth: fixedWidth,
      fixedHeightSmallStill: fixedHeightSmallStill,
      fixedHeightDownSampled: fixedHeightDownsampled,
      preview: preview,
      fixedHeightSmall: fixedHeightSmall,
      downsizedStill: downsizedStill,
      downsized: downsized,
      downsizedLarge: downsizedLarge,
      fixedWidthSmallStill: fixedWidthSmallStill,
      previewWebp: previewWebp,
      fixedWidthStill: fixedWidthStill,
      fixedWidthSmall: fixedWidthSmall,
      downsizedSmall: downsizedSmall,
      fixedWidthDownSampled: fixedWidthDownsampled,
      downsizedMedium: downsizedMedium,
      original: original,
      fixedHeight: fixedHeight,
      hd: hd,
      looping: looping,
      originalMp4: originalMp4,
      previewGif: previewGif,
      w480Still: w480Still,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fixed_height_still': fixedHeightStill,
      'original_still': originalStill,
      'fixed_width': fixedWidth,
      'fixed_height_small_still': fixedHeightSmallStill,
      'fixed_height_downsampled': fixedHeightDownSampled,
      'preview': preview,
      'fixed_height_small': fixedHeightSmall,
      'downsized_still': downsizedStill,
      'downsized': downsized,
      'downsized_large': downsizedLarge,
      'fixed_width_small_still': fixedWidthSmallStill,
      'preview_webp': previewWebp,
      'fixed_width_still': fixedWidthStill,
      'fixed_width_small': fixedWidthSmall,
      'downsized_small': downsizedSmall,
      'fixed_width_downsampled': fixedWidthDownSampled,
      'downsized_medium': downsizedMedium,
      'original': original,
      'fixed_height': fixedHeight,
      'hd': hd,
      'looping': looping,
      'original_mp4': originalMp4,
      'preview_gif': previewGif,
      '480w_still': w480Still
    };
  }

  @override
  String toString() {
    return 'GiphyImages{fixedHeightStill: $fixedHeightStill, originalStill: $originalStill, fixedWidth: $fixedWidth, fixedHeightSmallStill: $fixedHeightSmallStill, fixedHeightDownsampled: $fixedHeightDownSampled, preview: $preview, fixedHeightSmall: $fixedHeightSmall, downsizedStill: $downsizedStill, downsized: $downsized, downsizedLarge: $downsizedLarge, fixedWidthSmallStill: $fixedWidthSmallStill, previewWebp: $previewWebp, fixedWidthStill: $fixedWidthStill, fixedWidthSmall: $fixedWidthSmall, downsizedSmall: $downsizedSmall, fixedWidthDownsampled: $fixedWidthDownSampled, downsizedMedium: $downsizedMedium, original: $original, fixedHeight: $fixedHeight, hd: $hd, looping: $looping, originalMp4: $originalMp4, previewGif: $previewGif, w480Still: $w480Still}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyImages &&
          runtimeType == other.runtimeType &&
          fixedHeightStill == other.fixedHeightStill &&
          originalStill == other.originalStill &&
          fixedWidth == other.fixedWidth &&
          fixedHeightSmallStill == other.fixedHeightSmallStill &&
          fixedHeightDownSampled == other.fixedHeightDownSampled &&
          preview == other.preview &&
          fixedHeightSmall == other.fixedHeightSmall &&
          downsizedStill == other.downsizedStill &&
          downsized == other.downsized &&
          downsizedLarge == other.downsizedLarge &&
          fixedWidthSmallStill == other.fixedWidthSmallStill &&
          previewWebp == other.previewWebp &&
          fixedWidthStill == other.fixedWidthStill &&
          fixedWidthSmall == other.fixedWidthSmall &&
          downsizedSmall == other.downsizedSmall &&
          fixedWidthDownSampled == other.fixedWidthDownSampled &&
          downsizedMedium == other.downsizedMedium &&
          original == other.original &&
          fixedHeight == other.fixedHeight &&
          hd == other.hd &&
          looping == other.looping &&
          originalMp4 == other.originalMp4 &&
          previewGif == other.previewGif &&
          w480Still == other.w480Still;

  @override
  int get hashCode =>
      fixedHeightStill.hashCode ^
      originalStill.hashCode ^
      fixedWidth.hashCode ^
      fixedHeightSmallStill.hashCode ^
      fixedHeightDownSampled.hashCode ^
      preview.hashCode ^
      fixedHeightSmall.hashCode ^
      downsizedStill.hashCode ^
      downsized.hashCode ^
      downsizedLarge.hashCode ^
      fixedWidthSmallStill.hashCode ^
      previewWebp.hashCode ^
      fixedWidthStill.hashCode ^
      fixedWidthSmall.hashCode ^
      downsizedSmall.hashCode ^
      fixedWidthDownSampled.hashCode ^
      downsizedMedium.hashCode ^
      original.hashCode ^
      fixedHeight.hashCode ^
      hd.hashCode ^
      looping.hashCode ^
      originalMp4.hashCode ^
      previewGif.hashCode ^
      w480Still.hashCode;
}
