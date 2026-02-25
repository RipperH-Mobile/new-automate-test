import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uchat/themes/themes.dart';

class ResendPopup extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onResend;

  const ResendPopup({
    super.key,
    required this.onDelete,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 26,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCloseButton(),
            _buildTitle(),
            _buildSubtitle(),
            const SizedBox(height: 26),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Align(
      alignment: Alignment.topRight,
      widthFactor: 50,
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: .2),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Image(
                image: AssetImage(
                  'assets/images/v2/cross.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        'Send message failed'.tr,
        style: UTheme.textTheme.appBarTitle.copyWith(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'There was an error sending the message.'.tr,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF808080),
        fontSize: 12,
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          label: 'Delete'.tr,
          color: const Color(0xFFF2F2F2),
          textColor: const Color(0xFFFF1552),
          onPressed: onDelete,
          key: const ValueKey('delete'),
        ),
        const SizedBox(width: 16),
        _buildActionButton(
          label: 'Resend'.tr,
          color: UTheme.color.primary,
          textColor: Colors.white,
          onPressed: onResend,
          key: const ValueKey('resend'),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    required ValueKey<String> key,
  }) {
    return Expanded(
      child: TextButton(
        key: key,
        style: TextButton.styleFrom(
          backgroundColor: color,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label.tr,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
