import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class BookmarkTagWithAnimation {
  final BookmarkTagModel bookmarkTagModel;
  final AnimationController bookmarkTagAnimationController;

  BookmarkTagWithAnimation({
    required this.bookmarkTagModel,
    required this.bookmarkTagAnimationController,
  });

  //copyWith method
  BookmarkTagWithAnimation copyWith({
    BookmarkTagModel? bookmarkTagModel,
    AnimationController? bookmarkTagAnimationController,
  }) {
    return BookmarkTagWithAnimation(
      bookmarkTagModel: bookmarkTagModel ?? this.bookmarkTagModel,
      bookmarkTagAnimationController: bookmarkTagAnimationController ?? this.bookmarkTagAnimationController,
    );
  }
}
