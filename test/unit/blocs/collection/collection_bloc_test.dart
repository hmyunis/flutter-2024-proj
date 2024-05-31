import 'package:bloc_test/bloc_test.dart';
import 'package:video_game_catalogue_app/data/data_providers/collections_data_provider.dart';
import 'package:video_game_catalogue_app/data/repositories/collections_repository.dart';
import 'package:video_game_catalogue_app/data/repositories/games_repository.dart';
import 'package:video_game_catalogue_app/models/collection.dart';
import 'package:video_game_catalogue_app/models/game.dart';
import 'package:video_game_catalogue_app/logic/blocs/games/games_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'collection_bloc_test.mocks.dart';

@GenerateMocks(
    [GamesRepository, CollectionsRepository, CollectionsDataProvider])
void main() {
  group('GamesBloc', () {
    late GamesRepository mockGamesRepository;
    late CollectionsRepository mockCollectionsRepository;
    late CollectionsDataProvider mockCollectionsDataProvider;
    late GamesBloc gamesBloc;

    final List<Game> mockGames = [
      Game(
        id: 1,
        title: 'Game 1',
        description: 'Description 1',
        genre: 'Genre 1',
        platform: 'Platform 1',
        publisher: 'Publisher 1',
        releaseDate: '2023-04-01',
        imageUrl: 'https://example.com/game1.jpg',
      ),
      Game(
        id: 2,
        title: 'Game 2',
        description: 'Description 2',
        genre: 'Genre 2',
        platform: 'Platform 2',
        publisher: 'Publisher 2',
        releaseDate: '2023-04-02',
        imageUrl: 'https://example.com/game2.jpg',
      ),
    ];

    setUp(() {
      mockGamesRepository = MockGamesRepository();
      mockCollectionsRepository = MockCollectionsRepository();
      mockCollectionsDataProvider = MockCollectionsDataProvider();
      gamesBloc = GamesBloc(mockGamesRepository);
    });

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GamesLoaded] when GamesLoadEvent is added and userId is not null',
      build: () => gamesBloc,
      act: (bloc) => bloc.add(GamesLoadEvent(3, flag: 1)),
      expect: () => [
        GamesLoading(),
        GamesLoaded(mockGames, const []),
      ],
    );

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GameLoadError] when GamesLoadEvent is added and userId is null',
      build: () => gamesBloc,
      act: (bloc) => bloc.add(GamesLoadEvent(null)),
      expect: () => [
        GamesLoading(),
        GameLoadError(""),
      ],
    );

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GameCreationSuccess] when CreateGameEvent is added and game creation is successful',
      build: () {
        when(mockGamesRepository.createGame(mockGames[1], ""))
            .thenAnswer((_) async => {});
        return gamesBloc;
      },
      act: (bloc) => bloc.add(
        CreateGameEvent(
          title: 'New Game',
          description: 'New Description',
          genre: 'New Genre',
          platform: 'New Platform',
          publisher: 'New Publisher',
          releaseDate: '2023-04-03',
          imageUrl: 'https://example.com/newgame.jpg',
          token: 'test-token',
        ),
      ),
      expect: () => [
        GamesLoading(),
        isA<GameCreationSuccess>(),
      ],
    );

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GameUpdateSuccess] when UpdateGameEvent is added and game update is successful',
      build: () {
        when(mockGamesRepository.updateGame(
                Game(
                    title: "title",
                    description: "description",
                    genre: "genre",
                    platform: "platform",
                    publisher: "publisher",
                    releaseDate: "releaseDate",
                    imageUrl: "imageUrl"),
                ""))
            .thenAnswer((_) async => {});
        return gamesBloc;
      },
      act: (bloc) => bloc.add(
        UpdateGameEvent(
          id: 1,
          title: 'Updated Game',
          description: 'Updated Description',
          genre: 'Updated Genre',
          platform: 'Updated Platform',
          publisher: 'Updated Publisher',
          releaseDate: '2023-04-04',
          imageUrl: 'https://example.com/updatedgame.jpg',
          token: 'test-token',
        ),
      ),
      expect: () => [
        GamesLoading(),
        isA<GameUpdateSuccess>(),
      ],
    );

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GameDeleteSuccess] when DeleteGameEvent is added and game deletion is successful',
      build: () {
        when(mockGamesRepository.deleteGame(1, '')).thenAnswer((_) async => {});
        return gamesBloc;
      },
      act: (bloc) => bloc.add(
        DeleteGameEvent(
          game: mockGames[0],
          token: 'test-token',
        ),
      ),
      expect: () => [
        GamesLoading(),
        isA<GameDeleteSuccess>(),
      ],
    );

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GameToCollectionAddSuccess] when AddGameToCollection is added',
      build: () {
        when(mockCollectionsRepository.addCollection(
                Collection(gameId: 1, userId: 1, status: "success")))
            .thenAnswer(
                (_) async => throw Exception('Failed to add collection'));
        return gamesBloc;
      },
      act: (bloc) => bloc.add(
        AddGameToCollection(mockGames[0], 1, flag: 1),
      ),
      expect: () => [
        GamesLoading(),
        isA<GameToCollectionAddSuccess>(),
      ],
    );

    blocTest<GamesBloc, GamesState>(
      'emits [GamesLoading, GameFromCollectionRemoveSuccess] when RemoveAGameFromCollection is added and collection is found',
      build: () {
        when(mockCollectionsRepository.getCollections()).thenAnswer(
          (_) async => [
            Collection(
              id: 1,
              status: 'UNPINNED',
              gameId: 1,
              userId: 1,
            ),
          ],
        );
        when(mockCollectionsRepository.deleteCollection(1))
            .thenAnswer((_) async => {});
        return gamesBloc;
      },
      act: (bloc) => bloc.add(
        RemoveAGameFromCollection(mockGames[0], 1, flag: 1),
      ),
      expect: () => [
        GamesLoading(),
        isA<GameFromCollectionRemoveSuccess>(),
      ],
    );
  });
}
