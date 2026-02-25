// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AccountSettingsModelSchema = Schema(
  name: r'AccountSettingsModel',
  id: 5325290291316777985,
  properties: {
    r'call': PropertySchema(
      id: 0,
      name: r'call',
      type: IsarType.object,
      target: r'CallSettingsModel',
    ),
    r'chat': PropertySchema(
      id: 1,
      name: r'chat',
      type: IsarType.object,
      target: r'ChatSettingsModel',
    ),
    r'friend': PropertySchema(
      id: 2,
      name: r'friend',
      type: IsarType.object,
      target: r'FriendSettingsModel',
    ),
    r'notification': PropertySchema(
      id: 3,
      name: r'notification',
      type: IsarType.object,
      target: r'NotificationSettingsModel',
    ),
    r'profile': PropertySchema(
      id: 4,
      name: r'profile',
      type: IsarType.object,
      target: r'ProfileSettingsModel',
    ),
    r'security': PropertySchema(
      id: 5,
      name: r'security',
      type: IsarType.object,
      target: r'SecuritySettingsModel',
    )
  },
  estimateSize: _accountSettingsModelEstimateSize,
  serialize: _accountSettingsModelSerialize,
  deserialize: _accountSettingsModelDeserialize,
  deserializeProp: _accountSettingsModelDeserializeProp,
);

int _accountSettingsModelEstimateSize(
  AccountSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.call;
    if (value != null) {
      bytesCount += 3 +
          CallSettingsModelSchema.estimateSize(
              value, allOffsets[CallSettingsModel]!, allOffsets);
    }
  }
  {
    final value = object.chat;
    if (value != null) {
      bytesCount += 3 +
          ChatSettingsModelSchema.estimateSize(
              value, allOffsets[ChatSettingsModel]!, allOffsets);
    }
  }
  {
    final value = object.friend;
    if (value != null) {
      bytesCount += 3 +
          FriendSettingsModelSchema.estimateSize(
              value, allOffsets[FriendSettingsModel]!, allOffsets);
    }
  }
  {
    final value = object.notification;
    if (value != null) {
      bytesCount += 3 +
          NotificationSettingsModelSchema.estimateSize(
              value, allOffsets[NotificationSettingsModel]!, allOffsets);
    }
  }
  {
    final value = object.profile;
    if (value != null) {
      bytesCount += 3 +
          ProfileSettingsModelSchema.estimateSize(
              value, allOffsets[ProfileSettingsModel]!, allOffsets);
    }
  }
  {
    final value = object.security;
    if (value != null) {
      bytesCount += 3 +
          SecuritySettingsModelSchema.estimateSize(
              value, allOffsets[SecuritySettingsModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _accountSettingsModelSerialize(
  AccountSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CallSettingsModel>(
    offsets[0],
    allOffsets,
    CallSettingsModelSchema.serialize,
    object.call,
  );
  writer.writeObject<ChatSettingsModel>(
    offsets[1],
    allOffsets,
    ChatSettingsModelSchema.serialize,
    object.chat,
  );
  writer.writeObject<FriendSettingsModel>(
    offsets[2],
    allOffsets,
    FriendSettingsModelSchema.serialize,
    object.friend,
  );
  writer.writeObject<NotificationSettingsModel>(
    offsets[3],
    allOffsets,
    NotificationSettingsModelSchema.serialize,
    object.notification,
  );
  writer.writeObject<ProfileSettingsModel>(
    offsets[4],
    allOffsets,
    ProfileSettingsModelSchema.serialize,
    object.profile,
  );
  writer.writeObject<SecuritySettingsModel>(
    offsets[5],
    allOffsets,
    SecuritySettingsModelSchema.serialize,
    object.security,
  );
}

AccountSettingsModel _accountSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AccountSettingsModel(
    call: reader.readObjectOrNull<CallSettingsModel>(
      offsets[0],
      CallSettingsModelSchema.deserialize,
      allOffsets,
    ),
    chat: reader.readObjectOrNull<ChatSettingsModel>(
      offsets[1],
      ChatSettingsModelSchema.deserialize,
      allOffsets,
    ),
    friend: reader.readObjectOrNull<FriendSettingsModel>(
      offsets[2],
      FriendSettingsModelSchema.deserialize,
      allOffsets,
    ),
    notification: reader.readObjectOrNull<NotificationSettingsModel>(
      offsets[3],
      NotificationSettingsModelSchema.deserialize,
      allOffsets,
    ),
    profile: reader.readObjectOrNull<ProfileSettingsModel>(
      offsets[4],
      ProfileSettingsModelSchema.deserialize,
      allOffsets,
    ),
    security: reader.readObjectOrNull<SecuritySettingsModel>(
      offsets[5],
      SecuritySettingsModelSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _accountSettingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CallSettingsModel>(
        offset,
        CallSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<ChatSettingsModel>(
        offset,
        ChatSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<FriendSettingsModel>(
        offset,
        FriendSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<NotificationSettingsModel>(
        offset,
        NotificationSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readObjectOrNull<ProfileSettingsModel>(
        offset,
        ProfileSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readObjectOrNull<SecuritySettingsModel>(
        offset,
        SecuritySettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AccountSettingsModelQueryFilter on QueryBuilder<AccountSettingsModel,
    AccountSettingsModel, QFilterCondition> {
  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> callIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'call',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> callIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'call',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> chatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chat',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> chatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chat',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> friendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'friend',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> friendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'friend',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> notificationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notification',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> notificationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notification',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> profileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'profile',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> profileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'profile',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> securityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'security',
      ));
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> securityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'security',
      ));
    });
  }
}

extension AccountSettingsModelQueryObject on QueryBuilder<AccountSettingsModel,
    AccountSettingsModel, QFilterCondition> {
  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> call(FilterQuery<CallSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'call');
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> chat(FilterQuery<ChatSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chat');
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> friend(FilterQuery<FriendSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'friend');
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
          QAfterFilterCondition>
      notification(FilterQuery<NotificationSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notification');
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> profile(FilterQuery<ProfileSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'profile');
    });
  }

  QueryBuilder<AccountSettingsModel, AccountSettingsModel,
      QAfterFilterCondition> security(FilterQuery<SecuritySettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'security');
    });
  }
}
