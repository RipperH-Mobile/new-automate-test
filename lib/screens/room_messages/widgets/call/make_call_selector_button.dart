import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/animation/transition/top_transition.dart';
import 'package:uchat/widgets/effect/blur_box.dart';

class MakeCallSelectorButton extends StatelessWidget {
  final bool show;
  final bool isSecretRoom;
  final VoidCallback onStartVoiceCall;
  final VoidCallback onStartVideoCall;

  const MakeCallSelectorButton({
    super.key,
    this.show = false,
    this.isSecretRoom = false,
    required this.onStartVoiceCall,
    required this.onStartVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: fromTopTransitionBuilder,
      child: Builder(builder: (_) {
        if (!show) {
          return const SizedBox.shrink();
        } else {
          return BlurBox(
            child: SizedBox(
              height: 100.spMin,
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          25.spMin,
                          20.spMin,
                          10.spMin,
                          20.spMin,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 8.spMin,
                                color: Colors.black.withValues(alpha: 0.07),
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.r),
                            color: isSecretRoom == true
                                ? UTheme.color.secretRoomCallButton
                                : UTheme.color.normalRoomCallButton,
                          ),
                          height: 60.spMin,
                          child: TextButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                            ),
                            onPressed: onStartVoiceCall,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.spMin,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Image.asset(
                                      'assets/images/uchat_phone_call.png',
                                      height: 30.spMin,
                                      width: 30.spMin,
                                      cacheWidth: 30.cacheSize,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Voice call'.tr,
                                      style: TextStyle(
                                        color: UTheme.color.onTextButton,
                                        fontSize: 14.spMin,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          10.spMin,
                          20.spMin,
                          25.spMin,
                          20.spMin,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 8.spMin,
                                color: Colors.black.withValues(alpha: 0.07),
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                            color: isSecretRoom == true
                                ? UTheme.color.secretRoomCallButton
                                : UTheme.color.normalRoomCallButton,
                          ),
                          height: 60.spMin,
                          child: TextButton(
                            onPressed: onStartVideoCall,
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.spMin,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Image.asset(
                                      'assets/images/uchat_phone_video.png',
                                      width: 30.spMin,
                                      height: 30.spMin,
                                      cacheWidth: 30.spMin.cacheSize,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Video call'.tr,
                                      style: TextStyle(
                                        color: UTheme.color.onTextButton,
                                        fontSize: 14.spMin,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: isSecretRoom == true
                  ? UTheme.color.secretRoomBackgroundCallSelect
                  : UTheme.color.normalRoomBackgroundCallSelect.withValues(alpha: 0.6),
              border: Border(
                bottom: BorderSide(
                  color: isSecretRoom == true ? const Color(0x33E6E6E6) : const Color(0x80E6E6E6),
                ),
              ),
            ),
            blurWeight: 10,
            borderRadius: BorderRadius.zero,
          );
        }
      }),
    );
  }
}
