part of 'user_session_bloc.dart';

@immutable
sealed class UserSessionEvent {}

class UserSessionLogin extends UserSessionEvent {}

class UserSessionLogout extends UserSessionEvent {}

class UserSessionCheck extends UserSessionEvent {}

class UserSessionCheckSuccess extends UserSessionEvent {}

class UserSessionCheckFailure extends UserSessionEvent {}
