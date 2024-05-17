part of 'user_session_bloc.dart';

@immutable
sealed class UserSessionEvent {}

class UserSessionLogin extends UserSessionEvent {
  final User user;

  UserSessionLogin(this.user);
}

class UserSessionLogout extends UserSessionEvent {}
