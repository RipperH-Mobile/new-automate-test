// Generic JSON parser with type safety
import 'package:translation/translation/key_model.dart';
import 'package:translation/translation/model.dart';

T castOrNull<T>(dynamic value) {
  return value is T ? value : throw TypeError();
}

// Extension method for safe type casting of Maps
extension MapCasting<K, V> on Map<K, V> {
  Map<R, T> castMap<R, T>() {
    return Map<R, T>.from(
      map(
        (key, value) => MapEntry(
          key as R,
          value as T,
        ),
      ),
    );
  }
}

// Extension method for safe type casting of Lists
extension ListCasting<T> on List<T> {
  List<R> castList<R>() {
    return List<R>.from(
      map((item) => item as R),
    );
  }
}

// Example of strictly typed data structure
class TypedData<T> {
  final Map<String, T> data;

  TypedData({
    required this.data,
  });

  factory TypedData.fromJson(Map<String, dynamic> json) {
    try {
      return TypedData(
        data: Map<String, T>.from(
          json.map(
            (key, value) {
              T castedValue;

              switch (T) {
                case const (TranslationModel):
                  castedValue = TranslationModel.fromJson(value) as T;
                case const (TranslationKeyModel):
                  castedValue = TranslationKeyModel.fromJson(value) as T;
                default:
                  throw Exception('Type $T not supported');
              }

              return MapEntry(
                key,
                castedValue,
              );
            },
          ),
        ),
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw FormatException('Invalid JSON structure: $e');
    }
  }

  Map<String, T> toJson() => data;
}

abstract class JsonSerializer<T> {
  Map<String, dynamic> toJson();

  factory JsonSerializer.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
