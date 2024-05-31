import 'dart:convert';

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/data_providers/users_data_provider.dart';
import 'package:video_game_catalogue_app/models/user.dart';

class MockUsersDataProvider extends Mock implements UsersDataProvider {}

void main() {
  late MockUsersDataProvider mockUsersDataProvider;

  flutter_test.setUp(() {
    mockUsersDataProvider = MockUsersDataProvider();
  });

  flutter_test.group('UsersRepository', () {
    flutter_test.test('getCurrentUser - success', () async {
      const token = "dummy_token";
      final jsonResponse = jsonEncode({
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
        'joinDate': '2024-4-31',
        'role': 'owner'
      });

      when(() => mockUsersDataProvider.getCurrentUser(token))
          .thenAnswer((_) async => jsonResponse);

      when(() => mockUsersDataProvider.getUserById(any()))
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('getUserById - success', () async {
      const userId = 1;
      final jsonResponse = jsonEncode({
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
        'joinDate': '2024-4-31',
        'role': 'owner'
      });

      when(() => mockUsersDataProvider.getUserById(userId.toString()))
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('getUsers - success', () async {
      final jsonResponse = jsonEncode([
        {
          'id': 1,
          'username': 'user1',
          'email': 'user1@example.com',
          'joinDate': '2024-4-30',
          'role': 'user'
        },
        {
          'id': 2,
          'username': 'user2',
          'email': 'user2@example.com',
          'joinDate': '2024-4-30',
          'role': 'user'
        },
      ]);

      when(() => mockUsersDataProvider.getUsers())
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('updateUser - success', () async {
      final user = User(
        id: 1,
        username: 'test_user',
        email: 'test@example.com',
        joinDate: '2024-4-31',
        role: 'owner',
      );
      final jsonResponse = jsonEncode({
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
        'joinDate': '2024-4-31',
        'role': 'owner'
      });

      when(() => mockUsersDataProvider.updateUser(
            user.id.toString(),
            any(),
          )).thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('deleteUser - success', () async {
      const userId = 1;
      final jsonResponse = jsonEncode({
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
        'joinDate': '2024-4-31',
        'role': 'owner'
      });

      when(() => mockUsersDataProvider.deleteUser(userId.toString()))
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('toggleAdmin - success', () async {
      const userId = 1;
      const token = "dummy_token";
      final jsonResponse = jsonEncode({
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
        'joinDate': '2024-4-31',
        'role': 'admin'
      });

      when(() => mockUsersDataProvider.toggleAdmin(
            userId.toString(),
            token,
          )).thenAnswer((_) async => jsonResponse);
    });
  });
}
