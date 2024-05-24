import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/review_temp.dart';

void main() {
  group('ReviewTemp', () {
    test('ReviewTemp is created with correct values', () {
      const username = 'testUser';
      const gameTitle = 'Test Game';
      const date = '2024-01-01';
      const comment = 'This is a test comment.';
      const rating = 5;

      final review = ReviewTemp(
        username: username,
        gameTitle: gameTitle,
        date: date,
        comment: comment,
        rating: rating,
      );

      expect(review.username, equals(username));
      expect(review.gameTitle, equals(gameTitle));
      expect(review.date, equals(date));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
    });

    test('ReviewTemp rating is within valid range', () {
      const username = 'testUser';
      const gameTitle = 'Test Game';
      const date = '2024-01-01';
      const comment = 'This is a test comment.';
      const rating = 5;

      final review = ReviewTemp(
        username: username,
        gameTitle: gameTitle,
        date: date,
        comment: comment,
        rating: rating,
      );

      expect(review.rating, inInclusiveRange(1, 5));
    });
  });
}
