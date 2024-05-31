import 'dart:convert';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/repositories/collections_repository.dart';
import 'package:video_game_catalogue_app/data/data_providers/collections_data_provider.dart';
import 'package:video_game_catalogue_app/models/collection.dart';
import '../../test_helper.dart';

class MockCollectionsDataProvider extends Mock
    implements CollectionsDataProvider {}

void main() {
  late CollectionsRepository collectionsRepository;
  late MockCollectionsDataProvider mockCollectionsDataProvider;

  flutter_test.setUp(() {
    mockCollectionsDataProvider = MockCollectionsDataProvider();
    collectionsRepository = CollectionsRepository(mockCollectionsDataProvider);
  });

  flutter_test.group('CollectionsRepository', () {
    flutter_test.test('getCollection - success', () async {
      const collectionId = 1;
      final jsonResponse =
          jsonEncode({'userId': 1, 'status': 'completed', 'gameId': 101});
      final expectedCollection =
          Collection(userId: 1, status: 'completed', gameId: 101);

      when(() => mockCollectionsDataProvider.getCollection(
          collectionId.toString())).thenAnswer((_) async => jsonResponse);

      final result = await collectionsRepository.getCollection(collectionId);

      flutter_test.expect(result, equalsCollection(expectedCollection));
      verify(() => mockCollectionsDataProvider
          .getCollection(collectionId.toString())).called(1);
    });

    flutter_test.test('getGameIdsByStatus - success', () async {
      const userId = 1;
      const status = 'playing';
      final jsonResponse = jsonEncode([101, 102]);
      final expectedGameIds = [101, 102];

      when(() => mockCollectionsDataProvider.getGameIdsByStatus(
          userId.toString(), status)).thenAnswer((_) async => jsonResponse);

      final result =
          await collectionsRepository.getGameIdsByStatus(userId, status);

      flutter_test.expect(result, expectedGameIds);
      verify(() => mockCollectionsDataProvider.getGameIdsByStatus(
          userId.toString(), status)).called(1);
    });

    flutter_test.test('addCollection - success', () async {
      final collection =
          Collection(userId: 1, status: 'completed', gameId: 101);
      final jsonResponse =
          jsonEncode({'userId': 1, 'status': 'completed', 'gameId': 101});
      final expectedCollection =
          Collection(userId: 1, status: 'completed', gameId: 101);

      when(() => mockCollectionsDataProvider.addCollection({
            'userId': collection.userId,
            'status': collection.status,
            'gameId': collection.gameId,
          })).thenAnswer((_) async => jsonResponse);

      final result = await collectionsRepository.addCollection(collection);

      flutter_test.expect(result, equalsCollection(expectedCollection));
      verify(() => mockCollectionsDataProvider.addCollection({
            'userId': collection.userId,
            'status': collection.status,
            'gameId': collection.gameId,
          })).called(1);
    });

    flutter_test.test('deleteCollection', () async {
      const collectionId = 1;

      when(() =>
          mockCollectionsDataProvider
              .deleteCollection(collectionId.toString())).thenAnswer(
          (_) => Future<void>.value()); // Corrected to return a Future<void>

      await collectionsRepository.deleteCollection(collectionId);

      verify(() => mockCollectionsDataProvider
          .deleteCollection(collectionId.toString())).called(1);
    });

    flutter_test.test('updateCollection - success', () async {
      const collectionId = 1;
      final collection =
          Collection(userId: 1, status: 'completed', gameId: 101);
      final jsonResponse =
          jsonEncode({'userId': 1, 'status': 'completed', 'gameId': 101});
      final expectedCollection =
          Collection(userId: 1, status: 'completed', gameId: 101);

      when(() => mockCollectionsDataProvider
              .updateCollection(collectionId.toString(), {
            'userId': collection.userId,
            'status': collection.status,
            'gameId': collection.gameId,
          })).thenAnswer((_) async => jsonResponse);

      final result = await collectionsRepository.updateCollection(
          collectionId, collection);

      flutter_test.expect(result, equalsCollection(expectedCollection));
      verify(() => mockCollectionsDataProvider
              .updateCollection(collectionId.toString(), {
            'userId': collection.userId,
            'status': collection.status,
            'gameId': collection.gameId,
          })).called(1);
    });
  });
}
