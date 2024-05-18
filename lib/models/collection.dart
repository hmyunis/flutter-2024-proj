class Collection {
  final int? id;
  final GameStatus status;
  final int gameId;
  final int userId;

  Collection({
    this.id,
    required this.status,
    required this.gameId,
    required this.userId,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
        id: json['id'],
        status: json['status'],
        gameId: json['gameId'],
        userId: json['userId']);
  }

  @override
  String toString() {
    return 'Collection(id: $id, status: $status, gameId: $gameId, userId: $userId)';
  }
}

enum GameStatus { pinned, unpinned }
