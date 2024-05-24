import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/logic/blocs/auth/auth_bloc.dart';
import 'package:video_game_catalogue_app/data/repositories/auth_repository.dart';
import 'package:video_game_catalogue_app/models/user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    const username = 'testUser';
    const password = 'testPassword123';
    const email = 'test@example.com';
    const confirmPassword = 'testPassword123';
    const token = '{"token": "testToken"}';
    const id = 1;
    const joinDate = '2024-01-01';
    const role = 'admin';

    final user = User(
      id: id,
      username: username,
      email: email,
      joinDate: joinDate,
      role: role,
      token: 'testToken',
    );

    void arrangeAuthRepositoryLogin() {
      when(() => mockAuthRepository.login(any(), any())).thenAnswer(
        (_) async => token,
      );
    }

    void arrangeAuthRepositoryRegister() {
      when(() => mockAuthRepository.register(any(), any(), any(), any()))
          .thenAnswer(
        (_) async => token,
      );
    }

    test('initial state is AuthInitial', () {
      expect(authBloc.state, equals(AuthInitial()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when AuthLogin is added and login is successful',
      setUp: arrangeAuthRepositoryLogin,
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthLogin(username: username, password: password)),
      expect: () => [
        equals(AuthLoading()),
        isA<AuthSuccess>(), // Matcher for AuthSuccess state
      ],
      verify: (_) {
        verify(() => mockAuthRepository.login(username, password)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when AuthLogin is added and login fails',
      setUp: () {
        when(() => mockAuthRepository.login(any(), any())).thenThrow(Exception('Login failed'));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthLogin(username: username, password: password)),
      expect: () => [
        equals(AuthLoading()),
        isA<AuthFailure>(), // Matcher for AuthFailure state
      ],
      verify: (_) {
        verify(() => mockAuthRepository.login(username, password)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when AuthRegister is added and registration is successful',
      setUp: arrangeAuthRepositoryRegister,
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthRegister(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      )),
      expect: () => [
        equals(AuthLoading()),
        isA<AuthSuccess>(), // Matcher for AuthSuccess state
      ],
      verify: (_) {
        verify(() => mockAuthRepository.register(
          username, email, password, confirmPassword,
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when AuthRegister is added and registration fails',
      setUp: () {
        when(() => mockAuthRepository.register(any(), any(), any(), any()))
            .thenThrow(Exception('Registration failed'));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthRegister(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      )),
      expect: () => [
        equals(AuthLoading()),
        isA<AuthFailure>(), // Matcher for AuthFailure state
      ],
      verify: (_) {
        verify(() => mockAuthRepository.register(
          username, email, password, confirmPassword,
        )).called(1);
      },
    );
  });
}