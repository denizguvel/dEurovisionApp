/// The class includes properties such as languages, title, and content.
class LyricModel {
  final List<String> languages;
  final String title;
  final String content;

  LyricModel({
    required this.languages,
    required this.title,
    required this.content,
  });

  factory LyricModel.fromJson(Map<String, dynamic> json) {
    return LyricModel(
      languages: List<String>.from(json['languages']),
      title: json['title'],
      content: json['content'],
    );
  }
}