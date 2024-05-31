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

import 'games_bloc_test.mocks.dart';

// Generate mock classes using Mockito
@GenerateMocks(
    [GamesRepository, CollectionsRepository, CollectionsDataProvider])
void main() {
  group('GamesBloc', () {
    late GamesRepository mockGamesRepository;
    late CollectionsRepository mockCollectionsRepository;
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
      gamesBloc = GamesBloc(mockGamesRepository);
    });

    // Test case for RemoveAGameFromCollection
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

    // ... other tests ...
  });
}
