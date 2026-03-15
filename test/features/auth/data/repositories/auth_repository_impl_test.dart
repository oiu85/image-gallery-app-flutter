import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_image_gallery_app/core/storage/app_storage_service.dart';
import 'package:mobile_image_gallery_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:mobile_image_gallery_app/features/auth/data/repositories/auth_repository_impl.dart';

class MockAppStorageService extends Mock implements AppStorageService {}

void main() {
  late MockAppStorageService mockStorage;
  late AuthLocalDatasource datasource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockStorage = MockAppStorageService();
    datasource = AuthLocalDatasource(mockStorage);
    repository = AuthRepositoryImpl(datasource);
  });

  group('AuthRepositoryImpl', () {
    group('register', () {
      test('saves user locally and returns User entity', () async {
        when(() => mockStorage.saveRegisteredUser(any()))
            .thenAnswer((_) async {});
        when(() => mockStorage.setUserName(any()))
            .thenAnswer((_) async {});
        when(() => mockStorage.setUserEmail(any()))
            .thenAnswer((_) async {});
        when(() => mockStorage.setUserAge(any()))
            .thenAnswer((_) async {});
        when(() => mockStorage.setRegistered(true))
            .thenAnswer((_) async {});
        when(() => mockStorage.setAccessToken(any()))
            .thenAnswer((_) async {});

        final user = await repository.register(
          username: 'testuser',
          email: 'test@example.com',
          password: 'pass123',
          age: 25,
        );

        expect(user.username, 'testuser');
        expect(user.email, 'test@example.com');
        expect(user.age, 25);

        verify(() => mockStorage.setRegistered(true)).called(1);
        verify(() => mockStorage.setUserName('testuser')).called(1);
        verify(() => mockStorage.setUserEmail('test@example.com')).called(1);
        verify(() => mockStorage.setUserAge(25)).called(1);
      });
    });

    group('isRegistered', () {
      test('returns true when user is registered', () async {
        when(() => mockStorage.isRegistered())
            .thenAnswer((_) async => true);

        final result = await repository.isRegistered();
        expect(result, isTrue);
      });

      test('returns false when no user is registered', () async {
        when(() => mockStorage.isRegistered())
            .thenAnswer((_) async => false);

        final result = await repository.isRegistered();
        expect(result, isFalse);
      });
    });

    group('getRegisteredUser', () {
      test('returns user when registered', () async {
        when(() => mockStorage.getRegisteredUser()).thenAnswer(
          (_) async => '{"username":"john","email":"john@test.com","age":30}',
        );

        final user = await repository.getRegisteredUser();

        expect(user, isNotNull);
        expect(user!.username, 'john');
        expect(user.email, 'john@test.com');
        expect(user.age, 30);
      });

      test('returns null when no user saved', () async {
        when(() => mockStorage.getRegisteredUser())
            .thenAnswer((_) async => null);

        final user = await repository.getRegisteredUser();
        expect(user, isNull);
      });
    });

    group('login', () {
      test('returns true when user is registered', () async {
        when(() => mockStorage.isRegistered())
            .thenAnswer((_) async => true);

        final result = await repository.login(
          email: 'test@example.com',
          password: 'pass123',
        );

        expect(result, isTrue);
      });
    });
  });
}
