part of 'games_bloc.dart';

@immutable
sealed class GamesState {}

final class GamesInitial extends GamesState {}

final class GamesLoading extends GamesState {}

final class GameProcessing extends GamesState {}

final class GamesLoaded extends GamesState {
  final List<Game> games;
  final List<int> favoriteGames;

  GamesLoaded(this.games, this.favoriteGames);
}

final class GameLoadError extends GamesState {
  final String error;

  GameLoadError(this.error);
}

final class GameProcessingSuccess extends GamesState {
  final Game game;

  GameProcessingSuccess(this.game);
}

final class GameProcessingError extends GamesState {
  final String error;

  GameProcessingError(this.error);
}

final class GameToCollectionAddSuccess extends GamesState {
  final String title;

  GameToCollectionAddSuccess(this.title);
}

final class GameFromCollectionRemoveSuccess extends GamesState {
  final String title;

  GameFromCollectionRemoveSuccess(this.title);
}

