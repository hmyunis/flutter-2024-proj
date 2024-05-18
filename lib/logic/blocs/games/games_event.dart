part of 'games_bloc.dart';

@immutable
sealed class GamesEvent {}

class GamesLoadEvent extends GamesEvent {}

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
  final String title;
  final String description;
  final String genre;
  final String platform;
  final String publisher;
  final String releaseDate;
  final String imageUrl;
  final String token;

  UpdateGameEvent({
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