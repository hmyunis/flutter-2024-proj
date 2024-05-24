import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/repositories/collections_repository.dart';
import 'package:video_game_catalogue_app/data/data_providers/collections_data_provider.dart';
import 'package:video_game_catalogue_app/models/collection.dart';
import 'dart:convert';

class MockCollectionsDataProvider extends Mock implements CollectionsDataProvider {}

void main() {
  group('CollectionsRepository', () {
    late MockCollectionsDataProvider mockCollectionsDataProvider;
    late CollectionsRepository collectionsRepository;

    setUp(() {
      mockCollectionsDataProvider = MockCollectionsDataProvider();
      collectionsRepository = CollectionsRepository(mockCollectionsDataProvider);
    });

    group('getCollections', () {
      test('should return a list of collections', () async {
        // Arrange
        final mockResponse = '[{"id": 1, "status": "wishlist", "gameId": 123, "userId": 456}]';
        when(() => mockCollectionsDataProvider.getCollections())
            .thenAnswer((_) async => mockResponse);

        // Act
        final collections = await collectionsRepository.getCollections();

        // Assert
        expect(collections, isA<List<Collection>>());
        expect(collections.length, 1);
        expect(collections[0].id, 1);
        expect(collections[0].status, 'wishlist');
        expect(collections[0].gameId, 123);
        expect(collections[0].userId, 456);
      });
    });

    group('getCollection', () {
      test('should return a collection', () async {
        // Arrange
        final mockResponse = '{"id": 1, "status": "wishlist", "gameId": 123, "userId": 456}';
        when(() => mockCollectionsDataProvider.getCollection('1'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final collection = await collectionsRepository.getCollection(1);

        // Assert
        expect(collection, isA<Collection>());
        expect(collection.id, 1);
        expect(collection.status, 'wishlist');
        expect(collection.gameId, 123);
        expect(collection.userId, 456);
      });
    });

    group('getGameIdsByStatus', () {
      test('should return a list of game IDs', () async {
        // Arrange
        final mockResponse = '[123, 456]';
        when(() => mockCollectionsDataProvider.getGameIdsByStatus('1', 'wishlist'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final gameIds = await collectionsRepository.getGameIdsByStatus(1, 'wishlist');

        // Assert
        expect(gameIds, isA<List<int>>());
        expect(gameIds.length, 2);
        expect(gameIds, contains(123));
        expect(gameIds, contains(456));
      });
    });

    group('addCollection', () {
      test('should return a new collection', () async {
        // Arrange
        final mockResponse = '{"id": 1, "status": "wishlist", "gameId": 123, "userId": 456}';
        when(() => mockCollectionsDataProvider.addCollection({'userId': 456, 'status': 'wishlist', 'gameId': 123}))
            .thenAnswer((_) async => mockResponse);
        final collection = Collection(userId: 456, status: 'wishlist', gameId: 123);

        // Act
        final newCollection = await collectionsRepository.addCollection(collection);

        // Assert
        expect(newCollection, isA<Collection>());
        expect(newCollection.id, 1);
        expect(newCollection.status, 'wishlist');
        expect(newCollection.gameId, 123);
        expect(newCollection.userId, 456);
      });
    });

    group('deleteCollection', () {
      test('should call the data provider to delete a collection', () async {
        // Arrange
        when(() => mockCollectionsDataProvider.deleteCollection('1')).thenAnswer((_) async {});

        // Act
        await collectionsRepository.deleteCollection(1);

        // Assert
        verify(() => mockCollectionsDataProvider.deleteCollection('1')).called(1);
      });
    });

    group('updateCollection', () {
      test('should return an updated collection', () async {
        // Arrange
        final mockResponse = '{"id": 1, "status": "playing", "gameId": 123, "userId": 456}';
        when(() => mockCollectionsDataProvider.updateCollection('1', {'userId': 456, 'status': 'playing', 'gameId': 123}))
            .thenAnswer((_) async => mockResponse);
        final collection = Collection(userId: 456, status: 'playing', gameId: 123);

        // Act
        final updatedCollection = await collectionsRepository.updateCollection(1, collection);

        // Assert
        expect(updatedCollection, isA<Collection>());
        expect(updatedCollection.id, 1);
        expect(updatedCollection.status, 'playing');
        expect(updatedCollection.gameId, 123);
        expect(updatedCollection.userId, 456);
      });
    });
  });
}