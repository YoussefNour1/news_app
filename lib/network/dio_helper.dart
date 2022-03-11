import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
        // v2/everything?q=tesla&from=2022-01-28&sortBy=publishedAt&apiKey=bdc414a1e3bf4a36b75888485be5fd5f
      )
    );
  }
  static Future<Response> getData({required String path, required Map<String, dynamic> queries}) async{
    return await dio!.get(path, queryParameters: queries);
  }
  static Future<Response> searchData({required String path, required Map<String, dynamic> queries}) async{
    return await dio!.get(path, queryParameters: queries);
  }
}