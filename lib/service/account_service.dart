import 'package:good_zza_code_in_songdo/models/month_budget.dart';
import 'package:good_zza_code_in_songdo/models/network_result.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';
import 'package:good_zza_code_in_songdo/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:good_zza_code_in_songdo/provider/account_book_provider.dart';

class AccountService {
  static AccountService? _instance;
  factory AccountService() => _instance ??= AccountService._();

  AccountService._();

  final String _baseUrl = dotenv.env['apiBaseUrl']!;

  Future<Map<String, dynamic>> getAccountForMonth(int year, int month) async {
    NetWorkResult result = await DioClient().get(
        '$_baseUrl/api/v1/account-book/monthly-balance',
        {'year': year, 'month': month});

    print(result.response);

    if (result.result == Result.success) {
      return {
        'state': AccountState.success,
        'data': AccountMonthlyBudget.fromJson(year, month, result.response)
      };
      ;
    } else {
      return {
        'state': AccountState.fail,
      };
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

  Future<Map<String, dynamic>> getMonthlyPayout(int year, int month) async {
    NetWorkResult result = await DioClient().get(
        '$_baseUrl/api/v1/account-book/monthly-payout',
        {'year': year, 'month': month});

    if (result.result == Result.success) {
      print(result.response);
      return {
        'state': AccountState.success,
        'data': MonthlyPayoutResponse.fromJson(result.response['payouts'])
      };
    } else {
      print(result.response);
      return {'state': AccountState.fail};
    }
  }

  Future<void> postPayout(int year, int month, List<String> products, int price,
      String marketName) async {
    NetWorkResult result =
        await DioClient().post('$_baseUrl/api/v1/account-book/monthly-payout', {
      'year': year,
      'month': month,
      'products': products,
      'price': price,
      'marketName': marketName
    });

    if (result.result == Result.success) {
      // return result.response;
    }
  }

  Future<void> postReceiptImg(int year, int month, int day, String img) async {
    NetWorkResult result = await DioClient()
        .post('$_baseUrl/api/v1/account-book/receipt-image', {'img': img});

    if (result.result == Result.success) {
      // return result.response;
    }
  }
}
