class PhotoModel {
  final String id;
  final String url;
  final String photographer;
  final String src;

  PhotoModel({required this.id, required this.url, required this.photographer, required this.src});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'].toString(),
      url: json['url'],
      photographer: json['photographer'],
      src: json['src']['large2x'],
    );
  }
}
