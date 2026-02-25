import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension.dart';

class LockedMessageDialog extends StatefulWidget {
  final Function(String) onSubmit;
  final bool isError;

  const LockedMessageDialog({
    super.key,
    required this.onSubmit,
    this.isError = false,
  });

  @override
  LockedMessageDialogState createState() => LockedMessageDialogState();
}

class LockedMessageDialogState extends State<LockedMessageDialog> {
  String? password;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titlePadding: EdgeInsets.only(
        top: 0.h,
      ),
      actionsPadding: EdgeInsets.only(bottom: 23.spMin),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 13.spMin,
                vertical: 12.spMin,
              ),
              child: InkWell(
                onTap: () => Get.back<bool>(result: false),
                child: Container(
                  width: 25.spMin,
                  height: 25.spMin,
                  padding: EdgeInsets.all(7.spMin),
                  decoration: const BoxDecoration(
                    color: Color(0xFFcccccc),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    UChatAssetPath.crossIcon,
                    height: 5.spMin,
                    width: 5.spMin,
                    cacheWidth: 50.cacheSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Enter PIN'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 18.spMin,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter your PIN to unlock and view the message.'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 14.spMin,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.spMin),
          TextField(
            obscureText: isObscured,
            onChanged: (value) {
              setState(() {
                password = value;
                if (widget.isError && password!.isNotEmpty) {
                  widget.onSubmit(''); // Reset the error state when the user starts typing
                }
              });
            },
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 16.spMin,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              hintText: 'Enter your PIN'.tr,
              hintStyle: TextStyle(
                color: const Color(0xFF808080),
                fontSize: 14.spMin,
                fontWeight: FontWeight.w400,
              ),
              errorText: widget.isError && password!.isNotEmpty ? 'Password incorrect'.tr : null,
              suffixIcon: IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: Color(0xFFF2F2F2),
                ),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 15.spMin),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.spMin,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Cancel'.tr,
                    style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16.spMin,
            ),
            Expanded(
              child: GestureDetector(
                onTap: password != null && password!.isNotEmpty
                    ? () {
                        widget.onSubmit(password!);
                      }
                    : null,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: password != null && password!.isNotEmpty ? UTheme.color.primary : const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Confirm'.tr,
                    style: TextStyle(
                      color:
                          (password != null && password!.isNotEmpty) ? UTheme.color.onPrimary : const Color(0xFF808080),
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 24.spMin,
            ),
          ],
        )
      ],
    );
  }
}
