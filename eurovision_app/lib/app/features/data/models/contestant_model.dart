class ContestantModel {
  final String artist;
  final String song;
  final String country;
  //final String flagUrl;
  final int id;
  final int year;

  ContestantModel({
    required this.artist,
    required this.song,
    required this.country,
    //required this.flagUrl,
    required this.id,
    required this.year,
  });

  factory ContestantModel.fromJson(Map<String, dynamic> json, int year) {
    return ContestantModel(
      artist: json['artist'] ?? 'Unknown Singer',
      song: json['song'] ?? 'Unknown Song',
      country: json['country'] ?? 'Unknown Country',
      //flagUrl: json['flagUrl'] ?? '',
      id: json['id'] ?? 0,
      year: year
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artist': artist,
      'song': song,
      'country': country,
      //'flagUrl': flagUrl,
      'id': id,
      'year': year
    };
  }
}
