import 'package:good_zza_code_in_songdo/models/month_budget.dart';
import 'package:good_zza_code_in_songdo/models/network_result.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';
import 'package:good_zza_code_in_songdo/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AccountService {
  static AccountService? _instance;
  factory AccountService() => _instance ??= AccountService._();

  AccountService._();

  final String _baseUrl = dotenv.env['apiBaseUrl']!;

  Future<AccountMonthlyBudget?> getAccountForMonth(int year, int month) async {
    NetWorkResult result = await DioClient().get(
        '$_baseUrl/api/v1/account-book/monthly-balence',
        {'year': year, 'month': month});

    if (result.result == Result.success) {
      return AccountMonthlyBudget.fromJson(year, month, result.response);
    } else {
      print(result.response);
      return null;
    }
  }

  Future<void> setBudgetForMonth(int year, int month, int budget) async {
    NetWorkResult result = await DioClient().post(
        '$_baseUrl/api/v1/account-book/monthly-budget',
        {'year': year, 'month': month, 'budget': budget});

    if (result.result == Result.success) {
      // return result.response;
    }
  }

  Future<MonthlyPayoutResponse?> getMonthlyPayout(int year, int month) async {
    NetWorkResult result = await DioClient().get(
        '$_baseUrl/api/v1/account-book/monthly-payout',
        {'year': year, 'month': month});
    if (result.result == Result.success) {
      return MonthlyPayoutResponse.fromJson(result.response);
    } else {
      print(result.response);
      return null;
    }
  }
}
