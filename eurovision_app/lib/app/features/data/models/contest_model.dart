/// This file contains the ContestModel class, which represents a contest with various attributes.
/// The class includes properties such as year, arena, logo, city, country, intendedCountry,
class ContestModel {
  final int year;
  final String arena;
  final String city;
  final String country;
  final String? intendedCountry;
  final String? slogan;
  final String logoUrl;
  final String url;

  ContestModel({
    required this.year,
    required this.arena,
    required this.city,
    required this.country,
    this.intendedCountry,
    this.slogan,
    required this.logoUrl,
    required this.url,
  });

  factory ContestModel.fromJson(Map<String, dynamic> json) {
    return ContestModel(
      year: json['year'],
      arena: json['arena'],
      city: json['city'],
      country: json['country'],
      intendedCountry: json['intendedCountry'],
      slogan: json['slogan'],
      logoUrl: json['logoUrl'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'arena': arena,
      'city': city,
      'country': country,
      'intendedCountry': intendedCountry,
      'slogan': slogan,
      'logoUrl': logoUrl,
      'url': url,
    };
  }
}
