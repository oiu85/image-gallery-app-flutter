import 'pixabay_image.dart';

class PixabayResponse {
  const PixabayResponse({
    required this.totalHits,
    required this.hits,
  });

  final int totalHits;
  final List<PixabayImage> hits;

  factory PixabayResponse.fromJson(Map<String, dynamic> json) {
    final hitsList = (json['hits'] as List<dynamic>?) ?? [];
    return PixabayResponse(
      totalHits: json['totalHits'] as int? ?? 0,
      hits: hitsList
          .map((e) => PixabayImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
