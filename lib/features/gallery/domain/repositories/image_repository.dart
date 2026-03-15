import 'package:dartz/dartz.dart';

import '../../../../core/network/network_client.dart';
import '../../data/models/pixabay_response.dart';

abstract class ImageRepository {
  Future<Either<NetworkFailure, PixabayResponse>> searchImages({
    required String query,
    int page = 1,
    int perPage = 20,
  });
}
