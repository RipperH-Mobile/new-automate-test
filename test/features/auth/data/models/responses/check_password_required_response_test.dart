import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_required_response.dart';
import 'package:uchat/features/auth/domain/entities/check_password_required_entity.dart';

void main() {
  group('CheckPasswordRequiredResponse', () {
    test(
        'Given passwordRequired is provided, When CheckPasswordRequiredResponse is instantiated, Then properties are set correctly',
        () {
      // Arrange
      const passwordRequired = true;

      // Act
      final response = CheckPasswordRequiredResponse(passwordRequired: passwordRequired);

      // Assert
      expect(response.passwordRequired, equals(passwordRequired));
    });

    group('fromJson', () {
      test(
          'Given JSON contains passwordRequired, When fromJson is called, Then returns a valid model with correct properties',
          () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'passwordRequired': true,
        };

        // Act
        final result = CheckPasswordRequiredResponse.fromJson(jsonMap);

        // Assert
        expect(result.passwordRequired, true);
      });

      test(
          'Given JSON does not contain passwordRequired, When fromJson is called, Then passwordRequired is set to false',
          () {
        // Arrange
        final Map<String, dynamic> jsonMap = {};

        // Act
        final result = CheckPasswordRequiredResponse.fromJson(jsonMap);

        // Assert
        expect(result.passwordRequired, false);
      });
    });

    test(
        'Given a CheckPasswordRequiredResponse instance, When toEntity is called, Then returns a CheckPasswordRequiredEntity with the same properties',
        () {
      // Arrange
      const passwordRequired = true;
      final response = CheckPasswordRequiredResponse(passwordRequired: passwordRequired);

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<CheckPasswordRequiredEntity>());
      expect(entity.passwordRequired, passwordRequired);
    });
  });
}
