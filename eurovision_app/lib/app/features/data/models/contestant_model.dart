/// The class includes properties such as year, artist, country, song
class ContestantModel {
  final String artist;
  final String song;
  final String country;
  final int id;
  final int year;

  ContestantModel({
    required this.artist,
    required this.song,
    required this.country,
    required this.id,
    required this.year,
  });

  factory ContestantModel.fromJson(Map<String, dynamic> json, int year) {
    return ContestantModel(
      artist: json['artist'] ?? 'Unknown Singer',
      song: json['song'] ?? 'Unknown Song',
      country: json['country'] ?? 'Unknown Country',
      id: json['id'] ?? 0,
      year: year
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artist': artist,
      'song': song,
      'country': country,
      'id': id,
      'year': year
    };
  }
}