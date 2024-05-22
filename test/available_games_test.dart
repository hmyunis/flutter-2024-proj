import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/presentation/screens/available_games.dart'; // Import the file you want to test
import 'package:video_game_catalogue_app/presentation/data/games.dart';
import 'package:video_game_catalogue_app/presentation/widgets/games_list.dart'; // Import the games data

void main() {
  test('AvailableGames displays the correct AppBar title', () {
  // Arrange
  const expectedTitle = 'ALL GAMES';

  // Act
  final widget = MaterialApp(home: const AvailableGames());

  // Assert
  expect(find.text(expectedTitle), findsOneWidget);
});

test('AvailableGames displays the GamesList widget', () {
  // Arrange
  // No setup required

  // Act
  final widget = MaterialApp(home: const AvailableGames());

  // Assert
  expect(find.byType(GamesList), findsOneWidget);
});
test('AvailableGames passes the correct data to the GamesList widget', () {
  // Arrange
  // No setup required

  // Act
  final widget = MaterialApp(home: const AvailableGames());

  // Assert
  final gamesList = widget.child as Scaffold;
  final gamesListWidget = gamesList.body as GamesList;
  expect(gamesListWidget.games, games);
});

}