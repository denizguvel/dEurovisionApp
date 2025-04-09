class CatImageModel {
  final String id;
  final String url;
  final int width;
  final int height;

  CatImageModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatImageModel.fromMap(Map<String, dynamic> map) {
  return CatImageModel(
    id: map['id'] ?? '',  // Eğer 'id' boşsa, boş bir string döndür
    url: map['url'] ?? '',  // Eğer 'url' boşsa, boş bir string döndür
    width: map['width'] ?? 0,  // Eğer 'width' boşsa, 0 döndür
    height: map['height'] ?? 0,  // Eğer 'height' boşsa, 0 döndür
  );
}
}