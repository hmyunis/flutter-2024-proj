import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/game.dart';

void main() {
  group('Game', () {
    test('Game is created with correct values', () {
      const id = 1;
      const title = 'Test Game';
      const description = 'A test game description';
      const genre = 'Action';
      const platform = 'PC';
      const publisher = 'Test Publisher';
      const releaseDate = '2024-01-01';
      const imageUrl = 'http://example.com/image.jpg';

      final game = Game(
        id: id,
        title: title,
        description: description,
        genre: genre,
        platform: platform,
        publisher: publisher,
        releaseDate: releaseDate,
        imageUrl: imageUrl,
      );

      expect(game.id, equals(id));
      expect(game.title, equals(title));
      expect(game.description, equals(description));
      expect(game.genre, equals(genre));
      expect(game.platform, equals(platform));
      expect(game.publisher, equals(publisher));
      expect(game.releaseDate, equals(releaseDate));
      expect(game.imageUrl, equals(imageUrl));
    });

    test('Game is created from JSON correctly', () {
      final json = {
        'id': 1,
        'title': 'Test Game',
        'description': 'A test game description',
        'genre': 'Action',
        'platform': 'PC',
        'publisher': 'Test Publisher',
        'releaseDate': '2024-01-01',
        'imageUrl': 'http://example.com/image.jpg',
      };

      final game = Game.fromJson(json);

      expect(game.id, equals(json['id']));
      expect(game.title, equals(json['title']));
      expect(game.description, equals(json['description']));
      expect(game.genre, equals(json['genre']));
      expect(game.platform, equals(json['platform']));
      expect(game.publisher, equals(json['publisher']));
      expect(game.releaseDate, equals(json['releaseDate']));
      expect(game.imageUrl, equals(json['imageUrl']));
    });

    test('toString returns the correct string representation', () {
      const id = 1;
      const title = 'Test Game';
      const description = 'A test game description';
      const genre = 'Action';
      const platform = 'PC';
      const publisher = 'Test Publisher';
      const releaseDate = '2024-01-01';
      const imageUrl = 'http://example.com/image.jpg';

      final game = Game(
        id: id,
        title: title,
        description: description,
        genre: genre,
        platform: platform,
        publisher: publisher,
        releaseDate: releaseDate,
        imageUrl: imageUrl,
      );
      const expectedString = 'Game{id: $id, title: $title, description: $description, genre: $genre, platform: $platform, publisher: $publisher, releaseDate: $releaseDate, imageUrl: $imageUrl}';

      expect(game.toString(), equals(expectedString));
    });

    test('Game can be created without id', () {
      const title = 'Test Game';
      const description = 'A test game description';
      const genre = 'Action';
      const platform = 'PC';
      const publisher = 'Test Publisher';
      const releaseDate = '2024-01-01';
      const imageUrl = 'http://example.com/image.jpg';

      final game = Game(
        title: title,
        description: description,
        genre: genre,
        platform: platform,
        publisher: publisher,
        releaseDate: releaseDate,
        imageUrl: imageUrl,
      );

      expect(game.id, isNull);
      expect(game.title, equals(title));
      expect(game.description, equals(description));
      expect(game.genre, equals(genre));
      expect(game.platform, equals(platform));
      expect(game.publisher, equals(publisher));
      expect(game.releaseDate, equals(releaseDate));
      expect(game.imageUrl, equals(imageUrl));
    });
  });
}
