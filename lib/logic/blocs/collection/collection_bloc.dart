import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/collections_repository.dart';
import '../../../models/game.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionsRepository _collectionsRepository;

  CollectionBloc(this._collectionsRepository) : super(CollectionInitial()) {
    on<FetchCollection>(_onFetchCollection);
  }

  Future<void> _onFetchCollection(
      FetchCollection event, Emitter<CollectionState> emit) async {
        emit(CollectionLoading());
        try {
          final collections = await _collectionsRepository.getCollections();
          collections.length.abs(); // placeholder - to remove squiggly lines
          // emit(CollectionLoaded());
        } catch (e) {
          emit(CollectionError(e.toString()));
        }
      }
}
