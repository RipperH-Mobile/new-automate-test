import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/core/domain/entities/version_entity.dart';

void main() {
  group('VersionEntity', () {
    group('fromString', () {
      test('should parse valid version string correctly', () {
        // Act
        final version = VersionEntity.fromString('1.2.3');

        // Assert
        expect(version.major, 1);
        expect(version.minor, 2);
        expect(version.patch, 3);
      });

      test('should parse version with multiple digits', () {
        // Act
        final version = VersionEntity.fromString('10.20.30');

        // Assert
        expect(version.major, 10);
        expect(version.minor, 20);
        expect(version.patch, 30);
      });

      test('should parse version with zeros', () {
        // Act
        final version = VersionEntity.fromString('0.0.0');

        // Assert
        expect(version.major, 0);
        expect(version.minor, 0);
        expect(version.patch, 0);
      });

      test('should throw FormatException for invalid format', () {
        // Assert
        expect(() => VersionEntity.fromString('1.2'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('1.2.3.4'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('1'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString(''), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('invalid'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for non-numeric parts', () {
        // Assert
        expect(() => VersionEntity.fromString('a.b.c'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('1.2.c'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('1.b.3'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('a.2.3'), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for negative numbers', () {
        // Assert
        expect(() => VersionEntity.fromString('-1.2.3'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('1.-2.3'), throwsA(isA<FormatException>()));
        expect(() => VersionEntity.fromString('1.2.-3'), throwsA(isA<FormatException>()));
      });
    });

    group('needsUpdate', () {
      test('should return true when major version is lower', () {
        // Arrange
        final current = VersionEntity(major: 1, minor: 0, patch: 0);
        final newer = VersionEntity(major: 2, minor: 0, patch: 0);

        // Act & Assert
        expect(current.needsUpdate(newer), true);
      });

      test('should return true when major is same but minor is lower', () {
        // Arrange
        final current = VersionEntity(major: 1, minor: 1, patch: 0);
        final newer = VersionEntity(major: 1, minor: 2, patch: 0);

        // Act & Assert
        expect(current.needsUpdate(newer), true);
      });

      test('should return true when major and minor are same but patch is lower', () {
        // Arrange
        final current = VersionEntity(major: 1, minor: 1, patch: 1);
        final newer = VersionEntity(major: 1, minor: 1, patch: 2);

        // Act & Assert
        expect(current.needsUpdate(newer), true);
      });

      test('should return false when versions are equal', () {
        // Arrange
        final current = VersionEntity(major: 1, minor: 1, patch: 1);
        final same = VersionEntity(major: 1, minor: 1, patch: 1);

        // Act & Assert
        expect(current.needsUpdate(same), false);
      });

      test('should return false when current version is newer', () {
        // Arrange
        final current = VersionEntity(major: 2, minor: 0, patch: 0);
        final older = VersionEntity(major: 1, minor: 0, patch: 0);

        // Act & Assert
        expect(current.needsUpdate(older), false);
      });

      test('should return false when current minor is newer', () {
        // Arrange
        final current = VersionEntity(major: 1, minor: 2, patch: 0);
        final older = VersionEntity(major: 1, minor: 1, patch: 0);

        // Act & Assert
        expect(current.needsUpdate(older), false);
      });

      test('should return false when current patch is newer', () {
        // Arrange
        final current = VersionEntity(major: 1, minor: 1, patch: 2);
        final older = VersionEntity(major: 1, minor: 1, patch: 1);

        // Act & Assert
        expect(current.needsUpdate(older), false);
      });

      test('should handle complex version comparisons correctly', () {
        // Test cases for complex scenarios
        expect(
          VersionEntity(major: 1, minor: 9, patch: 9).needsUpdate(
            VersionEntity(major: 2, minor: 0, patch: 0),
          ),
          true,
        );
        
        expect(
          VersionEntity(major: 1, minor: 10, patch: 0).needsUpdate(
            VersionEntity(major: 1, minor: 9, patch: 99),
          ),
          false,
        );
        
        expect(
          VersionEntity(major: 0, minor: 0, patch: 1).needsUpdate(
            VersionEntity(major: 0, minor: 0, patch: 2),
          ),
          true,
        );
      });
    });

    group('toString', () {
      test('should format version correctly', () {
        // Arrange
        final version = VersionEntity(major: 1, minor: 2, patch: 3);

        // Act & Assert
        expect(version.toString(), '1.2.3');
      });

      test('should format version with multiple digits correctly', () {
        // Arrange
        final version = VersionEntity(major: 10, minor: 20, patch: 30);

        // Act & Assert
        expect(version.toString(), '10.20.30');
      });

      test('should format version with zeros correctly', () {
        // Arrange
        final version = VersionEntity(major: 0, minor: 0, patch: 0);

        // Act & Assert
        expect(version.toString(), '0.0.0');
      });
    });

    group('integration', () {
      test('should correctly round-trip through string conversion', () {
        // Arrange
        const originalString = '1.2.3';

        // Act
        final version = VersionEntity.fromString(originalString);
        final resultString = version.toString();

        // Assert
        expect(resultString, originalString);
      });

      test('should correctly handle version comparison after parsing', () {
        // Arrange
        final current = VersionEntity.fromString('1.5.0');
        final newer = VersionEntity.fromString('2.0.0');
        final older = VersionEntity.fromString('1.4.9');
        final same = VersionEntity.fromString('1.5.0');

        // Act & Assert
        expect(current.needsUpdate(newer), true);
        expect(current.needsUpdate(older), false);
        expect(current.needsUpdate(same), false);
      });
    });
  });
}