import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/repositories/auth_repository.dart';
import 'package:video_game_catalogue_app/data/data_providers/auth_data_provider.dart';

class MockAuthDataProvider extends Mock implements AuthDataProvider {}

void main() {
  late AuthRepository authRepository;
  late MockAuthDataProvider mockAuthDataProvider;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockAuthDataProvider = MockAuthDataProvider();
    authRepository = AuthRepository(mockAuthDataProvider);
  });

  tearDown(() {
    reset(mockAuthDataProvider);
  });

  group('AuthRepository', () {
    test('login - success', () async {
      const username = 'testUser';
      const password = 'testPassword';
      const token = 'testToken';

      when(() => mockAuthDataProvider.signin(username, password))
          .thenAnswer((_) async => token);

      final result = await authRepository.login(username, password);

      expect(result, equals(token));
      verify(() => mockAuthDataProvider.signin(username, password)).called(1);

    });

    test('login - failure', () async {
      const username = 'testUser';
      const password = 'testPassword';

      when(() => mockAuthDataProvider.signin(username, password))
          .thenThrow(Exception('Login failed'));

      expect(() => authRepository.login(username, password),
          throwsA(isA<Exception>()));
      verify(() => mockAuthDataProvider.signin(username, password)).called(1);

    });

    test('register - success', () async {
      const username = 'testUser';
      const email = 'test@example.com';
      const password = 'testPassword';
      const confirmPassword = 'testPassword';
      const token = 'testToken';

      when(() => mockAuthDataProvider.signup(
              username, email, password, confirmPassword))
          .thenAnswer((_) async => token);

      final result = await authRepository.register(
          username, email, password, confirmPassword);

      expect(result, equals(token));
      verify(() => mockAuthDataProvider.signup(
              username, email, password, confirmPassword))
          .called(1);

    });

    test('register - failure', () async {
      const username = 'testUser';
      const email = 'test@example.com';
      const password = 'testPassword';
      const confirmPassword = 'testPassword';

      when(() => mockAuthDataProvider.signup(
              username, email, password, confirmPassword))
          .thenThrow(Exception('Registration failed'));

      expect(
          () => authRepository.register(
              username, email, password, confirmPassword),
          throwsA(isA<Exception>()));
      verify(() => mockAuthDataProvider.signup(
              username, email, password, confirmPassword))
          .called(1);

    });

    test('logout', () async {
      when(() => mockAuthDataProvider.logout()).thenAnswer((_) async {});

      await authRepository.logout();

      verify(() => mockAuthDataProvider.logout()).called(1);

    });

    test('token', () {
      const token = 'testToken';
      
      when(() => mockAuthDataProvider.token).thenReturn(token);

      expect(authRepository.token, equals(token));
      verify(() => mockAuthDataProvider.token).called(1);

    });

    test('login with empty username and password', () async {
      const username = '';
      const password = '';

      when(() => mockAuthDataProvider.signin(username, password))
          .thenThrow(Exception('Invalid credentials'));

      expect(() => authRepository.login(username, password),
          throwsA(isA<Exception>()));
      verify(() => mockAuthDataProvider.signin(username, password)).called(1);

    });

    test('register with mismatched passwords', () async {
      const username = 'testUser';
      const email = 'test@example.com';
      const password = 'testPassword';
      const confirmPassword = 'mismatchedPassword';

      when(() => mockAuthDataProvider.signup(
              username, email, password, confirmPassword))
          .thenThrow(Exception('Passwords do not match'));

      expect(
          () => authRepository.register(
              username, email, password, confirmPassword),
          throwsA(isA<Exception>()));
      verify(() => mockAuthDataProvider.signup(
              username, email, password, confirmPassword))
          .called(1);

    });
  });
}
