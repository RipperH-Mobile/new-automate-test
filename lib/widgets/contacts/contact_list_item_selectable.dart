import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets.dart';

class ContactListItemSelectable<M> extends StatelessWidget {
  final void Function()? onPressed;
  final M data;
  final String? heroTag;
  final bool isChecked;
  final bool showStatusMessage;
  final bool showMemberCount;
  final bool useGravatar;
  final EdgeInsets? padding;
  final double checkBoxSize;
  final EdgeInsets? checkBoxPadding;
  final bool enable;
  final bool radioCheck;
  final bool reachedMaxSelected;
  final String? nameHighlightStr;

  const ContactListItemSelectable({
    super.key,
    this.onPressed,
    required this.data,
    required this.isChecked,
    this.heroTag,
    this.showStatusMessage = true,
    this.showMemberCount = true,
    this.useGravatar = false,
    this.padding,
    this.checkBoxSize = 25,
    this.checkBoxPadding,
    this.enable = true,
    this.radioCheck = false,
    this.reachedMaxSelected = false,
    this.nameHighlightStr,
  });

  bool get shouldHideCheckBox => reachedMaxSelected && !isChecked;

  @override
  Widget build(BuildContext context) {
    return BasicTextButton(
      onPressed: onPressed,
      padding: padding,
      child: ContactListItem<M>(
        heroTag: heroTag ?? '',
        data: data,
        useGravatar: useGravatar,
        showStatusMessage: showStatusMessage,
        showMemberCount: showMemberCount,
        nameHighlightStr: nameHighlightStr,
        actions:
            // shouldHideCheckBox
            //     ? null
            //     :
            [
          Padding(
            padding: checkBoxPadding ?? EdgeInsets.only(right: 8.spMin),
            child: radioCheck
                ? Radio(
                    value: true,
                    groupValue: isChecked,
                    onChanged: enable ? (value) => onPressed?.call() : null,
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      // active
                      if (states.contains(WidgetState.selected)) {
                        return context.theme.appColors.borderPrimary;
                      }
                      // inactive
                      return context.theme.appColors.backgroundNeutralLighterPressed;
                    }),
                  )
                : RoundCheckBox(
                    isChecked: isChecked,
                    size: checkBoxSize.spMin,
                    onTap: enable ? (value) => onPressed?.call() : null,
                    uncheckedWidget: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.spMin,
                          color: context.theme.appColors.borderDisable,
                        ),
                      ),
                    ),
                    uncheckedColor: context.theme.appColors.backgroundNeutralLighterPressed,
                    checkedColor: reachedMaxSelected
                        ? context.theme.appColors.iconDisable
                        : context.theme.appColors.borderPrimary,
                    disabledColor: isChecked
                        ? context.theme.appColors.iconDisable
                        : context.theme.appColors.backgroundNeutralLighterPressed,
                    checkedWidget: reachedMaxSelected
                        ? Image.asset(
                            'assets/images/v2/new_disable_checked_icon.png',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/v2/new_checked_icon.png',
                            fit: BoxFit.cover,
                          ),
                    borderColor:
                        isChecked ? context.theme.appColors.borderPrimary : context.theme.appColors.borderDisable,
                    border: Border.all(
                      width: 0,
                      color: isChecked
                          ? reachedMaxSelected
                              ? context.theme.appColors.iconDisable
                              : context.theme.appColors.borderPrimary
                          : context.theme.appColors.border,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                  ),
          ),
        ],
      ),
    );
  }
}
