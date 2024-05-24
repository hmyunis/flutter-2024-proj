import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_providers/users_data_provider.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository _usersRepository;

  UserBloc(this._usersRepository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<PromoteUser>(_onPromoteUser);
    on<DemoteUser>(_onDemoteUser);
    on<UpdateUser>(_onUserUpdate);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final List<User> users = await _usersRepository.getUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onPromoteUser(
      PromoteUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _usersRepository.toggleAdmin(event.userId, event.token);

      final UsersDataProvider usersDataProvider = UsersDataProvider();
      final UsersRepository usersRepository =
          UsersRepository(usersDataProvider);
      final User user = await usersRepository.getUserById(event.userId);

      emit(PromotionSuccess(user.username));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onDemoteUser(DemoteUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _usersRepository.toggleAdmin(event.userId, event.token);

      final UsersDataProvider usersDataProvider = UsersDataProvider();
      final UsersRepository usersRepository =
          UsersRepository(usersDataProvider);
      final User user = await usersRepository.getUserById(event.userId);

      emit(DemotionSuccess(user.username));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUserUpdate(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final username = event.user.username.trim();
      final email = event.user.email.trim();
      final password = event.newPassword?.trim();

      if (username.isEmpty ||
          password == null ||
          password.isEmpty ||
          email.isEmpty) {
        emit(UserError('Please fill in all three fields.'));
        return;
      }

      if (username.length < 4 || password.length < 8) {
        if (username.length < 4 && password.length >= 8) {
          emit(UserError('Username must be at least 4 characters.'));
        }
        if (username.length >= 4 && password.length < 8) {
          emit(UserError('Password must be at least 8 characters.'));
        }
        if (username.length < 4 && password.length < 8) {
          emit(UserError('Username and password are too short.'));
        }
        return;
      }

      if (isValidEmail(email) != 'true') {
        emit(UserError(isValidEmail(email)));
        return;
      }
      final User updatedUser =
          await _usersRepository.updateUser(event.user, event.newPassword);
      emit(UserUpdateSuccess(updatedUser));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _usersRepository.deleteUser(event.user.id!);
      emit(UserDeleteSuccess(event.user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  String isValidEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be null or empty.';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return 'Email address is not in the correct format.';
    }

    final emailParts = email.split('@');
    final username = emailParts[0];
    final domain = emailParts[1];

    bool isValidUsername(String username) {
      final usernameRegex = RegExp(r'^[\w\-]+$');
      return usernameRegex.hasMatch(username);
    }

    bool isValidDomain(String domain) {
      final domainRegex = RegExp(r'^[\w\-]+(\.[a-zA-Z]{2,4})+$');
      return domainRegex.hasMatch(domain);
    }

    if (username.isEmpty || !isValidUsername(username)) {
      return 'Username is not valid.';
    }

    if (domain.isEmpty || !isValidDomain(domain)) {
      return 'Domain is not valid.';
    }

    return 'true';
  }
}
