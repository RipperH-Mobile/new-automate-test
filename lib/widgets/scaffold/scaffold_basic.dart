import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

class ScaffoldBasic extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  final Function()? onBodyTap;
  final Widget? bottomSheet;

  const ScaffoldBasic({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
    this.onBodyTap,
    this.bottomSheet,
  });

  static PreferredSizeWidget appBarBasic({
    required Widget title,
    double? elevation,
    List<Widget>? actions,
    void Function()? handleBack,
    bool centerTitle = true,
    bool automaticallyImplyLeading = true,
    double titleSpacing = 0,
    Color? backgroundColor,
    bool isCrop = false,
  }) {
    return AppBar(
      backgroundColor: isCrop ? Colors.black : backgroundColor ?? UTheme.color.appBar,
      shadowColor: UTheme.color.appBarShadow,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      title: title,
      titleSpacing: titleSpacing,
      actions: actions,
      leading: (handleBack != null)
          ? AppBarIconLeadingButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                handleBack.call();
              },
            )
          : null,
    );
  }

  // static PreferredSizeWidget appBarBasicWithBack({
  //   required Widget title,
  //   required void Function() handleBack,
  //   required BuildContext context,
  //   double? elevation,
  //   List<Widget>? actions,
  //   bool centerTitle = true,
  //   bool automaticallyImplyLeading = true,
  //   double titleSpacing = 0,
  //   Color? backgroundColor,
  //   bool isCrop = false,
  // }) {
  //   return AppBar(
  //       backgroundColor: isCrop ? Colors.black : backgroundColor ?? UTheme.color.appBar,
  //       shadowColor: UTheme.color.appBarShadow,
  //       automaticallyImplyLeading: automaticallyImplyLeading,
  //       elevation: elevation ?? 0,
  //       centerTitle: centerTitle,
  //       title: title,
  //       titleSpacing: titleSpacing,
  //       actions: actions,
  //       leadingWidth: 120,
  //       leading: AppControlButton.back(
  //         context: context,
  //         onTap: () => handleBack.call(),
  //       )

  //       // InkWell(
  //       //     onTap: () {
  //       //       handleBack.call();
  //       //     },
  //       //     child: Row(
  //       //       crossAxisAlignment: CrossAxisAlignment.center,
  //       //       children: [
  //       //         AppBarIconLeadingButton(
  //       //           color: UTheme.color.primary,
  //       //           icon: const Icon(Icons.arrow_back_ios),
  //       //           onPressed: () {
  //       //             handleBack.call();
  //       //           },
  //       //         ),
  //       //         Text('Back'.tr, style: TextStyle(color: UTheme.color.primary, fontSize: 17)),
  //       //       ],
  //       //     ))
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      backgroundColor: backgroundColor ?? UTheme.color.scaffoldBackground,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }

          onBodyTap?.call();
        },
        child: child,
      ),
      bottomSheet: bottomSheet,
    );
  }
}
