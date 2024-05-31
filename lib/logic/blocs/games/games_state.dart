part of 'games_bloc.dart';

@immutable
sealed class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}

final class GamesInitial extends GamesState {}

final class GamesLoading extends GamesState {}

final class GamesLoaded extends GamesState {
  final List<Game> games;
  final List<int> favoriteGames;

  GamesLoaded(this.games, this.favoriteGames);
}

final class GameLoadError extends GamesState {
  final String error;

  GameLoadError(this.error);
}

final class GameCreationSuccess extends GamesState {
  final Game game;

  GameCreationSuccess(this.game);
}

final class GameUpdateSuccess extends GamesState {
  final Game game;

  GameUpdateSuccess(this.game);
}

final class GameDeleteSuccess extends GamesState {
  final Game game;

  GameDeleteSuccess(this.game);
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
