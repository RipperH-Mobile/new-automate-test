import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/annotation_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../entities/update_mention_in_chat_input_entity.dart';
import '../params/update_mention_in_chat_input_params.dart';

class UpdateMentionInChatInputUseCase
    extends SimpleUseCaseSync<UpdateMentionInChatInputEntity, UpdateMentionInChatInputParams> {
  @override
  UpdateMentionInChatInputEntity call(UpdateMentionInChatInputParams params) {
    String? updatedName;

    final contact = params.contact;
    final markupText = params.markupText;

    for (final mentionAccId in markupText.$2) {
      // If updated contact is in mention list
      if (mentionAccId == contact.id) {
        final oldNameRegEx = '@\\[__${mentionAccId}__\\]\\(__(.*?)__\\)';
        final newName = '@[__${mentionAccId}__](__${contact.nickname ?? contact.displayName}__)';

        // Update mention name with RegEx
        updatedName = markupText.$1.replaceAll(RegExp(oldNameRegEx), newName);
        break;
      }
    }

    return UpdateMentionInChatInputEntity(
      newMapping: updateMentionMapping(contact, params.mapping),
      updatedName: updatedName?.displayMarkUp(getDisplay: true),
    );
  }

  Map<String, AnnotationModel>? updateMentionMapping(ContactCollection contact, Map<String, AnnotationModel> mapping) {
    final oldName = mapping.values.where((e) => e.id == contact.id).firstOrNull;
    final oldKey = '@${oldName?.display}';
    final newKey = '@${contact.shortName}';

    // Update mapping key
    if (mapping.containsKey(oldKey)) {
      final value = mapping[oldKey]!;
      mapping.remove(oldKey);
      mapping[newKey] = value;

      return mapping;
    }

    return null;
  }
}
