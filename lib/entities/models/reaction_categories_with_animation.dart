import 'package:flutter/material.dart';
import 'package:uchat/entities/models/reaction_categories_model.dart';

class ReactionCategoriesWithAnimation {
  final AnimationController reactionBoxAnimationController;
  final AnimationController emojiAnimationController;
  final ReactionCategoriesModel reactionCategoriesModel;

  ReactionCategoriesWithAnimation({
    required this.reactionBoxAnimationController,
    required this.emojiAnimationController,
    required this.reactionCategoriesModel,
  });

  //copyWith method
  ReactionCategoriesWithAnimation copyWith({
    AnimationController? reactionBoxAnimationController,
    AnimationController? emojiAnimationController,
    ReactionCategoriesModel? reactionCategoriesModel,
  }) {
    return ReactionCategoriesWithAnimation(
      reactionBoxAnimationController: reactionBoxAnimationController ?? this.reactionBoxAnimationController,
      emojiAnimationController: emojiAnimationController ?? this.emojiAnimationController,
      reactionCategoriesModel: reactionCategoriesModel ?? this.reactionCategoriesModel,
    );
  }
}
