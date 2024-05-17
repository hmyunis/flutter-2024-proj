import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class UsersDataProvider {
  UsersDataProvider({required this.token});
  final String token;

  final _baseUrl = apiBaseUrl;

  Future getCurrentUser() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/users/whoami'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final user = response.body;
        return user;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future getUserById(String id) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/users/$id'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final user = response.body;
        return user;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future getUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));
      if (response.statusCode == 200) {
        final users = response.body;
        return users;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future updateUser(String id, Map<String, dynamic> user) async {
    try {
      final response = await http.patch(Uri.parse('$_baseUrl/users/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: user);
      if (response.statusCode == 200) {
        final updatedUser = response.body;
        return updatedUser;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future deleteUser(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('$_baseUrl/users/$id'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future toggleAdmin(String id) async {
    try {
      final response = await http.patch(Uri.parse('$_baseUrl/toggleadmin/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          );
      if (response.statusCode == 200) {
        final updatedUser = response.body;
        return updatedUser;
      }
    } catch (e) {
      e.toString();
    }
  }
}
