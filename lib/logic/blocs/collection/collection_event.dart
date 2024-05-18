part of 'collection_bloc.dart';

@immutable
sealed class CollectionEvent {}

class FetchCollection extends CollectionEvent {}

class AddToCollection extends CollectionEvent {
  final Game game;

  AddToCollection(this.game);
}

class RemoveFromCollection extends CollectionEvent {
  final Game game;

  RemoveFromCollection(this.game);
}

class PinGameInCollection extends CollectionEvent {
  final Game game;

  PinGameInCollection(this.game);
}

class UnpinGameInCollection extends CollectionEvent {
  final Game game;

  UnpinGameInCollection(this.game);
}

class ClearCollection extends CollectionEvent {}
