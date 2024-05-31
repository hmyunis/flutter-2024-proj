import 'dart:convert';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/repositories/games_repository.dart';
import 'package:video_game_catalogue_app/data/data_providers/games_data_provider.dart';
import 'package:video_game_catalogue_app/models/game.dart';

class MockGamesDataProvider extends Mock implements GamesDataProvider {}

void main() {
  late GamesRepository gamesRepository;
  late MockGamesDataProvider mockGamesDataProvider;

  flutter_test.setUp(() {
    mockGamesDataProvider = MockGamesDataProvider();
    gamesRepository = GamesRepository(mockGamesDataProvider);
  });

  flutter_test.group('GamesRepository', () {
    flutter_test.test('getGames', () async {
      final jsonResponse = jsonEncode([
        {
          'id': 1,
          'title': 'Game 1',
          'description': 'Description 1',
          'genre': 'Action',
          'platform': 'Platform 1',
          'publisher': 'Publisher 1',
          'releaseDate': '2024-05-30',
          'imageUrl': 'image_url_1'
        },
        {
          'id': 2,
          'title': 'Game 2',
          'description': 'Description 2',
          'genre': 'Adventure',
          'platform': 'Platform 2',
          'publisher': 'Publisher 2',
          'releaseDate': '2024-06-15',
          'imageUrl': 'image_url_2'
        }
      ]);

      when(() => mockGamesDataProvider.getGames())
          .thenAnswer((_) async => jsonResponse);

      final games = await gamesRepository.getGames();
    });

    flutter_test.test('getGame', () async {
      final jsonResponse = jsonEncode({
        'id': 1,
        'title': 'Game 1',
        'description': 'Description 1',
        'genre': 'Action',
        'platform': 'Platform 1',
        'publisher': 'Publisher 1',
        'releaseDate': '2024-05-30',
        'imageUrl': 'image_url_1'
      });

      when(() => mockGamesDataProvider.getGameById('1'))
          .thenAnswer((_) async => jsonResponse);

      final game = await gamesRepository.getGame(1);
    });

    flutter_test.test('getGamesByGenre', () async {
      final jsonResponse = jsonEncode([
        {
          'id': 1,
          'title': 'Game 1',
          'description': 'Description 1',
          'genre': 'Action',
          'platform': 'Platform 1',
          'publisher': 'Publisher 1',
          'releaseDate': '2024-05-30',
          'imageUrl': 'image_url_1'
        },
        {
          'id': 2,
          'title': 'Game 2',
          'description': 'Description 2',
          'genre': 'Action',
          'platform': 'Platform 2',
          'publisher': 'Publisher 2',
          'releaseDate': '2024-06-15',
          'imageUrl': 'image_url_2'
        }
      ]);

      when(() => mockGamesDataProvider.getGamesByGenre('Action'))
          .thenAnswer((_) async => jsonResponse);

      final games = await gamesRepository.getGamesByGenre('Action');
    });
    flutter_test.test('createGame', () async {
      const token = 'mock_token';
      final game = Game(
          title: 'New Game',
          description: 'New Game Description',
          genre: 'Action',
          platform: 'Platform',
          publisher: 'Publisher',
          releaseDate: '2024-01-01',
          imageUrl: 'new_image_url');

      final jsonResponse = jsonEncode(game.toJson());

      when(() => mockGamesDataProvider.addGame(any(), token))
          .thenAnswer((_) async => jsonResponse);

      await gamesRepository.createGame(game, token);

      verify(() => mockGamesDataProvider.addGame({
            'title': game.title,
            'description': game.description,
            'genre': game.genre,
            'platform': game.platform,
            'publisher': game.publisher,
            'releaseDate': game.releaseDate,
            'imageUrl': game.imageUrl,
          }, token)).called(1);
    });

    flutter_test.test('updateGame', () async {
      const gameId = 1;
      final game = Game(
          id: gameId,
          title: 'Updated Game',
          description: 'Updated Game Description',
          genre: 'Adventure',
          platform: 'Updated Platform',
          publisher: 'Updated Publisher',
          releaseDate: '2024-02-02',
          imageUrl: 'updated_image_url');

      final jsonResponse = jsonEncode(game.toJson());

      when(() => mockGamesDataProvider.updateGame(any(), any()))
          .thenAnswer((_) async => jsonResponse);

      await gamesRepository.updateGame(game, 'mock_token');

      verify(() => mockGamesDataProvider.updateGame({
            'id': game.id,
            'title': game.title,
            'description': game.description,
            'genre': game.genre,
            'platform': game.platform,
            'publisher': game.publisher,
            'releaseDate': game.releaseDate,
            'imageUrl': game.imageUrl,
          }, 'mock_token')).called(1);
    });

    flutter_test.test('deleteGame', () async {
      const gameId = 1;

      when(() => mockGamesDataProvider.deleteGame(gameId.toString(), any()))
          .thenAnswer((_) async => null);

      await gamesRepository.deleteGame(gameId, 'mock_token');

      verify(() =>
              mockGamesDataProvider.deleteGame(gameId.toString(), 'mock_token'))
          .called(1);
    });
  });
}
