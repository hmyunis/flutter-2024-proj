import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import '../../../data/data_providers/users_data_provider.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../data/repositories/auth_repository.dart';

import '../../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLogin>(_onAuthLoginRequested);
    on<AuthRegister>(_onAuthRegisterRequested);
  }
  void _onAuthLoginRequested(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final username = event.username.trim();
      final password = event.password.trim();

      if (username.isEmpty || password.isEmpty) {
        if (username.isEmpty && password.isNotEmpty) {
          emit(AuthFailure('Username cannot be empty.'));
        }
        if (password.isEmpty && username.isNotEmpty) {
          emit(AuthFailure('Password cannot be empty.'));
        } else {
          emit(AuthFailure('Please fill in all of the fields.'));
        }
        return;
      }

      if (username.length < 4 || password.length < 8) {
        if (username.length < 4 && password.length >= 8) {
          emit(AuthFailure('Username must be at least 4 characters.'));
        }
        if (username.length >= 4 && password.length < 8) {
          emit(AuthFailure('Password must be at least 8 characters.'));
        }
        if (username.length < 4 && password.length < 8) {
          emit(AuthFailure('Username and password are too short.'));
        }
        return;
      }

      var token = await _authRepository.login(username, password);
      token = jsonDecode(token);

      final UsersDataProvider usersDataProvider = UsersDataProvider();
      final UsersRepository usersRepository =
          UsersRepository(usersDataProvider);
      final User loggedInUser = await usersRepository.getCurrentUser(token);

      emit(
        AuthSuccess(
            user: User(
          id: loggedInUser.id,
          username: loggedInUser.username,
          email: loggedInUser.email,
          joinDate: loggedInUser.joinDate,
          role: loggedInUser.role,
          token: token,
        )),
      );
    } on ClientException {
      return emit(AuthFailure("Please connect to the API server first."));
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthRegisterRequested(
      AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final username = event.username.trim();
      final email = event.email.trim();
      final password = event.password.trim();
      final confirmPassword = event.confirmPassword.trim();

      if (username.isEmpty ||
          password.isEmpty ||
          email.isEmpty ||
          confirmPassword.isEmpty) {
        emit(AuthFailure('Please fill in all of the fields.'));
        return;
      }

      if (username.length < 4 || password.length < 8) {
        if (username.length < 4 && password.length >= 8) {
          emit(AuthFailure('Username must be at least 4 characters.'));
        }
        if (username.length >= 4 && password.length < 8) {
          emit(AuthFailure('Password must be at least 8 characters.'));
        }
        if (username.length < 4 && password.length < 8) {
          emit(AuthFailure('Username and password are too short.'));
        }
        return;
      }

      if (isValidEmail(email) != 'true') {
        emit(AuthFailure(isValidEmail(email)));
        return;
      }

      if (password != confirmPassword) {
        emit(AuthFailure('Passwords do not match.'));
        return;
      }

      var token = await _authRepository.register(
          username, email, password, confirmPassword);
      token = jsonDecode(token);

      final UsersDataProvider usersDataProvider = UsersDataProvider();
      final UsersRepository usersRepository =
          UsersRepository(usersDataProvider);
      final User registeredUser = await usersRepository.getCurrentUser(token);

      emit(
        AuthSuccess(
          user: User(
            id: registeredUser.id,
            username: registeredUser.username,
            email: registeredUser.email,
            joinDate: registeredUser.joinDate,
            role: registeredUser.role,
            token: token,
          ),
        ),
      );
    } on ClientException {
      return emit(AuthFailure("Please connect to the API server first."));
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  String isValidEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be null or empty.';
    }

    // Regular expression pattern for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regular expression pattern
    if (!emailRegex.hasMatch(email)) {
      return 'Email address is not in the correct format.';
    }

    final emailParts = email.split('@');
    final username = emailParts[0];
    final domain = emailParts[1];

    bool isValidUsername(String username) {
      // Define the regular expression pattern for valid username
      final usernameRegex = RegExp(r'^[\w\-]+$');
      return usernameRegex.hasMatch(username);
    }

    bool isValidDomain(String domain) {
      // Define the regular expression pattern for valid domain
      final domainRegex = RegExp(r'^[\w\-]+(\.[a-zA-Z]{2,4})+$');
      return domainRegex.hasMatch(domain);
    }

    // Check if the username is not empty and contains only valid characters
    if (username.isEmpty || !isValidUsername(username)) {
      return 'Username is not valid.';
    }

    // Check if the domain is not empty and contains only valid characters
    if (domain.isEmpty || !isValidDomain(domain)) {
      return 'Domain is not valid.';
    }

    // If all checks pass, the email is valid
    return 'true';
  }
}
