part of 'collection_bloc.dart';

@immutable
sealed class CollectionEvent {}

class FetchCollection extends CollectionEvent {
  final String token;

  FetchCollection(this.token);
}

class AddToCollection extends CollectionEvent {
  final Game game;

  AddToCollection(this.game);
}

class RemoveFromCollection extends CollectionEvent {
  final Game game;
  final int userId;

  RemoveFromCollection(this.game, this.userId);
}

class PinGameInCollection extends CollectionEvent {
  final Game game;
  final int userId;

  PinGameInCollection(this.game, this.userId);
}

class UnpinGameInCollection extends CollectionEvent {
  final Game game;
  final int userId;

  UnpinGameInCollection(this.game, this.userId);
}

class ClearCollection extends CollectionEvent {}
