part of 'collection_bloc.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class CollectionLoading extends CollectionState {}

final class CollectionLoaded extends CollectionState {
  final List<Game> pinnedGames;
  final List<Game> unPinnedGames;

  CollectionLoaded(this.pinnedGames, this.unPinnedGames);
}

final class CollectionEmpty extends CollectionState {}

final class GamePinnedSuccess extends CollectionState {
  final String title;

  GamePinnedSuccess(this.title);
}

final class GameRemovedSuccess extends CollectionState {
  final String title;

  GameRemovedSuccess(this.title);
}

final class CollectionError extends CollectionState {
  final String message;

  CollectionError(this.message);
}
