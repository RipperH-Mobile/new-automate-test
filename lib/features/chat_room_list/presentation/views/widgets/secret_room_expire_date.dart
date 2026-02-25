import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/secret_chat_expire_text.dart';

class SecretRoomExpireDateWidget extends StatefulWidget {
  final DateTime? expirationDate;

  const SecretRoomExpireDateWidget({super.key, this.expirationDate});

  @override
  SecretRoomExpireDateWidgetState createState() => SecretRoomExpireDateWidgetState();
}

class SecretRoomExpireDateWidgetState extends State<SecretRoomExpireDateWidget> {
  late Timer _timer;
  String _remainingTime = '';

  @override
  void initState() {
    updateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateRemainingTime();
    });

    super.initState();
  }

  void updateRemainingTime() {
    final dateTimeNow = DateTime.now();
    final expirationDate = widget.expirationDate ?? dateTimeNow.add(const Duration(minutes: 10));
    final timeDuration = expirationDate.difference(dateTimeNow);
    final expireStatus = calculateSecretChatExpireStatus(now: dateTimeNow, expireAt: expirationDate);

    if (expireStatus == SecretChatExpireStatus.expired) {
      setState(() {
        _remainingTime = 'Expired'.tr;
      });
    } else if (expireStatus == SecretChatExpireStatus.lessThanAnHour) {
      setState(() {
        _remainingTime = 'Expire in @min:@sec mins'.trParams({
          'min': timeDuration.inMinutes.toString().padLeft(2, '0'),
          'sec': (timeDuration.inSeconds % 60).toString().padLeft(2, '0'),
        });
      });
    } else if (expireStatus == SecretChatExpireStatus.sameDay) {
      setState(() {
        _remainingTime = 'Expire at @time'.trParams({'time': expirationDate.format('Hm')});
      });
    } else {
      setState(() {
        _remainingTime = 'Expire on @date'.trParams({'date': expirationDate.format('dd/MM/y')});
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Icon(
            Icons.lock,
            color: UTheme.color.secretRoomTitle,
            size: 15.spMin,
          ),
        ),
        SizedBox(width: 6.spMin),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 7.spMin,
            vertical: 2.spMin,
          ),
          decoration: BoxDecoration(
            color: _remainingTime == 'Expired'.tr ? const Color(0xff999999) : const Color(0xffff9100),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            _remainingTime,
            style: TextStyle(
              color: UTheme.color.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ),
        SizedBox(width: 6.spMin),
      ],
    );
  }
}
