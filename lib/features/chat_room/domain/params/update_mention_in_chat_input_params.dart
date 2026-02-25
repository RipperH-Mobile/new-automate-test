import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/annotation_model.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class UpdateMentionInChatInputParams {
  ContactCollection contact;
  (String, List<String>) markupText;
  Map<String, AnnotationModel> mapping;

  UpdateMentionInChatInputParams({
    required this.contact,
    required this.markupText,
    required this.mapping,
  });
}
