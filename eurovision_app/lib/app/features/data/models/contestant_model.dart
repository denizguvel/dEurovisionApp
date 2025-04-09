class ContestantModel {
  final String artist;
  final String song;
  final String country;
  //final String flagUrl;
  final int rank;

  ContestantModel({
    required this.artist,
    required this.song,
    required this.country,
    //required this.flagUrl,
    required this.rank,
  });

  factory ContestantModel.fromJson(Map<String, dynamic> json) {
    return ContestantModel(
      artist: json['artist'] ?? 'Unknown Singer',
      song: json['song'] ?? 'Unknown Song',
      country: json['country'] ?? 'Unknown Country',
      //flagUrl: json['flagUrl'] ?? '',
      rank: json['rank'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artist': artist,
      'song': song,
      'country': country,
      //'flagUrl': flagUrl,
      'rank': rank,
    };
  }
}
