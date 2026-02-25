import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

import 'form_textbox_controller.dart';

class FormTextboxScreen extends GetView<FormTextboxController> {
  const FormTextboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: ScaffoldBottomButtonContainer(
        child: Obx(() {
          return PrimaryBasicButton(
            isRounded: false,
            title: controller.actionButtonTitle,
            onPressed: controller.isChanged() ? () => controller.handleActionButton() : null,
          );
        }),
      ),
      child: CustomScrollView(
        slivers: [
          AppBarWithCallHeader<SliverAppBar>(
            centerTitle: true,
            title: AppBarTitle(
              title: controller.title,
            ),
            leading: (controller.isShowBackButton)
                ? AppBarBackButton(
                    onPressed: () => controller.handleBack(),
                  )
                : null,
          ),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOriginalValue(context),
          _buildTextbox(context),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    if (controller.description == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.description!,
                  style: UTheme.textTheme.formDescription.copyWith(
                    color: UTheme.color.onFormDescription.withAlpha(200),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextbox(BuildContext context) {
    return Obx(() {
      return TextInputWithCounter(
        padding: EdgeInsets.only(
          top: controller.isShowRestoreOriginalValue && controller.originalValue() != '' ? 0 : 20,
          left: 15,
          right: 15,
        ),
        currentTextLength: controller.newTextValue().characters.length,
        maxLength: controller.maxLength,
        controller: controller.inputController,
        focusNode: controller.focusNode,
        hintText: controller.value ?? '',
        onChange: controller.onInputChange,
        showCounter: controller.maxLength != null,
      );
    });
  }

  Widget _buildOriginalValue(BuildContext context) {
    return Obx(() {
      if (!controller.isShowRestoreOriginalValue || controller.originalValue() == '') {
        return Container();
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.restoreOriginalValueText,
            style: UTheme.textTheme.formOriginalValueTitle,
          ),
          Text(
            controller.originalValue(),
            style: UTheme.textTheme.formOriginalValue,
          ),
          Transform.translate(
            offset: const Offset(-8, 0),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: UTheme.color.inputSuffix,
                size: 20,
              ),
              splashRadius: 14,
              onPressed: () {
                controller.handleRestoreOriginalValue();
              },
            ),
          ),
        ],
      );
    });
  }
}
