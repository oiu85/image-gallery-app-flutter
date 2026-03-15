import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/config/env.dart';
import '../../../../core/network/network_client.dart';
import '../models/pixabay_response.dart';

class PixabayApiService {
  PixabayApiService() : _dio = Dio(_baseOptions) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['key'] = Env.pixabayKey;
          return handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(

          requestHeader: false,
          requestBody: false,
          responseBody: true,
          responseHeader: false,
          compact: true,
          maxWidth: 90,
          enabled: true,
          logPrint: (object) {
            final log = object.toString();
            if (log.length > 800) {
              debugPrint(
                '${log.substring(0, 400)}... [TRUNCATED - ${log.length} chars]',
              );
            } else {
              debugPrint(log);
            }
          },
        ),
      );
    }
  }

  final Dio _dio;

  static final _baseOptions = BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Accept': 'application/json'},
  );

  Future<Either<NetworkFailure, PixabayResponse>> searchImages({
    required String query,
    int page = 1,
    int perPage = ApiConfig.defaultPerPage,
  }) async {
    try {
      final response = await _dio.get(
        '',
        queryParameters: {
          'q': query,
          'page': page,
          'per_page': perPage,
          'image_type': 'photo',
        },
      );

      final data = response.data as Map<String, dynamic>;
      return Right(PixabayResponse.fromJson(data));
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(NetworkFailure(message: 'Unexpected error: $e'));
    }
  }

  NetworkFailure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          message: 'Connection timed out. Please check your internet.',
          errorType: error.type,
        );
      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'No internet connection.',
          errorType: error.type,
        );
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        return NetworkFailure(
          message: 'Server error ($status). Please try again.',
          statusCode: status,
          errorType: error.type,
        );
      default:
        return NetworkFailure(
          message: error.message ?? 'An unknown error occurred.',
          errorType: error.type,
        );
    }
  }
}
