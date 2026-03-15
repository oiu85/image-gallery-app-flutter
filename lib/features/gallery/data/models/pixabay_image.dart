class PixabayImage {
  const PixabayImage({
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

  factory PixabayImage.fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      id: json['id'] as int,
      previewURL: json['previewURL'] as String? ?? '',
      webformatURL: json['webformatURL'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
      user: json['user'] as String? ?? '',
      views: json['views'] as int? ?? 0,
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      downloads: json['downloads'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previewURL': previewURL,
      'webformatURL': webformatURL,
      'tags': tags,
      'user': user,
      'views': views,
      'likes': likes,
      'comments': comments,
      'downloads': downloads,
    };
  }

  List<String> get tagList =>
      tags.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
}
