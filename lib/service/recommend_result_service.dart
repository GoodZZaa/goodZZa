import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:good_zza_code_in_songdo/models/network_result.dart';
import 'package:good_zza_code_in_songdo/models/recommend_mart.dart';
import 'package:good_zza_code_in_songdo/models/recommend_result.dart';
import 'package:good_zza_code_in_songdo/network/dio_client.dart';

class RecommendResultService {
  static RecommendResultService? _instance;

  factory RecommendResultService() => _instance ??= RecommendResultService._();

  RecommendResultService._();

  final String _baseUrl = dotenv.env['apiBaseUrl']!;

  Future<RecommendResult> getRecommendResult() async {
    NetWorkResult result =
        await DioClient().post('$_baseUrl/api/v1/checkout/recommendation', {});

    if (result.result == Result.success) {
      var marts = (result.response['recommendationMarts'] as List<dynamic>)
          .map((e) => RecommendMart.fromMap(e))
          .toList();

      return RecommendResult(recommendationMarts: marts);
    }
    return RecommendResult(recommendationMarts: List<RecommendMart>.empty());
  }
}
