import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/annotation_model.dart';

class UpdateMentionInChatInputEntity {
  Map<String, AnnotationModel>? newMapping;
  String? updatedName;

  UpdateMentionInChatInputEntity({
    this.newMapping,
    this.updatedName,
  });
}
