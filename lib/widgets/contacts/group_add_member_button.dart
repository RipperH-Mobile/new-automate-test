import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

class GroupAddMemberButton extends StatelessWidget {
  final Function()? onTap;
  final Color? color;

  const GroupAddMemberButton({
    super.key,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade300,
              child: const CircleAvatar(
                radius: 27,
                backgroundColor: Colors.white,
                child: Image(
                  image: AssetImage(
                    'assets/images/plus_icon.png',
                  ),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                'Add'.tr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color ?? UTheme.color.scaffoldOnBackground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
