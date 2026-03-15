import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_image_gallery_app/features/auth/domain/entities/user.dart';
import 'package:mobile_image_gallery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_image_gallery_app/features/auth/presentation/viewmodels/register_viewmodel.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepo;
  late RegisterViewModel viewModel;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    viewModel = RegisterViewModel(mockAuthRepo);
  });

  group('RegisterViewModel', () {
    group('field validation', () {
      test('setUsername sets error for short username', () {
        viewModel.setUsername('ab');
        expect(viewModel.state.username, 'ab');
        expect(viewModel.state.usernameError, isNotNull);
      });

      test('setUsername clears error for valid username', () {
        viewModel.setUsername('john');
        expect(viewModel.state.usernameError, isNull);
      });

      test('setEmail sets error for invalid email', () {
        viewModel.setEmail('not-an-email');
        expect(viewModel.state.emailError, isNotNull);
      });

      test('setEmail clears error for valid email', () {
        viewModel.setEmail('user@test.com');
        expect(viewModel.state.emailError, isNull);
      });

      test('setPassword sets error for short password', () {
        viewModel.setPassword('123');
        expect(viewModel.state.passwordError, isNotNull);
      });

      test('setPassword clears error for valid password', () {
        viewModel.setPassword('pass123');
        expect(viewModel.state.passwordError, isNull);
      });

      test('setAge sets error for out-of-range age', () {
        viewModel.setAge('15');
        expect(viewModel.state.ageError, isNotNull);
      });

      test('setAge clears error for valid age', () {
        viewModel.setAge('25');
        expect(viewModel.state.ageError, isNull);
      });
    });

    group('isFormValid', () {
      test('returns false when form is empty', () {
        expect(viewModel.state.isFormValid, isFalse);
      });

      test('returns false when only some fields are valid', () {
        viewModel.setUsername('john');
        viewModel.setEmail('test@test.com');
        expect(viewModel.state.isFormValid, isFalse);
      });

      test('returns true when all fields are valid', () {
        viewModel.setUsername('john');
        viewModel.setEmail('john@test.com');
        viewModel.setPassword('pass123');
        viewModel.setAge('25');
        expect(viewModel.state.isFormValid, isTrue);
      });

      test('returns false when one field has validation error', () {
        viewModel.setUsername('john');
        viewModel.setPassword('pass123');
        viewModel.setAge('25');
        viewModel.setEmail('invalid');
        expect(viewModel.state.isFormValid, isFalse);
        expect(viewModel.state.emailError, isNotNull);
      });
    });

    group('register', () {
      void fillValidForm() {
        viewModel.setUsername('testuser');
        viewModel.setEmail('test@example.com');
        viewModel.setPassword('pass123');
        viewModel.setAge('25');
      }

      test('does not call repository when form is invalid', () async {
        await viewModel.register();
        verifyNever(() => mockAuthRepo.register(
              username: any(named: 'username'),
              email: any(named: 'email'),
              password: any(named: 'password'),
              age: any(named: 'age'),
            ));
      });

      test('calls repository and sets isSuccess when form is valid', () async {
        fillValidForm();

        when(() => mockAuthRepo.register(
              username: any(named: 'username'),
              email: any(named: 'email'),
              password: any(named: 'password'),
              age: any(named: 'age'),
            )).thenAnswer(
          (_) async => const User(
            username: 'testuser',
            email: 'test@example.com',
            age: 25,
          ),
        );

        await viewModel.register();

        expect(viewModel.state.isSuccess, isTrue);
        expect(viewModel.state.isLoading, isFalse);

        verify(() => mockAuthRepo.register(
              username: 'testuser',
              email: 'test@example.com',
              password: 'pass123',
              age: 25,
            )).called(1);
      });

      test('sets isSuccess false when repository throws', () async {
        fillValidForm();

        when(() => mockAuthRepo.register(
              username: any(named: 'username'),
              email: any(named: 'email'),
              password: any(named: 'password'),
              age: any(named: 'age'),
            )).thenThrow(Exception('Network error'));

        await viewModel.register();

        expect(viewModel.state.isSuccess, isFalse);
        expect(viewModel.state.isLoading, isFalse);
      });
    });
  });
}
