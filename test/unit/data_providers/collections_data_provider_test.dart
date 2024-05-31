import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/data/data_providers/collections_data_provider.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        Uri.parse('http://example.com')); // Register fallback value
  });

  group('CollectionsDataProvider', () {
    late CollectionsDataProvider collectionsDataProvider;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      collectionsDataProvider = CollectionsDataProvider();
      collectionsDataProvider.client = mockHttpClient;
    });

    tearDown(() {
      collectionsDataProvider.dispose();
    });

    group('getCollections', () {
      test('returns decoded JSON data on successful response', () async {
        // Arrange
        const mockResponse = '''
        {
          "collections": [
            { "id": "1", "name": "Collection 1" },
            { "id": "2", "name": "Collection 2" }
          ]
        }
        ''';
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await collectionsDataProvider.getCollections(flag: 2);

        // Assert
        expect(result, isA<List<dynamic>>());
        expect(result[0]['id'], '1');
        expect(result[0]['name'], 'Collection 1');
      });

      test('throws exception on non-200 status code', () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('', 400));

        // Act & Assert
        expect(
            () async => await collectionsDataProvider.getCollections(flag: 1),
            throwsException);
      });
    });

    group('getCollection', () {
      test('returns decoded JSON data on successful response', () async {
        // Arrange
        const mockResponse = '''
        {
          "id": "1",
          "name": "Collection 1"
        }
        ''';
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result =
            await collectionsDataProvider.getCollection('1', flag: 1);

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], '1');
        expect(result['name'], 'Collection 1');
      });

      test('throws exception on non-200 status code', () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('', 400));

        // Act & Assert
        expect(
            () async =>
                await collectionsDataProvider.getCollection('1', flag: 2),
            throwsException);
      });
    });

    group('getGameIdsByStatus', () {
      test('returns decoded JSON data on successful response', () async {
        // Arrange
        const mockResponse = '''
        {
          "gameIds": [
            "1",
            "2"
          ]
        }
        ''';
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await collectionsDataProvider
            .getGameIdsByStatus('1', 'owned', flag: 1);

        // Assert
        expect(result, isA<List<dynamic>>());
        expect(result, ['1', '2']);
      });

      test('throws exception on non-200 status code', () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('', 400));

        // Act & Assert
        expect(
            () async => await collectionsDataProvider
                .getGameIdsByStatus('1', 'owned', flag: 2),
            throwsException);
      });
    });

    group('addCollection', () {
      test('returns decoded JSON data on successful response', () async {
        // Arrange
        const mockResponse = '''
        {
          "id": "3",
          "name": "New Collection"
        }
        ''';
        when(() => mockHttpClient.post(any(),
                headers: any(named: 'headers'), body: any(named: 'body')))
            .thenAnswer((_) async => http.Response(mockResponse, 201));

        // Act
        final result = await collectionsDataProvider
            .addCollection({'name': 'New Collection'}, flag: 1);

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], '3');
        expect(result['name'], 'New Collection');
      });

      test('throws exception on non-200/201 status code', () async {
        // Arrange
        when(() => mockHttpClient.post(any(),
                headers: any(named: 'headers'), body: any(named: 'body')))
            .thenAnswer((_) async => http.Response('', 400));

        // Act & Assert
        expect(
            () async =>
                await collectionsDataProvider.addCollection({}, flag: 2),
            throwsException);
      });
    });

    group('deleteCollection', () {
      test('returns true on successful response', () async {
        // Arrange
        when(() => mockHttpClient.delete(any()))
            .thenAnswer((_) async => http.Response('', 204));

        // Act
        final result =
            await collectionsDataProvider.deleteCollection('1', flag: 1);

        // Assert
        expect(result, isTrue);
      });

      test('throws exception on non-204 status code', () async {
        // Arrange
        when(() => mockHttpClient.delete(any()))
            .thenAnswer((_) async => http.Response('', 400));

        // Act & Assert
        expect(
            () async =>
                await collectionsDataProvider.deleteCollection('1', flag: 2),
            throwsException);
      });
    });

    group('updateCollection', () {
      test('returns decoded JSON data on successful response', () async {
        // Arrange
        const mockResponse = '''
        {
          "id": "1",
          "name": "Updated Collection"
        }
        ''';
        when(() => mockHttpClient.put(any(),
                headers: any(named: 'headers'), body: any(named: 'body')))
            .thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await collectionsDataProvider
            .updateCollection('1', {'name': 'Updated Collection'}, flag: 1);

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], '1');
        expect(result['name'], 'Updated Collection');
      });

      test('throws exception on non-200 status code', () async {
        // Arrange
        when(() => mockHttpClient.put(any(),
                headers: any(named: 'headers'), body: any(named: 'body')))
            .thenAnswer((_) async => http.Response('', 400));

        // Act & Assert
        expect(
            () async => await collectionsDataProvider.updateCollection('1', {},
                flag: 2),
            throwsException);
      });

      test('throws exception on network error', () async {
        // Arrange
        when(() =>
            mockHttpClient.put(any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'))).thenThrow(
            const SocketException('The semaphore timeout period has expired'));

        // Act & Assert
        expect(
            () async => await collectionsDataProvider.updateCollection('1', {},
                flag: 3),
            throwsA(isA<SocketException>()));
      });
    });
  });
}
