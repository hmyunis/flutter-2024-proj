import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_providers/games_data_provider.dart';
import '../../../data/data_providers/users_data_provider.dart';
import '../../../data/repositories/collections_repository.dart';
import '../../../data/repositories/games_repository.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../models/collection.dart';
import '../../../models/game.dart';
import '../../../models/user.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionsRepository _collectionsRepository;

  CollectionBloc(this._collectionsRepository) : super(CollectionInitial()) {
    on<FetchCollection>(_onFetchCollection);
    on<PinGameInCollection>(_onPinGameInCollection);
    on<UnpinGameInCollection>(_onUnpinGameInCollection);
    on<RemoveGameFromCollection>(_onRemoveFromCollection);
  }

  Future<void> _onFetchCollection(
      FetchCollection event, Emitter<CollectionState> emit) async {
    emit(CollectionLoading());
    try {
      final UsersDataProvider usersDataProvider =
          UsersDataProvider();
      final UsersRepository usersRepository =
          UsersRepository(usersDataProvider);
      final User loggedInUser = await usersRepository.getCurrentUser(event.token);

      final userId = loggedInUser.id ?? 0;
      final List<int> unpinnedGameIds =
          await _collectionsRepository.getGameIdsByStatus(userId, "UNPINNED");
      final List<int> pinnedGameIds =
          await _collectionsRepository.getGameIdsByStatus(userId, "PINNED");

      final List<int> gamesInUsersCollection = [
        ...unpinnedGameIds,
        ...pinnedGameIds
      ];

      if (gamesInUsersCollection.isEmpty) {
        emit(CollectionEmpty());
        return;
      }

      final GamesDataProvider gamesDataProvider = GamesDataProvider();
      final GamesRepository gamesRepository =
          GamesRepository(gamesDataProvider);
      final List<Game> games = await gamesRepository.getGames();
      games.retainWhere((game) => gamesInUsersCollection.contains(game.id));

      final pinnedGames = <Game>[];
      final unPinnedGames = <Game>[];

      for (var game in games) {
        if (pinnedGameIds.contains(game.id)) {
          pinnedGames.add(game);
        } else {
          unPinnedGames.add(game);
        }
      }

      emit(CollectionLoaded([...pinnedGames], [...unPinnedGames]));
      return;
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onPinGameInCollection(
      PinGameInCollection event, Emitter<CollectionState> emit) async {
    emit(CollectionLoading());
    try {
      final List<Collection> collections =
          await _collectionsRepository.getCollections();
      final col = collections
          .where((collection) =>
              collection.userId == event.userId &&
              collection.gameId == event.game.id)
          .toList();
      if (col.isEmpty) {
        emit(CollectionError("Collection not found"));
        return;
      }
      final collectionId = col[0].id;

      await _collectionsRepository.updateCollection(
        collectionId!,
        Collection(
          status: "UNPINNED",
          gameId: event.game.id!,
          userId: event.userId,
        ),
      );
      return;
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onUnpinGameInCollection(
      UnpinGameInCollection event, Emitter<CollectionState> emit) async {
    emit(CollectionLoading());
    try {
      final List<Collection> collections =
          await _collectionsRepository.getCollections();
      final col = collections
          .where((collection) =>
              collection.userId == event.userId &&
              collection.gameId == event.game.id)
          .toList();
      if (col.isEmpty) {
        emit(CollectionError("Collection not found"));
        return;
      }
      final collectionId = col[0].id;

      await _collectionsRepository.updateCollection(
        collectionId!,
        Collection(
          status: "PINNED",
          gameId: event.game.id!,
          userId: event.userId,
        ),
      );
      emit(GamePinnedSuccess(event.game.title));
      return;
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onRemoveFromCollection(
      RemoveGameFromCollection event, Emitter<CollectionState> emit) async {
    emit(CollectionLoading());
    try {
      final List<Collection> collections =
          await _collectionsRepository.getCollections();
      final col = collections
          .where((collection) =>
              collection.userId == event.userId &&
              collection.gameId == event.game.id)
          .toList();
      if (col.isEmpty) {
        emit(CollectionError("Collection not found"));
        return;
      }
      final collectionId = col[0].id;

      await _collectionsRepository.deleteCollection(collectionId!);
      emit(GameRemovedSuccess(event.game.title));
      return;
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }
}
