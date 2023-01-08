import 'package:dio/dio.dart';
import 'package:good_zza_code_in_songdo/models/network_result.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal();

  final Dio _dio = Dio();

  Future<NetWorkResult> get(String url, Map<String, dynamic> parameter) async {
    try {
      Response response = await _dio.get(url, queryParameters: parameter);
      if (response.statusCode == 200) {
        return NetWorkResult(result: Result.success, response: response.data);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return NetWorkResult(result: Result.fail, response: e.response);
      } else {
        return NetWorkResult(result: Result.fail, response: e);
      }
    }
  }

  Future<NetWorkResult> post(String url, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        return NetWorkResult(result: Result.success, response: response.data);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return NetWorkResult(result: Result.fail, response: e.response);
      } else {
        return NetWorkResult(result: Result.fail, response: e);
      }
    }
  }
}
