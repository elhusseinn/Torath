import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import '../utils/preference_manager.dart';
import '../utils/properties.dart';
import 'network_response.dart';

abstract class INetworkClient {
  Future<NetworkResposne> get(String url,
      {Map<String, dynamic>? headers,
      String? data,
      Map<String, String>? params});
  Future<NetworkResposne> post(String url,
      {Map<String, dynamic>? headers,
      dynamic data,
      Map<String, dynamic> queryParam});
  Future<NetworkResposne> put(
    String url, {
    Map<String, dynamic>? headers,
    dynamic data,
  });
}

//class NetworkClient  implements INetworkClient{
class NetworkClient implements INetworkClient {
  final Dio dio = Dio();

  NetworkClient() {
    PreferenceManager preferenceManager = PreferenceManager();
    BaseOptions options = BaseOptions(
      baseUrl: Properties.baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    );
    dio.options = options;
    if (kDebugMode) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        //client.badCertificateCallback =
        //  (X509Certificate cert, String host, int port) => true;
        SecurityContext context = SecurityContext(withTrustedRoots: true);

        // context.setTrustedCertificatesBytes(
        //   rootCACertificate.buffer.asUint8List());

        //context
        //  .useCertificateChainBytes(clientCertificate.buffer.asUint8List());

        //context.usePrivateKeyBytes(privateKey.buffer.asUint8List());
        HttpClient httpClient = HttpClient(context: context);
        //return httpClient;
        return client;
      };
    }
  }
  NetworkResposne getNetworkResponse(Response response) {
    return NetworkResposne(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<NetworkResposne> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, String>? params,
    String? data,
  }) async {
    try {
      Response response = await dio.get(url,
          options: Options(headers: headers), queryParameters: params);
      //  await dio.get(url, options: Options(headers: headers));
      if (kDebugMode) {
        print("params:$params");
        // print("headers:$headers");
        print("res:$response");
      }
      return getNetworkResponse(response);
    } on DioException catch (e) {
      // loggy.error(e.type);
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw ServerException("");
    }
  }

  @override
  Future<NetworkResposne> post(String url,
      {Map<String, dynamic>? headers,
      dynamic data,
      Map<String, dynamic>? queryParam}) async {
    try {
      PreferenceManager preferenceManager = PreferenceManager();
      dio.options.headers.addAll(headers!);
      final response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        //queryParameters: queryParam,
        data: data,
      );

      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw ServerException("");
    }
    return NetworkResposne();
  }

  @override
  Future<NetworkResposne> put(String url,
      {Map<String, dynamic>? headers, dynamic data}) async {
    try {
      final response = await dio.put(
        url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw ServerException("");
    }
  }
}
