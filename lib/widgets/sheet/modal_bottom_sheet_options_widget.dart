import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

enum ButtonType {
  primary,
  accent,
}

class BottomSheetOptions extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String buttonTitle;
  final ButtonType buttonType;
  final List<BottomSheetOptionItem> items;
  final Function(BottomSheetOptionItem item) onSubmit;

  const BottomSheetOptions({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
    this.buttonType = ButtonType.primary,
    required this.buttonTitle,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(BottomSheetOptionsController());
    return BottomSheetOptionsBody(
      title: title,
      subtitle: subtitle,
      items: items,
      buttonTitle: buttonTitle,
      buttonType: buttonType,
      onSubmit: onSubmit,
    );
  }
}

class BottomSheetOptionsBody extends GetView<BottomSheetOptionsController> {
  final String title;
  final String? subtitle;
  final String buttonTitle;
  final ButtonType buttonType;
  final List<BottomSheetOptionItem> items;
  final Function(BottomSheetOptionItem item) onSubmit;

  const BottomSheetOptionsBody({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
    required this.buttonTitle,
    this.buttonType = ButtonType.primary,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final maxOptionsHeight = (Get.mediaQuery.size.height / 2) - 150;

    return Container(
      decoration: BoxDecoration(
        color: UTheme.color.bottomSheetBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Wrap(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 35,
                  height: 5,
                  decoration: BoxDecoration(
                    color: UTheme.color.bottomSheetBar,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                style: UTheme.textTheme.bottomSheetOptionsTitle.copyWith(
                  color: UTheme.color.bottomSheetOnMenu,
                ),
              ),
            ),
            if (subtitle != null) const SizedBox(height: 30),
            if (subtitle != null)
              Center(
                child: Text(
                  subtitle!,
                  style: UTheme.textTheme.bottomSheetOptionsSubtitle.copyWith(
                    color: UTheme.color.bottomSheetOnMenu,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(Size.fromHeight(maxOptionsHeight)),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...items.map((item) {
                          return Obx(() {
                            return BottomSheetOptionsItem(
                              title: item.title,
                              value: item.value,
                              isChecked: controller.valueSelected()?.value == item.value,
                              onPressed: (_) {
                                controller.valueSelected(item);
                              },
                            );
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Obx(
                () {
                  switch (buttonType) {
                    case ButtonType.primary:
                      return PrimaryBasicButton(
                        width: Get.mediaQuery.size.width - 40,
                        isRounded: false,
                        title: buttonTitle,
                        onPressed: controller.valueSelected() != null
                            ? () {
                                onSubmit(controller.valueSelected()!);
                              }
                            : null,
                      );
                    case ButtonType.accent:
                      return AccentBasicButton(
                        width: Get.mediaQuery.size.width - 40,
                        isRounded: false,
                        title: buttonTitle,
                        onPressed: controller.valueSelected() != null
                            ? () {
                                onSubmit(controller.valueSelected()!);
                              }
                            : null,
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetOptionsItem extends StatelessWidget {
  final String title;
  final String value;
  final Function? onPressed;
  final bool isChecked;

  const BottomSheetOptionsItem({
    super.key,
    required this.title,
    required this.value,
    required this.isChecked,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BasicTextButton(
      onPressed: () {
        onPressed?.call(value);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: RoundCheckBox(
              size: 28,
              onTap: (_) => onPressed?.call(value),
              checkedColor: UTheme.color.checkBox,
              isChecked: isChecked,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: UTheme.textTheme.bottomSheetOptionsItem.copyWith(
                color: UTheme.color.bottomSheetOnMenu,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
