part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class FetchUsers extends UserEvent {}

final class UpdateUser extends UserEvent {
  final User user;
  final String? newPassword;

  UpdateUser(this.user, this.newPassword);
}

final class DeleteUser extends UserEvent {
  final User user;

  DeleteUser(this.user);
}

final class PromoteUser extends UserEvent {
  final int userId;
  final String token;

  PromoteUser(this.userId, this.token);
}

final class DemoteUser extends UserEvent {
  final int userId;
  final String token;

  DemoteUser(this.userId, this.token);
}
