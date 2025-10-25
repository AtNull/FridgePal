import 'package:dio/dio.dart';

class ApiService {
  static final _apiService = ApiService._();

  late final Dio _dio;

  ApiService._() {
    _dio = Dio(
      BaseOptions(baseUrl: 'http://192.168.0.23:3000/api/')
    );
  }

  factory ApiService() {
    return _apiService;
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.get(
      endpoint,
      queryParameters: queryParameters
    );

    return response;
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? queryParameters, Object? data}) async {
    Response response = await _dio.get(
      endpoint,
      queryParameters: queryParameters,
      data: data
    );

    return response;
  }

  Future<Response> patch(String endpoint, {Map<String, dynamic>? queryParameters, Object? data}) async {
    Response response = await _dio.delete(
      endpoint,
      queryParameters: queryParameters,
      data: data
    );
    return response;
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.delete(
      endpoint,
      queryParameters: queryParameters,
    );
    return response;
  }
}