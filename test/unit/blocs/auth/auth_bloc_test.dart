import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart';
import 'package:video_game_catalogue_app/data/repositories/auth_repository.dart';
import 'package:video_game_catalogue_app/logic/blocs/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('AuthBloc', () {
    late AuthRepository mockAuthRepository;
    late AuthBloc authBloc;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(mockAuthRepository);
    });

    tearDown(() {
      authBloc.close();
    });

    group('AuthLogin', () {
      const String testUsername = 'testuser';
      const String testPassword = 'testpassword';
      const String testToken = '{"token": "testtoken"}';

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when username is empty',
        build: () {
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(
          username: '',
          password: testPassword,
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when password is empty',
        build: () {
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(
          username: testUsername,
          password: '',
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when username is too short',
        build: () {
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(
          username: 'abc', // Too short
          password: testPassword,
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when password is too short',
        build: () {
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(
          username: testUsername,
          password: '1234567', // Too short
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when login fails due to incorrect credentials',
        build: () {
          when(mockAuthRepository.login(testUsername, testPassword))
              .thenThrow(Exception('Login failed'));
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(
          username: testUsername,
          password: testPassword,
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when a network error occurs',
        build: () {
          when(mockAuthRepository.login(testUsername, testPassword))
              .thenThrow(ClientException('Network error'));
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(
          username: testUsername,
          password: testPassword,
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
      );
    });

    group('AuthRegister', () {
      const String testUsername = 'testuser';
      const String testEmail = 'testuser@example.com';
      const String testPassword = 'testpassword';
      const String testConfirmPassword = 'testpassword';
      const String testToken = 'testtoken';

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when registration fails',
        build: () {
          when(mockAuthRepository.register(
                  testUsername, testEmail, testPassword, testConfirmPassword))
              .thenThrow(Exception('Registration failed'));
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthRegister(
          username: testUsername,
          email: testEmail,
          password: testPassword,
          confirmPassword: testConfirmPassword,
        )),
        expect: () => [
          AuthLoading(),
          isA<AuthFailure>(),
        ],
        verify: (bloc) {
          verify(mockAuthRepository.register(
              testUsername, testEmail, testPassword, testConfirmPassword));
        },
      );
    });
  });
}
