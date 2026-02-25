import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/auth/presentation/controllers/welcome/welcome_controller.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/dimensions.dart';

// Validation patterns for different URL types
final RegExp _regExpHttpUrl =
    RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?');
final RegExp _regExpWsUrl =
    RegExp(r'(ws|wss)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?');

// ============================================================================
// Reusable Components
// ============================================================================

/// Common dialog styling constants
const _kDialogBackgroundColor = Color(0xFF22242A);
const _kButtonBackgroundColor = Color(0xFF3A4253);
const _kSecondaryBackgroundColor = Color(0xFF323741);
const _kTextMutedColor = Color(0xFFB0B8CC);
const _kTextLabelColor = Color(0xFF7B849C);
const _kDescriptionColor = Color(0xFFAFB7CB);
const _kErrorColor = Color(0xFFFF3D70);

/// Reusable dialog wrapper that shows a dialog with common styling
Future<T?> _showEnvDialog<T>({required Widget child}) {
  return Get.dialog<T>(
    Dialog(
      backgroundColor: _kDialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.spMin)),
      child: Padding(
        padding: EdgeInsets.all(22.spMin),
        child: child,
      ),
    ),
    barrierDismissible: false,
  );
}

/// Circle icon button used for close/back actions
Widget _buildCircleIconButton({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.spMin),
      decoration: const BoxDecoration(color: _kButtonBackgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: _kTextMutedColor, size: 16.spMin),
    ),
  );
}

/// Dialog header with optional back button, close button, title, and description
Widget _buildDialogHeader({
  required String title,
  String? description,
  Color titleColor = Colors.white,
  VoidCallback? onBack,
  bool showClose = true,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Navigation buttons row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onBack != null)
            _buildCircleIconButton(icon: Icons.arrow_back, onTap: onBack)
          else
            const SizedBox(width: 32),
          if (showClose)
            _buildCircleIconButton(icon: Icons.close, onTap: Get.back)
          else
            const SizedBox(width: 32),
        ],
      ),
      SizedBox(height: 10.spMin),
      // Title
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: titleColor, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      if (description != null) ...[
        SizedBox(height: 9.spMin),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _kDescriptionColor, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    ],
  );
}

/// Primary action button (full width)
Widget _buildPrimaryButton({
  required String text,
  required VoidCallback? onPressed,
  Color? backgroundColor,
  Color? textColor,
  bool expanded = false,
}) {
  final button = TextButton(
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor ?? UTheme.color.primary,
      padding: EdgeInsets.symmetric(vertical: 14.spMin),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.spMin)),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: textColor ?? UTheme.color.onPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  return expanded ? Expanded(child: button) : SizedBox(width: double.infinity, child: button);
}

/// Secondary action button (for use in button rows)
Widget _buildSecondaryButton({
  required String text,
  required VoidCallback onPressed,
  Color? backgroundColor,
  Color? textColor,
}) {
  return Expanded(
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? _kSecondaryBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 14.spMin),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.spMin)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor ?? _kTextMutedColor, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

void dialogToggleEnvMode() async {
  await _showEnvDialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDialogHeader(
          title: '** Danger **'.tr,
          titleColor: Colors.red,
          description: 'Do you want to disable personal data \nsecurity support on your account?'.tr,
        ),
        SizedBox(height: 30.spMin),
        Row(
          children: [
            _buildPrimaryButton(text: 'Cancel'.tr, onPressed: Get.back, expanded: true),
            SizedBox(width: 10.spMin),
            _buildSecondaryButton(
              text: 'Continue'.tr,
              onPressed: () {
                Get.back();
                dialogSelectEnv();
              },
              backgroundColor: const Color(0xFFF2F2F2),
              textColor: const Color(0xFF808080),
            ),
          ],
        ),
      ],
    ),
  );
}

void dialogSelectEnv() async {
  final defaultEnvInfo = _getEnvDisplayInfo(AppEnv.defaultServerEnvType);

  await _showEnvDialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDialogHeader(
          title: 'Select Environment'.tr,
          description: 'Select the environment you want to access to test the system'.tr,
        ),
        SizedBox(height: 30.spMin),
        _currentEnvBadge(),
        SizedBox(height: 12.spMin),
        _buildEnvSelectionButtons(defaultEnvInfo),
        SizedBox(height: 30.spMin),
        _buildPrimaryButton(
          text: 'Close'.tr,
          onPressed: () async {
            Get.back();
            await AppEnv.loadConfig();
          },
        ),
      ],
    ),
  );
}

/// Environment selection buttons container
Widget _buildEnvSelectionButtons(Map<String, dynamic> defaultEnvInfo) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF292F3A),
      border: Border.all(color: const Color(0xFF484D5A), width: 1.spMin),
      borderRadius: BorderRadius.circular(20.spMin),
    ),
    padding: EdgeInsets.all(10.spMin),
    child: Row(
      children: [
        _buildEnvButton(
          label: '${defaultEnvInfo['emoji']} ${defaultEnvInfo['name']}'.tr,
          backgroundColor: defaultEnvInfo['backgroundColor'] as Color,
          textColor: defaultEnvInfo['textColor'] as Color,
          onPressed: () {
            AppEnv.serverEnvType = AppEnv.defaultServerEnvType;
            Get.back();
            dialogCurrentEnvInfo();
          },
        ),
        SizedBox(width: 10.spMin),
        _buildEnvButton(
          label: '✏️ Custom'.tr,
          backgroundColor: _kButtonBackgroundColor,
          textColor: _kTextMutedColor,
          onPressed: () {
            Get.back();
            dialogCustomEnv();
          },
        ),
      ],
    ),
  );
}

/// Single environment selection button
Widget _buildEnvButton({
  required String label,
  required Color backgroundColor,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 12.hr),
        minimumSize: Size.fromHeight(50.hr),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

void dialogCurrentEnvInfo() async {
  final currentEnvInfo = _getEnvDisplayInfo(AppEnv.serverEnvType);

  await _showEnvDialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDialogHeader(
          title: 'Select Environment: @name'.trParams({'name': currentEnvInfo['name']}),
          titleColor: currentEnvInfo['textColor'] as Color,
        ),
        SizedBox(height: 20.spMin),
        _contentCurrentEnvInfo(),
        _buildPrimaryButton(text: 'Ok'.tr, onPressed: Get.back),
      ],
    ),
  );
}

Widget _contentCurrentEnvInfo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _envInfoRow(label: 'API URL'.tr, value: AppEnv.apiUrl),
      SizedBox(height: 12.spMin),
      _envInfoRow(label: 'Socket URL'.tr, value: AppEnv.socketUrl),
      SizedBox(height: 12.spMin),
      _envInfoRow(label: 'Domain'.tr, value: AppEnv.domain),
      SizedBox(height: 20.spMin),
    ],
  );
}

Widget _envInfoRow({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Color(0xFF7B849C),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 4.spMin),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.spMin),
        decoration: BoxDecoration(
          color: const Color(0xFF323741),
          borderRadius: BorderRadius.circular(8.spMin),
        ),
        child: Text(
          value.isNotEmpty ? value : '-',
          style: const TextStyle(
            color: Color(0xFFB0B8CC),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

void dialogCustomEnv() async {
  final controller = Get.find<WelcomeController>();
  _initCustomEnvController(controller);

  final isButtonEnabled = false.obs;
  void updateButtonState() {
    isButtonEnabled.value = controller.inputApiUrl.text.trim().isNotEmpty &&
        controller.inputSocketUrl.text.trim().isNotEmpty &&
        controller.inputDomainUrl.text.trim().isNotEmpty;
  }

  updateButtonState();

  await _showEnvDialog(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height * 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogHeader(
            title: 'Custom Environment'.tr,
            description: 'Enter custom URLs for API, Socket, and Domain'.tr,
            onBack: () {
              Get.back();
              dialogSelectEnv();
            },
          ),
          SizedBox(height: 20.spMin),
          Flexible(
            child: SingleChildScrollView(
              child: _buildCustomEnvInputs(controller, updateButtonState),
            ),
          ),
          const SizedBox(height: 20),
          _buildCustomEnvButtons(controller, isButtonEnabled),
        ],
      ),
    ),
  );
}

void _initCustomEnvController(WelcomeController controller) {
  controller.inputApiUrl.text =
      ConfigDb().general.getStringEnvSync(key: apiCustomTypeConfigKey) ?? '';
  controller.inputSocketUrl.text =
      ConfigDb().general.getStringEnvSync(key: socketCustomTypeConfigKey) ?? '';
  controller.inputDomainUrl.text =
      ConfigDb().general.getStringEnvSync(key: domainCustomTypeConfigKey) ?? '';
  controller.isInputApiUrlCorrect.value = true;
  controller.isInputSocketUrlCorrect.value = true;
  controller.isInputDomainUrlCorrect.value = true;
}

Widget _buildCustomEnvInputs(WelcomeController controller, VoidCallback onChanged) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildUrlInputWithValidation(
        title: 'API URL'.tr,
        controller: controller.inputApiUrl,
        hintText: 'https://api.example.com/api/',
        isValid: controller.isInputApiUrlCorrect,
        validHint: 'Enter HTTP or HTTPS URL'.tr,
        invalidHint: 'Invalid URL. Please use http:// or https://'.tr,
        onChanged: onChanged,
      ),
      _buildUrlInputWithValidation(
        title: 'SOCKET URL'.tr,
        controller: controller.inputSocketUrl,
        hintText: 'wss://socket.example.com',
        isValid: controller.isInputSocketUrlCorrect,
        validHint: 'Enter WS or WSS URL'.tr,
        invalidHint: 'Invalid URL. Please use ws:// or wss://'.tr,
        onChanged: onChanged,
      ),
      _buildUrlInputWithValidation(
        title: 'DOMAIN URL'.tr,
        controller: controller.inputDomainUrl,
        hintText: 'https://example.com',
        isValid: controller.isInputDomainUrlCorrect,
        validHint: 'Enter HTTP or HTTPS URL for domain'.tr,
        invalidHint: 'Invalid URL. Please use http:// or https://'.tr,
        onChanged: onChanged,
      ),
    ],
  );
}

Widget _buildUrlInputWithValidation({
  required String title,
  required TextEditingController controller,
  required String hintText,
  required RxBool isValid,
  required String validHint,
  required String invalidHint,
  required VoidCallback onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _inputUrl(title: title, controller: controller, hintText: hintText, onChanged: (_) => onChanged()),
      Obx(() => Text(
            isValid.value ? validHint : invalidHint,
            style: TextStyle(
              color: isValid.value ? _kTextLabelColor : _kErrorColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )),
      const SizedBox(height: 20),
    ],
  );
}

Widget _buildCustomEnvButtons(WelcomeController controller, RxBool isButtonEnabled) {
  return Row(
    children: [
      _buildSecondaryButton(text: 'Cancel'.tr, onPressed: Get.back),
      SizedBox(width: 10.spMin),
      Expanded(
        child: Obx(() => _buildPrimaryButton(
              text: 'Continue'.tr,
              backgroundColor: isButtonEnabled.value
                  ? UTheme.color.primary
                  : UTheme.color.primary.withValues(alpha: 0.5),
              onPressed: isButtonEnabled.value ? () => _submitCustomEnv(controller) : null,
            )),
      ),
    ],
  );
}

Future<void> _submitCustomEnv(WelcomeController controller) async {
  final apiUrl = controller.inputApiUrl.text.trim();
  final socketUrl = controller.inputSocketUrl.text.trim();
  final domainUrl = controller.inputDomainUrl.text.trim();

  final isApiValid = _regExpHttpUrl.hasMatch(apiUrl);
  final isSocketValid = _regExpWsUrl.hasMatch(socketUrl);
  final isDomainValid = _regExpHttpUrl.hasMatch(domainUrl);

  controller.isInputApiUrlCorrect.value = isApiValid;
  controller.isInputSocketUrlCorrect.value = isSocketValid;
  controller.isInputDomainUrlCorrect.value = isDomainValid;

  if (isApiValid && isSocketValid && isDomainValid) {
    AppEnv.serverEnvType = 'CUSTOM';
    await AppEnv().setCustomServerType(
      inputApiUrl: apiUrl,
      inputSocketUrl: socketUrl,
      inputDomainUrl: domainUrl,
    );
    Get.back();
  }
}

Widget _inputUrl({
  required String title,
  required TextEditingController controller,
  required String hintText,
  ValueChanged<String>? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Color(0xFF7B849C),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 10.h),
      Container(
        width: 296.w,
        height: 48.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF323741),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: const Color(0xFF717886),
              width: 1.w,
            ),
          ),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            color: UTheme.color.onPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF717886),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 16.h),
          ),
        ),
      ),
      SizedBox(height: 10.h),
    ],
  );
}

/// Returns the display info for an environment type
Map<String, dynamic> _getEnvDisplayInfo(String envType) {
  switch (envType) {
    case 'DEV':
      return {
        'emoji': '🥴',
        'name': 'DEV',
        'backgroundColor': const Color(0xFF53463A),
        'textColor': const Color(0xFFFFA800),
      };
    case 'SIT':
      return {
        'emoji': '🐸',
        'name': 'SIT',
        'backgroundColor': const Color(0xFF2D4F40),
        'textColor': const Color(0xFF00FF57),
      };
    case 'UAT':
      return {
        'emoji': '🐙',
        'name': 'UAT',
        'backgroundColor': const Color(0xFF533642),
        'textColor': const Color(0xFFFF417A),
      };
    case 'PROD':
      return {
        'emoji': '🌈',
        'name': 'PRD',
        'backgroundColor': const Color(0xFF453665),
        'textColor': const Color(0xFFCF6AFF),
      };
    case 'CUSTOM':
      return {
        'emoji': '✏️',
        'name': 'CUSTOM',
        'backgroundColor': const Color(0xFF3A4253),
        'textColor': const Color(0xFFB0B8CC),
      };
    default:
      return {
        'emoji': '📍',
        'name': envType,
        'backgroundColor': const Color(0xFF3A4253),
        'textColor': const Color(0xFFB0B8CC),
      };
  }
}

/// Widget to display current selected environment badge
Widget _currentEnvBadge() {
  final envInfo = _getEnvDisplayInfo(AppEnv.serverEnvType);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.spMin, vertical: 8.spMin),
    decoration: BoxDecoration(
      color: envInfo['backgroundColor'] as Color,
      borderRadius: BorderRadius.circular(8.spMin),
      border: Border.all(
        color: (envInfo['textColor'] as Color).withValues(alpha: 0.5),
        width: 1.spMin,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Current: ',
          style: TextStyle(color: _kDescriptionColor, fontSize: 12),
        ),
        Text(
          '${envInfo['emoji']} ${envInfo['name']}',
          style: TextStyle(
            color: envInfo['textColor'] as Color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
