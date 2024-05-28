import 'dart:convert';

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/repositories/users_repository.dart';
import 'package:video_game_catalogue_app/data/data_providers/users_data_provider.dart';
import 'package:video_game_catalogue_app/models/user.dart';

class MockUsersDataProvider extends Mock implements UsersDataProvider {}

void main() {
  late UsersRepository usersRepository;
  late MockUsersDataProvider mockUsersDataProvider;

  flutter_test.setUp(() {
    mockUsersDataProvider = MockUsersDataProvider();
    usersRepository = UsersRepository(mockUsersDataProvider);
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

      // Mocking the behavior of getCurrentUser to return a non-null response
      when(() => mockUsersDataProvider.getCurrentUser(token))
          .thenAnswer((_) async => jsonResponse);

      // Mocking the behavior of getUserById to return a non-null response
      when(() => mockUsersDataProvider.getUserById(any()))
          .thenAnswer((_) async => jsonResponse);

      // Now, when getCurrentUser is called, it will return the jsonResponse
      final result = await usersRepository.getCurrentUser(token);

      // Add your assertions here
    });

    flutter_test.test('getUserById - success', () async {
  const userId = 1; // Assuming userId is an int
  final jsonResponse = jsonEncode({
    'id': 1,
    'username': 'test_user',
    'email': 'test@example.com',
    'joinDate': '2024-4-31',
    'role': 'owner'
  });

  // Mocking the behavior of getUserById to return a non-null response
  when(() => mockUsersDataProvider.getUserById(userId.toString()))
      .thenAnswer((_) async => jsonResponse); // Convert userId to string here

  // Now, when getUserById is called, it will return the jsonResponse
  final result = await usersRepository.getUserById(userId);

  // Add your assertions here
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

      // Mocking the behavior of getUsers to return a non-null response
      when(() => mockUsersDataProvider.getUsers())
          .thenAnswer((_) async => jsonResponse);

      // Now, when getUsers is called, it will return the jsonResponse
      final result = await usersRepository.getUsers();

      // Add your assertions here
    });

    flutter_test.test('updateUser - success', () async {
      const newPassword = 'new_password';
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

      // Mocking the behavior of updateUser to return a non-null response
      when(() => mockUsersDataProvider.updateUser(
            user.id.toString(),
            any(),
          )).thenAnswer((_) async => jsonResponse);

      // Now, when updateUser is called, it will return the jsonResponse
      final result = await usersRepository.updateUser(user, newPassword);

      // Add your assertions here
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

      // Mocking the behavior of deleteUser to return a non-null response
      when(() => mockUsersDataProvider.deleteUser(userId.toString()))
          .thenAnswer((_) async => jsonResponse);

      // Now, when deleteUser is called, it will return the jsonResponse
      final result = await usersRepository.deleteUser(userId);

      // Add your assertions here
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

      // Mocking the behavior of toggleAdmin to return a non-null response
      when(() => mockUsersDataProvider.toggleAdmin(
            userId.toString(),
            token,
          )).thenAnswer((_) async => jsonResponse);

      // Now, when toggleAdmin is called, it will return the jsonResponse
      final result = await usersRepository.toggleAdmin(userId, token);

      // Add your assertions here
    });
  });
}
