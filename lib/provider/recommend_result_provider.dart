import 'package:flutter/foundation.dart';
import 'package:good_zza_code_in_songdo/models/recommend_result.dart';
import 'package:good_zza_code_in_songdo/service/recommend_result_service.dart';

class RecommendResultProvider extends ChangeNotifier {
  final RecommendResultService _recommendResultService =
      RecommendResultService();

  late RecommendResult _recommendResult =
      RecommendResult(recommendationMarts: List.empty());

  RecommendResult get recommendResult => _recommendResult;

  void fetchRecommendResult() async {
    final recommendResult = await _recommendResultService.getRecommendResult();
    _recommendResult = recommendResult;
    notifyListeners();
  }
}
