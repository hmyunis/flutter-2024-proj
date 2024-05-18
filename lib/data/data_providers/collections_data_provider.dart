import 'dart:convert';

import '../../core/constants.dart';

import 'package:http/http.dart' as http;

class CollectionsDataProvider {
  final String _baseUrl = apiBaseUrl;

  Future getCollections() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/collections"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load collections');
    } catch (e) {
      throw e.toString();
    }
  }

  Future getCollection(String collectionId) async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/collections/$collectionId"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load collection');
    } catch (e) {
      throw e.toString();
    }
  }

  Future getGameIdsByStatus(String userId, GameStatus status) async {
    try {
      final response = await http.get(Uri.parse(
          "$_baseUrl/collections/user/$userId?status=${status.toString().toUpperCase()}"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load games in collection');
    } catch (e) {
      throw e.toString();
    }
  }

  Future addCollection(Map<String, dynamic> collection) async {
    try {
      final response = await http.post(Uri.parse("$_baseUrl/collections/new"),
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(collection));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to create collection item');
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteCollection(String collectionId) async {
    try {
      final response =
          await http.delete(Uri.parse("$_baseUrl/collections/$collectionId"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to delete collection');
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateCollection(
      String collectionId, Map<String, dynamic> collection) async {
    try {
      final response = await http.patch(
          Uri.parse("$_baseUrl/collections/$collectionId"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(collection));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to update collection item');
    } catch (e) {
      throw e.toString();
    }
  }
}

enum GameStatus { pinned, unpinned }
