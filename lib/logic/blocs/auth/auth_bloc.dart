import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
// import '../../../data/data_providers/users_data_provider.dart';
// import '../../../data/repositories/users_repository.dart';
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
        emit(AuthFailure('Username or password cannot be empty'));
        return;
      }

      if (username.length < 4 || password.length < 8) {
        emit(AuthFailure('Username or password are too short.'));
        return;
      }

      final token = await _authRepository.login(username, password);
      // final UsersDataProvider usersDataProvider =
      //     UsersDataProvider(token: token);
      // final UsersRepository usersRepository =
      //     UsersRepository(usersDataProvider);
      // final User user = await usersRepository.getCurrentUser();
      emit(
        // dummy user
        AuthSuccess(
          user: User(
            id: 1,
            username: username,
            email: "sample@gmail.com",
            joinDate: "2023-05-06",
            role: "user",
            token: token,
          ),
        ),
      );
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

      if (username.isEmpty || password.isEmpty || email.isEmpty) {
        emit(AuthFailure('Please fill in all of the fields.'));
        return;
      }

      if (username.length < 4 || password.length < 8 || email.length < 8) {
        emit(AuthFailure('Username, email, or password are too short.'));
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

      final token = await _authRepository.register(
          username, email, password, confirmPassword);
      // final UsersDataProvider usersDataProvider =
      //    UsersDataProvider(token: token);
      // final UsersRepository usersRepository =
      //     UsersRepository(usersDataProvider);
      // final User user = await usersRepository.getCurrentUser();
      emit(
        // dummy user
        AuthSuccess(
          user: User(
            id: 1,
            username: username,
            email: email,
            joinDate: DateTime.now().toString(),
            role: "user",
            token: token,
          ),
        ),
      );
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  String isValidEmail(email) {
    // Check if the email is not null and not empty
    if (email == null || email.isEmpty) {
      return 'Email cannot be null or empty.';
    }

    // Define the regular expression pattern for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regular expression pattern
    if (!emailRegex.hasMatch(email)) {
      return 'Email address is not in the correct format.';
    }

    // Split the email into username and domain parts
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
