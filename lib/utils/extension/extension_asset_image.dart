import 'package:flutter/material.dart';
import 'package:uchat/gen/assets.gen.dart';

extension AssetGenImageExtension on AssetGenImage {
  AssetImage toAssetImage() => AssetImage(path);
}
