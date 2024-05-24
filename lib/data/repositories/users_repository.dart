import 'dart:convert';

import '../../models/user.dart';

import '../data_providers/users_data_provider.dart';

class UsersRepository {
  final UsersDataProvider _usersDataProvider;
  UsersRepository(this._usersDataProvider);

  Future<User> getCurrentUser(String token) async {
    var user = await _usersDataProvider.getCurrentUser(token);
    user = jsonDecode(user);
    final userId = user['id'] as int;
    return await getUserById(userId);
  }

  Future<User> getUserById(int userId) async {
    final user = await _usersDataProvider.getUserById(userId.toString());
    return User.fromJson(jsonDecode(user));
  }

  Future<List<User>> getUsers() async {
    final response = await _usersDataProvider.getUsers();
    final users = jsonDecode(response);
    final allUsers = <User>[];
    for (final user in users) {
      allUsers.add(User.fromJson(user));
    }
    return allUsers;
  }

  Future<User> updateUser(User user, String? newPassword) async {
    final String updatedUser;
    if (newPassword == null || newPassword.trim() == '') {
      updatedUser = await _usersDataProvider.updateUser(user.id.toString(), {
        "username": user.username,
        "email": user.email,
      });
    } else {
      updatedUser = await _usersDataProvider.updateUser(user.id.toString(), {
        "username": user.username,
        "email": user.email,
        "password": newPassword,
      });
    }
    return User.fromJson(jsonDecode(updatedUser));
  }

  Future deleteUser(int userId) async {
    final user = await _usersDataProvider.deleteUser(userId.toString());
    return User.fromJson(jsonDecode(user));
  }

  Future<User> toggleAdmin(int userId, String token) async {
    final user = await _usersDataProvider.toggleAdmin(userId.toString(), token);
    return User.fromJson(jsonDecode(user));
  }
}
