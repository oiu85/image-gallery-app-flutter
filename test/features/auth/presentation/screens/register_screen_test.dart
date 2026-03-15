import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_image_gallery_app/features/auth/domain/entities/user.dart';
import 'package:mobile_image_gallery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_image_gallery_app/features/auth/presentation/viewmodels/register_viewmodel.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

Widget buildTestWidget(AuthRepository repo) {
  return ProviderScope(
    overrides: [
      registerViewModelProvider.overrideWith((_) => RegisterViewModel(repo)),
    ],
    child: const MaterialApp(
      home: _TestRegisterPage(),
    ),
  );
}

class _TestRegisterPage extends ConsumerWidget {
  const _TestRegisterPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerViewModelProvider);
    final viewModel = ref.read(registerViewModelProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              key: const Key('username_field'),
              onChanged: viewModel.setUsername,
              decoration: InputDecoration(
                hintText: 'Enter username',
                errorText: state.usernameError,
              ),
            ),
            TextField(
              key: const Key('email_field'),
              onChanged: viewModel.setEmail,
              decoration: InputDecoration(
                hintText: 'Enter email',
                errorText: state.emailError,
              ),
            ),
            TextField(
              key: const Key('password_field'),
              onChanged: viewModel.setPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter password',
                errorText: state.passwordError,
              ),
            ),
            TextField(
              key: const Key('age_field'),
              onChanged: viewModel.setAge,
              decoration: InputDecoration(
                hintText: 'Enter age',
                errorText: state.ageError,
              ),
            ),
            ElevatedButton(
              key: const Key('register_button'),
              onPressed: state.isFormValid && !state.isLoading
                  ? () => viewModel.register()
                  : null,
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  late MockAuthRepository mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
  });

  group('Register Screen Widget Tests', () {
    testWidgets('shows validation errors when fields have invalid input',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(mockAuthRepo));

      await tester.enterText(find.byKey(const Key('username_field')), 'ab');
      await tester.pump();
      expect(find.text('Minimum 3 characters'), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('email_field')), 'invalid-email');
      await tester.pump();
      expect(find.text('Invalid email format'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('password_field')), '123');
      await tester.pump();
      expect(find.text('Minimum 6 characters'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('age_field')), '10');
      await tester.pump();
      expect(find.text('Age must be between 18 and 99'), findsOneWidget);
    });

    testWidgets('register button is disabled when form is invalid',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(mockAuthRepo));

      final button = tester.widget<ElevatedButton>(
        find.byKey(const Key('register_button')),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('register button is enabled when all fields are valid',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(mockAuthRepo));

      await tester.enterText(
          find.byKey(const Key('username_field')), 'testuser');
      await tester.enterText(
          find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('password_field')), 'pass123');
      await tester.enterText(find.byKey(const Key('age_field')), '25');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(
        find.byKey(const Key('register_button')),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('clears error when valid input is entered', (tester) async {
      await tester.pumpWidget(buildTestWidget(mockAuthRepo));

      await tester.enterText(find.byKey(const Key('email_field')), 'bad');
      await tester.pump();
      expect(find.text('Invalid email format'), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('email_field')), 'good@test.com');
      await tester.pump();
      expect(find.text('Invalid email format'), findsNothing);
    });

    testWidgets('calls register on repository when button pressed',
        (tester) async {
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

      await tester.pumpWidget(buildTestWidget(mockAuthRepo));

      await tester.enterText(
          find.byKey(const Key('username_field')), 'testuser');
      await tester.enterText(
          find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(
          find.byKey(const Key('password_field')), 'pass123');
      await tester.enterText(find.byKey(const Key('age_field')), '25');
      await tester.pump();

      await tester.tap(find.byKey(const Key('register_button')));
      await tester.pumpAndSettle();

      verify(() => mockAuthRepo.register(
            username: 'testuser',
            email: 'test@example.com',
            password: 'pass123',
            age: 25,
          )).called(1);
    });
  });
}
