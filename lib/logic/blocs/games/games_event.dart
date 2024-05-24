part of 'games_bloc.dart';

@immutable
sealed class GamesEvent {}

class GamesLoadEvent extends GamesEvent {
  final int? userId;

  GamesLoadEvent(this.userId);
}

class CreateGameEvent extends GamesEvent {
  final String title;
  final String description;
  final String genre;
  final String platform;
  final String publisher;
  final String releaseDate;
  final String imageUrl;
  final String token;

  CreateGameEvent({
    required this.title,
    required this.description,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.releaseDate,
    required this.imageUrl,
    required this.token,
  });
}

class UpdateGameEvent extends GamesEvent {
  final int id;
  final String title;
  final String description;
  final String genre;
  final String platform;
  final String publisher;
  final String releaseDate;
  final String imageUrl;
  final String token;

  UpdateGameEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.releaseDate,
    required this.imageUrl,
    required this.token,
  });
}

class DeleteGameEvent extends GamesEvent {
  final Game game;
  final String token;

  DeleteGameEvent({
    required this.game,
    required this.token,
  });
}

class AddGameToCollection extends GamesEvent {
  final Game game;
  final int userId;

  AddGameToCollection(this.game, this.userId);
}

class RemoveAGameFromCollection extends GamesEvent {
  final Game game;
  final int userId;

  RemoveAGameFromCollection(this.game, this.userId);
}
