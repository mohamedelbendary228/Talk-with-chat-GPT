import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talk_with_gpt/utils/secrets.dart';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();
  static const int receiveTimeout = 30000;
  static const int connectionTimeout = 30000;

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: connectionTimeout),
    receiveTimeout: const Duration(milliseconds: receiveTimeout),
  ));

  // Headers: --------------------------------------
  Future<Map<String, dynamic>?> getHeaders() async {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $openAIAPIKey"
    };
  }

  //Get: ------------------------------------------
  Future<Response> get(
    String uri,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ) async {
    debugPrint("GET url: $uri");
    Options opts = Options(headers: await getHeaders());
    try {
      final Response response = await _dio.get(
        uri,
        options: options ?? opts,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      debugPrint("$uri ResponseCode: ${response.statusCode}");
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      debugPrint("POST url: $uri, with parameters: $queryParameters");
      Options opts = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIAPIKey"
        },
      );
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: opts,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      debugPrint("$uri ResponseCode: ${response.statusCode}");
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
