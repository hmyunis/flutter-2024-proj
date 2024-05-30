import 'package:bloc_test/bloc_test.dart';
import 'package:video_game_catalogue_app/data/repositories/reviews_repository.dart';
import 'package:video_game_catalogue_app/logic/blocs/review/review_bloc.dart';
import 'package:video_game_catalogue_app/models/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'review_bloc_test.mocks.dart';

@GenerateMocks([ReviewsRepository])
void main() {
  group('ReviewBloc', () {
    late ReviewsRepository reviewsRepository;
    late ReviewBloc reviewBloc;

    setUp(() {
      reviewsRepository = MockReviewsRepository();
      reviewBloc = ReviewBloc(reviewsRepository);
    });

    tearDown(() {
      reviewBloc.close();
    });

    test('initial state is ReviewInitial', () {
      expect(reviewBloc.state, ReviewInitial());
    });

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewLoading, ReviewEmpty] when LoadGameReviews event is added and repository returns empty list',
      build: () {
        when(reviewsRepository.getReviewsByGameId(1))
            .thenAnswer((_) async => []);
        return reviewBloc;
      },
      act: (bloc) => bloc.add(LoadGameReviews(Game(
        id: 1,
        title: 'Test Game',
        description: 'A test game',
        genre: 'Test',
        platform: 'Test',
        publisher: 'Test Publisher',
        releaseDate: '2023-04-01',
        imageUrl: 'https://example.com/image.jpg',
      ), 1)),
      expect: () => [
        ReviewLoading(),
        ReviewEmpty(Game(
          id: 1,
          title: 'Test Game',
          description: 'A test game',
          genre: 'Test',
          platform: 'Test',
          publisher: 'Test Publisher',
          releaseDate: '2023-04-01',
          imageUrl: 'https://example.com/image.jpg',
        )),
      ],
    );
  });
}
