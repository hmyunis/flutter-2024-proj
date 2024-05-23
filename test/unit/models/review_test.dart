import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/review.dart';

void main() {
  group('Review', () {
    test('Review is created with correct values', () {
      const id = 1;
      const userId = 'user123';
      const gameId = 'game123';
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2024-01-01T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

    test('Review is created from JSON correctly', () {
      final json = {
        'id': 1,
        'userId': 'user123',
        'gameId': 'game123',
        'comment': 'Great game!',
        'rating': 5,
        'createdAt': '2024-01-01T12:00:00Z',
      };

      final review = Review.fromJson(json);

      expect(review.id, equals(json['id']));
      expect(review.userId, equals(json['userId']));
      expect(review.gameId, equals(json['gameId']));
      expect(review.comment, equals(json['comment']));
      expect(review.rating, equals(json['rating']));
      expect(review.createdAt, equals(json['createdAt']));
    });

    test('toString returns the correct string representation', () {
      const id = 1;
      const userId = 'user123';
      const gameId = 'game123';
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2024-01-01T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );
      final expectedString = 'Review(id: $id, userId: $userId, gameId: $gameId, comment: $comment, rating: $rating, createdAt: $createdAt)';

      expect(review.toString(), equals(expectedString));
    });

    test('Review can be created without id and createdAt', () {
      const userId = 'user123';
      const gameId = 'game123';
      const comment = 'Great game!';
      const rating = 5;

      final review = Review(
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
      );

      expect(review.id, isNull);
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, isNull);
    });
  });
}
