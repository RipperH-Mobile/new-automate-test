// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_accounts_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LinkAccountsModelSchema = Schema(
  name: r'LinkAccountsModel',
  id: 8187649764250486123,
  properties: {
    r'apple': PropertySchema(
      id: 0,
      name: r'apple',
      type: IsarType.object,
      target: r'AppleAccountModel',
    ),
    r'facebook': PropertySchema(
      id: 1,
      name: r'facebook',
      type: IsarType.object,
      target: r'FacebookAccountModel',
    ),
    r'google': PropertySchema(
      id: 2,
      name: r'google',
      type: IsarType.object,
      target: r'GoogleAccountModel',
    )
  },
  estimateSize: _linkAccountsModelEstimateSize,
  serialize: _linkAccountsModelSerialize,
  deserialize: _linkAccountsModelDeserialize,
  deserializeProp: _linkAccountsModelDeserializeProp,
);

int _linkAccountsModelEstimateSize(
  LinkAccountsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.apple;
    if (value != null) {
      bytesCount += 3 +
          AppleAccountModelSchema.estimateSize(
              value, allOffsets[AppleAccountModel]!, allOffsets);
    }
  }
  {
    final value = object.facebook;
    if (value != null) {
      bytesCount += 3 +
          FacebookAccountModelSchema.estimateSize(
              value, allOffsets[FacebookAccountModel]!, allOffsets);
    }
  }
  {
    final value = object.google;
    if (value != null) {
      bytesCount += 3 +
          GoogleAccountModelSchema.estimateSize(
              value, allOffsets[GoogleAccountModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _linkAccountsModelSerialize(
  LinkAccountsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<AppleAccountModel>(
    offsets[0],
    allOffsets,
    AppleAccountModelSchema.serialize,
    object.apple,
  );
  writer.writeObject<FacebookAccountModel>(
    offsets[1],
    allOffsets,
    FacebookAccountModelSchema.serialize,
    object.facebook,
  );
  writer.writeObject<GoogleAccountModel>(
    offsets[2],
    allOffsets,
    GoogleAccountModelSchema.serialize,
    object.google,
  );
}

LinkAccountsModel _linkAccountsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LinkAccountsModel(
    apple: reader.readObjectOrNull<AppleAccountModel>(
      offsets[0],
      AppleAccountModelSchema.deserialize,
      allOffsets,
    ),
    facebook: reader.readObjectOrNull<FacebookAccountModel>(
      offsets[1],
      FacebookAccountModelSchema.deserialize,
      allOffsets,
    ),
    google: reader.readObjectOrNull<GoogleAccountModel>(
      offsets[2],
      GoogleAccountModelSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _linkAccountsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<AppleAccountModel>(
        offset,
        AppleAccountModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<FacebookAccountModel>(
        offset,
        FacebookAccountModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<GoogleAccountModel>(
        offset,
        GoogleAccountModelSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LinkAccountsModelQueryFilter
    on QueryBuilder<LinkAccountsModel, LinkAccountsModel, QFilterCondition> {
  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      appleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apple',
      ));
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      appleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apple',
      ));
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      facebookIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'facebook',
      ));
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      facebookIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'facebook',
      ));
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      googleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'google',
      ));
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      googleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'google',
      ));
    });
  }
}

extension LinkAccountsModelQueryObject
    on QueryBuilder<LinkAccountsModel, LinkAccountsModel, QFilterCondition> {
  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      apple(FilterQuery<AppleAccountModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'apple');
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      facebook(FilterQuery<FacebookAccountModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'facebook');
    });
  }

  QueryBuilder<LinkAccountsModel, LinkAccountsModel, QAfterFilterCondition>
      google(FilterQuery<GoogleAccountModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'google');
    });
  }
}
