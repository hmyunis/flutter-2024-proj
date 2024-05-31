import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/collection.dart';

void main() {
  group('Collection', () {
    test('Collection is created with correct values', () {
      const id = 1;
      const status = 'active';
      const gameId = 10;
      const userId = 20;

      final collection =
          Collection(id: id, status: status, gameId: gameId, userId: userId);

      expect(collection.id, equals(id));
      expect(collection.status, equals(status));
      expect(collection.gameId, equals(gameId));
      expect(collection.userId, equals(userId));
    });

    test('Collection is created from JSON correctly', () {
      final json = {
        'id': 1,
        'status': 'active',
        'gameId': 10,
        'userId': 20,
      };

      final collection = Collection.fromJson(json);

      expect(collection.id, equals(json['id']));
      expect(collection.status, equals(json['status']));
      expect(collection.gameId, equals(json['gameId']));
      expect(collection.userId, equals(json['userId']));
    });

    test('toString returns the correct string representation', () {
      const id = 1;
      const status = 'active';
      const gameId = 10;
      const userId = 20;

      final collection =
          Collection(id: id, status: status, gameId: gameId, userId: userId);
      const expectedString =
          'Collection{id: $id, status: $status, gameId: $gameId, userId: $userId}';

      expect(collection.toString(), equals(expectedString));
    });

    test('Collection can be created without id', () {
      const status = 'active';
      const gameId = 10;
      const userId = 20;

      final collection =
          Collection(status: status, gameId: gameId, userId: userId);

      expect(collection.id, isNull);
      expect(collection.status, equals(status));
      expect(collection.gameId, equals(gameId));
      expect(collection.userId, equals(userId));
    });
  });
}
