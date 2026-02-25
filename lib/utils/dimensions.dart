import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenUtilInitWidget extends StatelessWidget {
  final Widget child;

  const ScreenUtilInitWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      ///Setting font does not change with system font size
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: false,
        child: child,
        builder: (BuildContext context, Widget? child) => child ?? const SizedBox.shrink(),
      ),
    );
  }
}

extension ResponsiveSize on num {
  // Define the standard sizes used in your UX/UI design
  static const double _standardHeight = 932; // Standard height
  static const double _standardWidth = 430; // Standard width

  // hr = height responsive
  double get hr {
    return (Get.height / (_standardHeight / this));
  }

  double hrWith(double height) {
    return (Get.height / (height / this));
  }

  // wr = width responsive
  double get wr {
    return (Get.width / (_standardWidth / this));
  }

  double wrWith(double width) {
    return (Get.width / (width / this));
  }
}
