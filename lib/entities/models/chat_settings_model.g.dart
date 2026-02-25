// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ChatSettingsModelSchema = Schema(
  name: r'ChatSettingsModel',
  id: 3333598010196499906,
  properties: {
    r'chatFolder': PropertySchema(
      id: 0,
      name: r'chatFolder',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 1,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'showCategory': PropertySchema(
      id: 2,
      name: r'showCategory',
      type: IsarType.bool,
    )
  },
  estimateSize: _chatSettingsModelEstimateSize,
  serialize: _chatSettingsModelSerialize,
  deserialize: _chatSettingsModelDeserialize,
  deserializeProp: _chatSettingsModelDeserializeProp,
);

int _chatSettingsModelEstimateSize(
  ChatSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _chatSettingsModelSerialize(
  ChatSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.chatFolder);
  writer.writeBool(offsets[1], object.enabled);
  writer.writeBool(offsets[2], object.showCategory);
}

ChatSettingsModel _chatSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatSettingsModel(
    chatFolder: reader.readBoolOrNull(offsets[0]),
    enabled: reader.readBoolOrNull(offsets[1]),
    showCategory: reader.readBoolOrNull(offsets[2]),
  );
  return object;
}

P _chatSettingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ChatSettingsModelQueryFilter
    on QueryBuilder<ChatSettingsModel, ChatSettingsModel, QFilterCondition> {
  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      chatFolderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chatFolder',
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      chatFolderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chatFolder',
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      chatFolderEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      showCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'showCategory',
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      showCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'showCategory',
      ));
    });
  }

  QueryBuilder<ChatSettingsModel, ChatSettingsModel, QAfterFilterCondition>
      showCategoryEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showCategory',
        value: value,
      ));
    });
  }
}

extension ChatSettingsModelQueryObject
    on QueryBuilder<ChatSettingsModel, ChatSettingsModel, QFilterCondition> {}
