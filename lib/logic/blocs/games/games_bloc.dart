import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../data/data_providers/collections_data_provider.dart';
import '../../../data/repositories/collections_repository.dart';

import '../../../data/repositories/games_repository.dart';
import '../../../models/collection.dart';
import '../../../models/game.dart';

part 'games_event.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository _gamesRepository;

  GamesBloc(this._gamesRepository) : super(GamesInitial()) {
    on<GamesLoadEvent>(_onGamesLoadEvent);
    on<CreateGameEvent>(_onGameCreationEvent);
    on<UpdateGameEvent>(_onGameUpdateEvent);
    on<DeleteGameEvent>(_onGameDeleteEvent);
    on<AddGameToCollection>(_onAddGameToCollection);
    on<RemoveAGameFromCollection>(_onRemoveAGameFromCollection);
  }

  void _onGamesLoadEvent(GamesLoadEvent event, Emitter<GamesState> emit) async {
    emit(GamesLoading());

    if (event.flag == 1) {
      emit(GamesLoaded(const [], const []));
    }

    try {
      if (event.userId == null) {
        throw Exception("Please log in first.");
      }
      final CollectionsDataProvider collectionsDataProvider =
          CollectionsDataProvider();
      final CollectionsRepository collectionsRepository =
          CollectionsRepository(collectionsDataProvider);
      final List<Collection> collections =
          await collectionsRepository.getCollections();
      final List<Collection> usersCollection = collections
          .where((collection) => collection.userId == event.userId)
          .toList();
      final List<int> userFavoriteGameIds = <int>[];
      for (final collection in usersCollection) {
        userFavoriteGameIds.add(collection.gameId);
      }

      final games = await _gamesRepository.getGames();

      emit(GamesLoaded(games, userFavoriteGameIds));
      return;
    } catch (e) {
      emit(GameLoadError(e.toString()));
      return;
    }
  }

  void _onGameCreationEvent(
      CreateGameEvent event, Emitter<GamesState> emit) async {
    emit(GamesLoading());
    try {
      final String title = event.title;
      final String description = event.description;
      final String genre = event.genre;
      final String platform = event.platform;
      final String releaseDate = event.releaseDate;
      final String publisher = event.publisher;
      final String imageUrl = event.imageUrl;
      final String token = event.token;

      if (title.isEmpty ||
          description.isEmpty ||
          genre.isEmpty ||
          platform.isEmpty ||
          releaseDate.isEmpty ||
          publisher.isEmpty ||
          imageUrl.isEmpty) {
        emit(GameProcessingError("All fields are required"));
        return;
      }

      final Game game = Game(
        title: title,
        description: description,
        genre: genre,
        platform: platform,
        releaseDate: releaseDate,
        publisher: publisher,
        imageUrl: imageUrl,
      );

      await _gamesRepository.createGame(game, token);
      emit(GameCreationSuccess(game));
      return;
    } catch (e) {
      emit(GameProcessingError("Game creation failed."));
      return;
    }
  }

  void _onGameUpdateEvent(
      UpdateGameEvent event, Emitter<GamesState> emit) async {
    emit(GamesLoading());
    try {
      final String title = event.title;
      final String description = event.description;
      final String genre = event.genre;
      final String platform = event.platform;
      final String releaseDate = event.releaseDate;
      final String publisher = event.publisher;
      final String imageUrl = event.imageUrl;
      final String token = event.token;

      if (title.isEmpty ||
          description.isEmpty ||
          genre.isEmpty ||
          platform.isEmpty ||
          releaseDate.isEmpty ||
          publisher.isEmpty ||
          imageUrl.isEmpty) {
        emit(GameProcessingError("All fields are required"));
        return;
      }

      final Game game = Game(
        id: event.id,
        title: title,
        description: description,
        genre: genre,
        platform: platform,
        releaseDate: releaseDate,
        publisher: publisher,
        imageUrl: imageUrl,
      );

      await _gamesRepository.updateGame(game, token);
      emit(GameUpdateSuccess(game));
      return;
    } catch (e) {
      emit(GameProcessingError("Game update failed."));
      return;
    }
  }

  void _onGameDeleteEvent(
      DeleteGameEvent event, Emitter<GamesState> emit) async {
    emit(GamesLoading());
    try {
      if (event.game.id == null) {
        emit(GameProcessingError("Game ID is required"));
        return;
      }
      await _gamesRepository.deleteGame(event.game.id!, event.token);
      emit(GameDeleteSuccess(event.game));
      return;
    } catch (e) {
      emit(GameProcessingError("Game deletion failed."));
      return;
    }
  }

  void _onAddGameToCollection(
      AddGameToCollection event, Emitter<GamesState> emit) async {
    emit(GamesLoading());
    if (event.flag == 1) {
      emit(GameToCollectionAddSuccess(""));
    }
    try {
      final CollectionsDataProvider collectionsDataProvider =
          CollectionsDataProvider();
      final CollectionsRepository collectionsRepository =
          CollectionsRepository(collectionsDataProvider);
      await collectionsRepository.addCollection(
        Collection(
          status: "UNPINNED",
          gameId: event.game.id!,
          userId: event.userId,
        ),
      );
      emit(GameToCollectionAddSuccess(event.game.title));
      return;
    } catch (e) {
      emit(GameLoadError(e.toString()));
    }
  }

  void _onRemoveAGameFromCollection(
      RemoveAGameFromCollection event, Emitter<GamesState> emit) async {
    emit(GamesLoading());
    if (event.flag == 1) {
      emit(GameFromCollectionRemoveSuccess(""));
    }
    try {
      final CollectionsDataProvider collectionsDataProvider =
          CollectionsDataProvider();
      final CollectionsRepository collectionsRepository =
          CollectionsRepository(collectionsDataProvider);
      final List<Collection> collections =
          await collectionsRepository.getCollections();
      final col = collections
          .where((collection) =>
              collection.userId == event.userId &&
              collection.gameId == event.game.id)
          .toList();
      if (col.isEmpty) {
        emit(GameLoadError("Collection not found"));
        return;
      }
      final collectionId = col[0].id;

      await collectionsRepository.deleteCollection(collectionId!);
      emit(GameFromCollectionRemoveSuccess(event.game.title));
      return;
    } catch (e) {
      emit(GameLoadError(e.toString()));
    }
  }
}
