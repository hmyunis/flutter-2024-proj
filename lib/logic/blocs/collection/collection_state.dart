part of 'collection_bloc.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class CollectionLoading extends CollectionState {}

final class CollectionLoaded extends CollectionState {
  final List<Game> games;

  CollectionLoaded(this.games);
}

final class CollectionError extends CollectionState {
  final String message;

  CollectionError(this.message);
}
