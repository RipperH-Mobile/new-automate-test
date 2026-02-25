import 'package:flutter/widgets.dart';

/// Extension methods for creating SizedBox widgets from numeric values.
///
/// Usage:
///   16.0.height -> SizedBox(height: 16.0)
///   16.0.width -> SizedBox(width: 16.0)
extension SizedBoxExtension on num {
  /// Returns a SizedBox with the specified height
  /// Usage: 16.0.height -> SizedBox(height: 16.0)
  SizedBox get height => SizedBox(height: toDouble());

  /// Returns a SizedBox with the specified width
  /// Usage: 16.0.width -> SizedBox(width: 16.0)
  SizedBox get width => SizedBox(width: toDouble());
}