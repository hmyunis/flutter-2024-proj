part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String username;
  final String password;

  AuthLogin({
    required this.username,
    required this.password,
  });
}

final class AuthRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  AuthRegister({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

final class AuthLogout extends AuthEvent {}
