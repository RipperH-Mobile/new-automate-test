import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/row_menu/uchat_row_header.dart';

import '../../domain/enums/chat_folder_type.dart';
import 'recommend_folder_widget.dart';

class RecommendedFolders extends StatelessWidget {
  final List<ChatFolderType> recommendedFolders;
  final void Function(ChatFolderType type) addRecommendedFolder;

  const RecommendedFolders({
    super.key,
    required this.recommendedFolders,
    required this.addRecommendedFolder,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendedFolders.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        UChatRowHeader(
          title: 'Recommended folder'.tr,
        ),
        Column(
          children: List.generate(recommendedFolders.length, (index) {
            final recommendedFolder = recommendedFolders[index];
            return recommendFolderWidget(
              onPressed: () {
                addRecommendedFolder(recommendedFolder);
              },
              title: recommendedFolder.displayName,
              subTitle: recommendedFolder.description,
              type: recommendedFolder.value,
              showAddButton: true,
            );
          }),
        ),
      ],
    );
  }
}
