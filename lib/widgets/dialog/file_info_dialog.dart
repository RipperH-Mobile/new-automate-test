import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/widgets/file_info/file_info_list.dart';

class FileInfoDialog extends StatelessWidget {
  const FileInfoDialog({
    super.key,
    required this.fileInfoList,
  });

  final FileInfoList fileInfoList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(
                20.spMin,
              ),
              child: Text(
                'Details'.tr,
                style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                12.spMin,
              ),
              child: InkWell(
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
                    cacheWidth: 50.cacheSize,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
        const Divider(
          height: 0,
          thickness: 1,
          color: Color(0xFFF2F2F2),
        ),
        fileInfoList,
      ],
    );
  }
}
