import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_image_gallery_app/core/validation/form_validators.dart';

void main() {
  group('UsernameValidator', () {
    const validator = UsernameValidator(minLength: 3, maxLength: 12);

    test('returns error when empty', () {
      expect(validator(''), 'Username is required');
      expect(validator(null), 'Username is required');
      expect(validator('   '), 'Username is required');
    });

    test('returns error when too short', () {
      expect(validator('ab'), 'Minimum 3 characters');
    });

    test('returns error when too long', () {
      expect(validator('abcdefghijklm'), 'Maximum 12 characters');
    });

    test('returns null for valid username', () {
      expect(validator('john'), isNull);
      expect(validator('abc'), isNull);
      expect(validator('abcdefghijkl'), isNull);
    });
  });

  group('EmailValidator', () {
    const validator = EmailValidator();

    test('returns error when empty', () {
      expect(validator(''), 'Email is required');
      expect(validator(null), 'Email is required');
    });

    test('returns error for invalid email format', () {
      expect(validator('notanemail'), 'Invalid email format');
      expect(validator('missing@dot'), 'Invalid email format');
      expect(validator('@nodomain.com'), 'Invalid email format');
      expect(validator('spaces in@email.com'), 'Invalid email format');
    });

    test('returns null for valid email', () {
      expect(validator('user@example.com'), isNull);
      expect(validator('test.name@domain.org'), isNull);
      expect(validator('a+b@c.co'), isNull);
    });
  });

  group('PasswordValidator', () {
    const validator = PasswordValidator(minLength: 6, maxLength: 12);

    test('returns error when empty', () {
      expect(validator(''), 'Password is required');
      expect(validator(null), 'Password is required');
    });

    test('returns error when too short', () {
      expect(validator('12345'), 'Minimum 6 characters');
    });

    test('returns error when too long', () {
      expect(validator('1234567890abc'), 'Maximum 12 characters');
    });

    test('returns null for valid password', () {
      expect(validator('123456'), isNull);
      expect(validator('abcdef'), isNull);
      expect(validator('abcdefghijkl'), isNull);
    });
  });

  group('AgeValidator', () {
    const validator = AgeValidator(minAge: 18, maxAge: 99);

    test('returns error when empty', () {
      expect(validator(''), 'Age is required');
      expect(validator(null), 'Age is required');
    });

    test('returns error when not a number', () {
      expect(validator('abc'), 'Must be a number');
      expect(validator('12.5'), 'Must be a number');
    });

    test('returns error when out of range', () {
      expect(validator('17'), 'Age must be between 18 and 99');
      expect(validator('100'), 'Age must be between 18 and 99');
      expect(validator('0'), 'Age must be between 18 and 99');
    });

    test('returns null for valid age', () {
      expect(validator('18'), isNull);
      expect(validator('25'), isNull);
      expect(validator('99'), isNull);
    });
  });
}
