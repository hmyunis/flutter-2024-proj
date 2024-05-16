import 'dart:convert';

import '../../models/game.dart';

import '../data_providers/games_data_provider.dart';

class GamesRepository {
  final GamesDataProvider _gamesDataProvider;

  GamesRepository(this._gamesDataProvider);

  Future<List<Game>> getGames() async {
    final response = await _gamesDataProvider.getGames();
    final games = jsonDecode(response);
    return games.map((game) => Game.fromJson(game)).toList();
  }

  Future<Game> getGame(int id) async {
    final response = await _gamesDataProvider.getGameById(id);
    final game = jsonDecode(response);
    return Game.fromJson(game);
  }

  Future getGamesByGenre(String genre) {
    return _gamesDataProvider.getGamesByGenre(genre);
  }

  Future<void> createGame(Game game) async {
    await _gamesDataProvider.addGame({
      'title': game.title,
      'description': game.description,
      'genre': game.genre,
      'platform': game.platform,
      'publisher': game.publisher,
      'releaseDate': game.releaseDate,
      'imageUrl': game.imageUrl,
    });
  }

  Future<void> updateGame(int id, Game game) async {
    await _gamesDataProvider.updateGame(id, {
      'title': game.title,
      'description': game.description,
      'genre': game.genre,
      'platform': game.platform,
      'publisher': game.publisher,
      'releaseDate': game.releaseDate,
      'imageUrl': game.imageUrl,
    });
  }

  Future<void> deleteGame(int id) async {
    await _gamesDataProvider.deleteGame(id);
  }
}
