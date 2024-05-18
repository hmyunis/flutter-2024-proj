import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/games_repository.dart';
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
  }

  void _onGamesLoadEvent(GamesLoadEvent event, Emitter<GamesState> emit) async {
    emit(GamesLoading());
    try {
      final games = await _gamesRepository.getGames();
      emit(GamesLoaded(games));
      return;
    } catch (e) {
      emit(GameLoadError(e.toString()));
      return;
    }
  }

  void _onGameCreationEvent(
      CreateGameEvent event, Emitter<GamesState> emit) async {
    emit(GameProcessing());
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
      emit(GameProcessingSuccess(game));
      return;
    } catch (e) {
      emit(GameProcessingError(e.toString()));
      return;
    }
  }

  void _onGameUpdateEvent(
      UpdateGameEvent event, Emitter<GamesState> emit) async {
    emit(GameProcessing());
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

      await _gamesRepository.updateGame(game, token);
      emit(GameProcessingSuccess(game));
      return;
    } catch (e) {
      emit(GameProcessingError(e.toString()));
      return;
    }
  }

  void _onGameDeleteEvent(
      DeleteGameEvent event, Emitter<GamesState> emit) async {
    emit(GameProcessing());
    try {
      if (event.game.id == null){
        emit(GameProcessingError("Game ID is required"));
        return;
      }
      await _gamesRepository.deleteGame(event.game.id!, event.token);
      emit(GameProcessingSuccess(event.game));
      return;
    } catch (e) {
      emit(GameProcessingError(e.toString()));
      return;
    }
  }
}
