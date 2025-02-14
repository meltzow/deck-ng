import 'package:deck_ng/service/impl/retry.dart';
import 'package:dio/dio.dart';

abstract class HttpService {
  Future<Map<String, dynamic>> get(String path);
  Future<List<dynamic>> getListResponse(String path);

  Future<Map<String, dynamic>> post(String path,
      [dynamic body, bool useAccount]);

  Future<T> put<T>(String path, dynamic body);

  Future<Response<T>> retry<T>(RequestOptions? ops,
      [RetryOptions? retryOptions]);
}
