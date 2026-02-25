// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_desktop_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NotificationDesktopDataModelSchema = Schema(
  name: r'NotificationDesktopDataModel',
  id: -910220935090960149,
  properties: {
    r'contents': PropertySchema(
      id: 0,
      name: r'contents',
      type: IsarType.string,
    ),
    r'headings': PropertySchema(
      id: 1,
      name: r'headings',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 2,
      name: r'roomId',
      type: IsarType.string,
    )
  },
  estimateSize: _notificationDesktopDataModelEstimateSize,
  serialize: _notificationDesktopDataModelSerialize,
  deserialize: _notificationDesktopDataModelDeserialize,
  deserializeProp: _notificationDesktopDataModelDeserializeProp,
);

int _notificationDesktopDataModelEstimateSize(
  NotificationDesktopDataModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.contents;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.headings;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _notificationDesktopDataModelSerialize(
  NotificationDesktopDataModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contents);
  writer.writeString(offsets[1], object.headings);
  writer.writeString(offsets[2], object.roomId);
}

NotificationDesktopDataModel _notificationDesktopDataModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationDesktopDataModel(
    contents: reader.readStringOrNull(offsets[0]),
    headings: reader.readStringOrNull(offsets[1]),
    roomId: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _notificationDesktopDataModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension NotificationDesktopDataModelQueryFilter on QueryBuilder<
    NotificationDesktopDataModel,
    NotificationDesktopDataModel,
    QFilterCondition> {
  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contents',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contents',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contents',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
          QAfterFilterCondition>
      contentsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
          QAfterFilterCondition>
      contentsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contents',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contents',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> contentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contents',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'headings',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'headings',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'headings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'headings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'headings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'headings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'headings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
          QAfterFilterCondition>
      headingsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'headings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
          QAfterFilterCondition>
      headingsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'headings',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headings',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> headingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'headings',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
          QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
          QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationDesktopDataModel, NotificationDesktopDataModel,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }
}

extension NotificationDesktopDataModelQueryObject on QueryBuilder<
    NotificationDesktopDataModel,
    NotificationDesktopDataModel,
    QFilterCondition> {}
