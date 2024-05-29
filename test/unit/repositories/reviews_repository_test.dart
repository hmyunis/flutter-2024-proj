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
      // Mock response containing a list of reviews
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

      // Mock the response from the data provider
      when(() => mockReviewsDataProvider.getReviewsByGameId('101')).thenAnswer((_) async => jsonResponse);

      // Assertions...
    });

    flutter_test.test('getReviewById', () async {
      // Mock response for a single review
      final jsonResponse = jsonEncode({
        'id': 1,
        'userId': 1,
        'gameId': 101,
        'comment': 'Great game!',
        'rating': 5,
      });

      // Mock the response from the data provider
      when(() => mockReviewsDataProvider.getReview('1')).thenAnswer((_) async => jsonResponse);


      // Assertions...
    });

    flutter_test.test('getReviews', () async {
      // Mock response containing a list of reviews
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

      // Mock the response from the data provider
      when(() => mockReviewsDataProvider.getReviews()).thenAnswer((_) async => jsonResponse);


      // Assertions...
    });

    // Add more test cases for other methods as needed...
    flutter_test.test('addReview', () async {
      // Mock response for a newly added review
      final jsonResponse = jsonEncode({
        'id': 1,
        'userId': 1,
        'gameId': 101,
        'comment': 'Great game!',
        'rating': 5,
      });


      // Mock the response from the data provider
      when(() => mockReviewsDataProvider.addReview(any())).thenAnswer((_) async => jsonResponse);


      // Assertions...
    });

    flutter_test.test('deleteReview', () async {
      const reviewId = 1;

      // Mock the data provider's response for deleting a review
      when(() => mockReviewsDataProvider.deleteReview(reviewId.toString())).thenAnswer((_) async {});

      await reviewsRepository.deleteReview(reviewId);

      // Assertions...
    });

    flutter_test.test('updateReview', () async {
      final updatedReviewData = {
        'id': 1,
        'userId': 1,
        'gameId': 101,
        'comment': 'Updated review',
        'rating': 4,
      };

      // Mock the data provider's response for updating a review
      when(() => mockReviewsDataProvider.updateReview(any(), any())).thenAnswer((_) async => jsonEncode(updatedReviewData));


      // Assertions...
    });
  });
}
