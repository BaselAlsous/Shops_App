import 'package:dio/dio.dart';
import 'package:test/Presentaion/Constent/EndPoint/end_point.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    return dio = Dio(
      BaseOptions(
        baseUrl: EndPoint.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response<dynamic>?> getAllData(
      {required String url,
      Map<String, dynamic>? query,
      required dynamic token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? '',
    };
    return await dio?.get(url, queryParameters: query);
  }

  static Future<Response<dynamic>?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    dynamic token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? '',
    };
    return await dio?.post(url, queryParameters: query, data: data);
  }

  static Future<Response<dynamic>?> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    required dynamic token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? '',
    };
    return await dio?.put(url, queryParameters: query, data: data);
  }
}


