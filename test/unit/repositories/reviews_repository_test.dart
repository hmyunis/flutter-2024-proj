import 'dart:convert';

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/data_providers/reviews_data_provider.dart';
import 'package:video_game_catalogue_app/data/repositories/reviews_repository.dart';

class MockReviewsDataProvider extends Mock implements ReviewsDataProvider {}

void main() {
  late ReviewsRepository reviewsRepository;
  late MockReviewsDataProvider mockReviewsDataProvider;

  flutter_test.setUp(() {
    mockReviewsDataProvider = MockReviewsDataProvider();
    reviewsRepository = ReviewsRepository(mockReviewsDataProvider);
  });

  flutter_test.group('ReviewsRepository', () {
    flutter_test.test('getReviewsByGameId', () async {
      final jsonResponse = jsonEncode([
        {
          'id': 1,
          'userId': 1,
          'gameId': 101,
          'comment': 'Great game!',
          'rating': 5,
        },
        {
          'id': 2,
          'userId': 2,
          'gameId': 101,
          'comment': 'Could be better',
          'rating': 3,
        }
      ]);

      when(() => mockReviewsDataProvider.getReviewsByGameId('101'))
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('getReviewById', () async {
      final jsonResponse = jsonEncode({
        'id': 1,
        'userId': 1,
        'gameId': 101,
        'comment': 'Great game!',
        'rating': 5,
      });

      when(() => mockReviewsDataProvider.getReview('1'))
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('getReviews', () async {
      final jsonResponse = jsonEncode([
        {
          'id': 1,
          'userId': 1,
          'gameId': 101,
          'comment': 'Great game!',
          'rating': 5,
        },
        {
          'id': 2,
          'userId': 2,
          'gameId': 102,
          'comment': 'Could be better',
          'rating': 3,
        }
      ]);

      when(() => mockReviewsDataProvider.getReviews())
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('addReview', () async {
      final jsonResponse = jsonEncode({
        'id': 1,
        'userId': 1,
        'gameId': 101,
        'comment': 'Great game!',
        'rating': 5,
      });

      when(() => mockReviewsDataProvider.addReview(any()))
          .thenAnswer((_) async => jsonResponse);
    });

    flutter_test.test('deleteReview', () async {
      const reviewId = 1;

      when(() => mockReviewsDataProvider.deleteReview(reviewId.toString()))
          .thenAnswer((_) async {});

      await reviewsRepository.deleteReview(reviewId);
    });

    flutter_test.test('updateReview', () async {
      final updatedReviewData = {
        'id': 1,
        'userId': 1,
        'gameId': 101,
        'comment': 'Updated review',
        'rating': 4,
      };

      when(() => mockReviewsDataProvider.updateReview(any(), any()))
          .thenAnswer((_) async => jsonEncode(updatedReviewData));
    });
  });
}
