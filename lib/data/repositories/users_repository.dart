import 'dart:convert';

import '../../models/user.dart';

import '../data_providers/users_data_provider.dart';

class UsersRepository {
  final UsersDataProvider _usersDataProvider;
  UsersRepository(this._usersDataProvider);

  Future<User> getCurrentUser() async {
    var user = await _usersDataProvider.getCurrentUser();
    user = jsonDecode(user);
    final userId = user['id'].toString();
    return await getUserById(userId);
  }

  Future<User> getUserById(String id) async {
    final user = await _usersDataProvider.getUserById(id);
    return User.fromJson(jsonDecode(user));
  }

  Future<List<User>> getUsers() async {
    final users = await _usersDataProvider.getUsers();
    return users.map((user) => User.fromJson(jsonDecode(user))).toList();
  }

  Future<User> updateUser(String id, Map<String, dynamic> user) async {
    final data = await _usersDataProvider.updateUser(id, user);
    return User.fromJson(jsonDecode(data));
  }

  Future deleteUser(String id) async {
    final user = await _usersDataProvider.deleteUser(id);
    return User.fromJson(jsonDecode(user));
  }

  Future toggleAdmin(String id) async {
    final user = await _usersDataProvider.toggleAdmin(id);
    return User.fromJson(jsonDecode(user));
  }
}
