import 'package:eurovision_app/app/features/data/models/lyric_model.dart';
/// The class includes properties such as year, song, artist, country, writers, videoUrls, and lyrics.
class ContestantDetailModel {
  final int id;
  final String country;
  final String artist;
  final String song;
  final List<LyricModel> lyrics;
  final List<String> videoUrls;
  final List<String> writers;
  final int year;

  ContestantDetailModel({
    required this.id,
    required this.country,
    required this.artist,
    required this.song,
    required this.lyrics,
    required this.videoUrls,
    required this.writers,
    required this.year,
  });

  factory ContestantDetailModel.fromJson(Map<String, dynamic> json, int year) {
    return ContestantDetailModel(
      id: json['id'],
      country: json['country'],
      artist: json['artist'],
      song: json['song'],
      lyrics: (json['lyrics'] as List<dynamic>? ?? [])
        .map((e) => LyricModel.fromJson(e))
        .toList(),
      videoUrls: (json['videoUrls'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList(),
      writers: (json['writers'] as List<dynamic>? ?? [])
      .map((e) => e.toString())
      .toList(),
      year: year,
    );
  }
}