import 'package:dartz/dartz.dart';

import '../../../../core/network/network_client.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasource/pixabay_api_service.dart';
import '../models/pixabay_response.dart';

class ImageRepositoryImpl implements ImageRepository {
  const ImageRepositoryImpl(this._apiService);

  final PixabayApiService _apiService;

  @override
  Future<Either<NetworkFailure, PixabayResponse>> searchImages({
    required String query,
    int page = 1,
    int perPage = 20,
  }) {
    return _apiService.searchImages(
      query: query,
      page: page,
      perPage: perPage,
    );
  }
}
