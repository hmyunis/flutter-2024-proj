import '../data_providers/auth_data_provider.dart';

class AuthRepository {
  final AuthDataProvider _authDataProvider;

  AuthRepository(this._authDataProvider);

  Future<String> login(String username, String password) async {
    return await _authDataProvider.signin(username, password);
  }

  Future<String> register(String username, String email, String password, String confirmPassword) async {
    return await _authDataProvider.signup(username, email, password, confirmPassword);
  }

  Future<void> logout() async {
    await _authDataProvider.logout();
  }

  String? get token => _authDataProvider.token;
}
