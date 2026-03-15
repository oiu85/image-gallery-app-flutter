class ImageEntity {
  const ImageEntity({
    required this.id,
    required this.previewURL,
    required this.webformatURL,
    required this.tags,
    required this.user,
    required this.views,
    required this.likes,
    required this.comments,
    required this.downloads,
  });

  final int id;
  final String previewURL;
  final String webformatURL;
  final String tags;
  final String user;
  final int views;
  final int likes;
  final int comments;
  final int downloads;

  List<String> get tagList =>
      tags.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
}
