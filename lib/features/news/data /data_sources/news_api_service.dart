import 'dart:io';
import 'package:dio/dio.dart';
import 'package:news_app/core/config/constants/api_constants.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/data%20/models/news_model.dart';


class NewsApiService {
  final Dio dio;

  NewsApiService({required this.dio});

  Future<List<NewsModel>> fetchTopHeadlines({
    String? country,
    String? category,
    String? query,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await dio.get(
        '/top-headlines',
        queryParameters: {
          'apiKey': Constants.newsApiKey,
          if (country != null && country.isNotEmpty) 'country': country,
          if (category != null && category.isNotEmpty) 'category': category,
          if (query != null && query.isNotEmpty) 'q': query,
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: {'User-Agent': 'NewsApp/1.0'},
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          'http_${response.statusCode}',
          'HTTP error ${response.statusCode}: ${response.statusMessage}',
        );
      }

      final data = response.data;

      if (data['status'] == 'error') {
        throw ApiException(
          data['code'] ?? 'unknown_error',
          data['message'] ?? 'Unknown API error',
        );
      }

      if (data['articles'] is List) {
        final articles = (data['articles'] as List)
            .map((json) => NewsModel.fromJson(json))
            .toList();
        return articles;
      } else {
        throw ApiException('invalid_response', 'Articles is not a list');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutFailure();
      }

      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw NoConnectionFailure();
      }

      throw ApiFailure(
        code: 'dio_error',
        message: e.message ?? 'Unknown Dio error',
      );
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
