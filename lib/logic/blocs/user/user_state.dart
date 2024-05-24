part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded(this.users);
}

final class UserUpdateSuccess extends UserState {
  final User user;

  UserUpdateSuccess(this.user);
}

final class UserDeleteSuccess extends UserState {
  final User user;

  UserDeleteSuccess(this.user);
}

final class PromotionSuccess extends UserState {
  final String username;

  PromotionSuccess(this.username);
}

final class DemotionSuccess extends UserState {
  final String username;

  DemotionSuccess(this.username);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}
