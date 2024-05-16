class Game {
  final String title;
  final String description;
  final String genre;
  final String platform;
  final String publisher;
  final String releaseDate;
  final String imageUrl;

  Game({
    required this.title,
    required this.description,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.releaseDate,
    required this.imageUrl,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      title: json['title'],
      description: json['description'],
      genre: json['genre'],
      platform: json['platform'],
      publisher: json['publisher'],
      releaseDate: json['releaseDate'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'Game{title: $title, description: $description, genre: $genre, platform: $platform, publisher: $publisher, releaseDate: $releaseDate, imageUrl: $imageUrl}';
  }
}
