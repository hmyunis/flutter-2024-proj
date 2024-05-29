import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/user.dart';

void main() {
  group('User', () {
    test('User is created with correct values', () {
      const id = 1;
      const username = 'testUser';
      const email = 'test@example.com';
      const joinDate = '2024-01-01';
      const role = 'admin';
      const token = 'testToken';

      final user = User(
        id: id,
        username: username,
        email: email,
        joinDate: joinDate,
        role: role,
        token: token,
      );

      expect(user.id, equals(id));
      expect(user.username, equals(username));
      expect(user.email, equals(email));
      expect(user.joinDate, equals(joinDate));
      expect(user.role, equals(role));
      expect(user.token, equals(token));
    });

    test('User is created from JSON correctly', () {
      final json = {
        'id': 1,
        'username': 'testUser',
        'email': 'test@example.com',
        'joinDate': '2024-01-01',
        'role': 'admin',
      };

      final user = User.fromJson(json);

      expect(user.id, equals(json['id']));
      expect(user.username, equals(json['username']));
      expect(user.email, equals(json['email']));
      expect(user.joinDate, equals(json['joinDate']));
      expect(user.role, equals(json['role']));
      expect(user.token, isNull);
    });

    test('toString returns the correct string representation', () {
      const id = 1;
      const username = 'testUser';
      const email = 'test@example.com';
      const joinDate = '2024-01-01';
      const role = 'admin';
      const token = 'testToken';

      final user = User(
        id: id,
        username: username,
        email: email,
        joinDate: joinDate,
        role: role,
        token: token,
      );
      const expectedString = 'User(id: $id, username: $username, email: $email, joinDate: $joinDate, role: $role, token: $token)';

      expect(user.toString(), equals(expectedString));
    });

    test('User can be created without id and token', () {
      const username = 'testUser';
      const email = 'test@example.com';
      const joinDate = '2024-01-01';
      const role = 'admin';

      final user = User(
        username: username,
        email: email,
        joinDate: joinDate,
        role: role,
      );

      expect(user.id, isNull);
      expect(user.username, equals(username));
      expect(user.email, equals(email));
      expect(user.joinDate, equals(joinDate));
      expect(user.role, equals(role));
      expect(user.token, isNull);
    });
  });
}
