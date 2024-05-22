import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/logic/blocs/games/games_bloc.dart';
import 'package:video_game_catalogue_app/logic/repositories/games_repository.dart';

class MockGamesRepository extends Mock implements GamesRepository {}

void main() {
  group('GamesBloc', () {
    late MockGamesRepository mockGamesRepository;
    late GamesBloc gamesBloc;

    setUp(() {
      mockGamesRepository = MockGamesRepository();
      gamesBloc = GamesBloc(gamesRepository: mockGamesRepository);
    });

    test('initial state is GamesLoading', () {
      expect(gamesBloc.state, GamesLoading());
    });

    test('emits GamesLoaded state on GamesLoadEvent', () async {
      // Arrange
      when(() => mockGamesRepository.fetchGames()).thenAnswer((_) async => []); // Mock successful game fetch

      // Act
      gamesBloc.add(GamesLoadEvent());

      // Assert
      expectLater(gamesBloc.stream, emits(isA<GamesLoaded>()));
    });

    test('emits GameLoadError state on failure', () async {
      // Arrange
      when(() => mockGamesRepository.fetchGames()).thenThrow(Exception('Error')); // Mock failure

      // Act
      gamesBloc.add(GamesLoadEvent());

      // Assert
      expectLater(gamesBloc.stream, emits(isA<GameLoadError>()));
    });
  });
}