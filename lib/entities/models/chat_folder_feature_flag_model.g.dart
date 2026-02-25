// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_folder_feature_flag_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ChatFolderFeatureFlagModelSchema = Schema(
  name: r'ChatFolderFeatureFlagModel',
  id: -2824733488142408620,
  properties: {
    r'compareThemeContent': PropertySchema(
      id: 0,
      name: r'compareThemeContent',
      type: IsarType.object,
      target: r'CompareThemeContentModel',
    ),
    r'detailThemeContentModel': PropertySchema(
      id: 1,
      name: r'detailThemeContentModel',
      type: IsarType.object,
      target: r'DetailThemeContentModel',
    ),
    r'enabled': PropertySchema(
      id: 2,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'maxChatFolder': PropertySchema(
      id: 3,
      name: r'maxChatFolder',
      type: IsarType.long,
    ),
    r'maxRoomInChatFolder': PropertySchema(
      id: 4,
      name: r'maxRoomInChatFolder',
      type: IsarType.long,
    )
  },
  estimateSize: _chatFolderFeatureFlagModelEstimateSize,
  serialize: _chatFolderFeatureFlagModelSerialize,
  deserialize: _chatFolderFeatureFlagModelDeserialize,
  deserializeProp: _chatFolderFeatureFlagModelDeserializeProp,
);

int _chatFolderFeatureFlagModelEstimateSize(
  ChatFolderFeatureFlagModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.compareThemeContent;
    if (value != null) {
      bytesCount += 3 +
          CompareThemeContentModelSchema.estimateSize(
              value, allOffsets[CompareThemeContentModel]!, allOffsets);
    }
  }
  {
    final value = object.detailThemeContentModel;
    if (value != null) {
      bytesCount += 3 +
          DetailThemeContentModelSchema.estimateSize(
              value, allOffsets[DetailThemeContentModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _chatFolderFeatureFlagModelSerialize(
  ChatFolderFeatureFlagModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CompareThemeContentModel>(
    offsets[0],
    allOffsets,
    CompareThemeContentModelSchema.serialize,
    object.compareThemeContent,
  );
  writer.writeObject<DetailThemeContentModel>(
    offsets[1],
    allOffsets,
    DetailThemeContentModelSchema.serialize,
    object.detailThemeContentModel,
  );
  writer.writeBool(offsets[2], object.enabled);
  writer.writeLong(offsets[3], object.maxChatFolder);
  writer.writeLong(offsets[4], object.maxRoomInChatFolder);
}

ChatFolderFeatureFlagModel _chatFolderFeatureFlagModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatFolderFeatureFlagModel(
    compareThemeContent: reader.readObjectOrNull<CompareThemeContentModel>(
      offsets[0],
      CompareThemeContentModelSchema.deserialize,
      allOffsets,
    ),
    detailThemeContentModel: reader.readObjectOrNull<DetailThemeContentModel>(
      offsets[1],
      DetailThemeContentModelSchema.deserialize,
      allOffsets,
    ),
    enabled: reader.readBoolOrNull(offsets[2]),
    maxChatFolder: reader.readLongOrNull(offsets[3]),
    maxRoomInChatFolder: reader.readLongOrNull(offsets[4]),
  );
  return object;
}

P _chatFolderFeatureFlagModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CompareThemeContentModel>(
        offset,
        CompareThemeContentModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<DetailThemeContentModel>(
        offset,
        DetailThemeContentModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ChatFolderFeatureFlagModelQueryFilter on QueryBuilder<
    ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel, QFilterCondition> {
  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> compareThemeContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> compareThemeContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> detailThemeContentModelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> detailThemeContentModelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxChatFolderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxChatFolder',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxChatFolderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxChatFolder',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxChatFolderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxChatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxChatFolderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxChatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxChatFolderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxChatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxChatFolderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxChatFolder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxRoomInChatFolderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxRoomInChatFolder',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxRoomInChatFolderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxRoomInChatFolder',
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxRoomInChatFolderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxRoomInChatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxRoomInChatFolderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxRoomInChatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxRoomInChatFolderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxRoomInChatFolder',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
      QAfterFilterCondition> maxRoomInChatFolderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxRoomInChatFolder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatFolderFeatureFlagModelQueryObject on QueryBuilder<
    ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel, QFilterCondition> {
  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
          QAfterFilterCondition>
      compareThemeContent(FilterQuery<CompareThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'compareThemeContent');
    });
  }

  QueryBuilder<ChatFolderFeatureFlagModel, ChatFolderFeatureFlagModel,
          QAfterFilterCondition>
      detailThemeContentModel(FilterQuery<DetailThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'detailThemeContentModel');
    });
  }
}
