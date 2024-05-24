import 'dart:convert';

import '../../models/game.dart';

import '../data_providers/games_data_provider.dart';

class GamesRepository {
  final GamesDataProvider _gamesDataProvider;

  GamesRepository(this._gamesDataProvider);

  Future<List<Game>> getGames() async {
    final response = await _gamesDataProvider.getGames();
    final games = jsonDecode(response);
    final allGames = <Game>[];
    for (final game in games){
      allGames.add(Game.fromJson(game));
    }
    return allGames;
  }

  Future<Game> getGame(int id) async {
    final response = await _gamesDataProvider.getGameById(id.toString());
    final game = jsonDecode(response);
    return Game.fromJson(game);
  }

  Future getGamesByGenre(String genre) {
    return _gamesDataProvider.getGamesByGenre(genre);
  }

  Future<void> createGame(Game game, String token) async {
    await _gamesDataProvider.addGame({
      'title': game.title,
      'description': game.description,
      'genre': game.genre,
      'platform': game.platform,
      'publisher': game.publisher,
      'releaseDate': game.releaseDate,
      'imageUrl': game.imageUrl,
    }, token);
  }

  Future<void> updateGame(Game game, String token) async {
    await _gamesDataProvider.updateGame({
      'id': game.id,
      'title': game.title,
      'description': game.description,
      'genre': game.genre,
      'platform': game.platform,
      'publisher': game.publisher,
      'releaseDate': game.releaseDate,
      'imageUrl': game.imageUrl,
    }, token);
  }

  Future<void> deleteGame(int id, String token) async {
    await _gamesDataProvider.deleteGame(id.toString(), token);
  }
}
