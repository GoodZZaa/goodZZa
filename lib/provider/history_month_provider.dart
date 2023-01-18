import 'package:flutter/material.dart';

import '../models/month_budget.dart';
import '../models/payments.dart';
import '../service/account_service.dart';
import 'account_book_provider.dart';

class HistoryMonthProvider extends ChangeNotifier {
  final AccountService _accountService = AccountService();

  // account_book_provider에 있는 아래꺼 가져온거
  // enum AccountState { loading, fail, success }

  AccountState _state = AccountState.loading;
  AccountState get state => _state;

  AccountState _budgetState = AccountState.loading;
  AccountState get budgetState => _budgetState;

  AccountState _payoutState = AccountState.loading;
  AccountState get payoutState => _payoutState;

  AccountMonthlyBudget? _accountBudget;
  AccountMonthlyBudget? get accountBudget => _accountBudget;

  List<PayoutItem> _payoutItems = <PayoutItem>[];
  List<PayoutItem> get payoutItems => _payoutItems;

  void getBudgetData(int year, int month) async {
    // async *비동기 뒤에 과정을 기다렸다가 getBudgetData 실행

    var accountResult = await _accountService.getAccountForMonth(year, month);
    //accountService -> dio_client랑 연결 (서버 비밀로 만들어서 연결하는 거 신기!!)
    //서버 api 주소랑 연결된 부분-> "월별 예산" 가져오기

    _budgetState = accountResult['state'];

    if (_budgetState == AccountState.success) {
      _accountBudget = accountResult['data'];
    }

    notifyListeners();
  }

  void getPayoutData(int year, int month) async {
    var payoutResult = await _accountService.getMonthlyPayout(year, month);

    _payoutState = payoutResult['state'];

    if (_payoutState == AccountState.success) {
      _payoutItems = payoutResult['data'].payoutItems;
    }

    notifyListeners();
  }

  // void getData(int year, int month) async {
  //   var accountResult = await _accountService.getAccountForMonth(year, month);
  //   AccountState budgetState = accountResult['state'];

  //   if (budgetState == AccountState.success) {
  //     _accountBudget = accountResult['data'];
  //   }

  //   var payoutResult = await _accountService.getMonthlyPayout(year, month);

  //   AccountState payoutState = payoutResult['state'];

  //   if (payoutState == AccountState.success) {
  //     _payoutItems = payoutResult['data'].payoutItems;
  //   }

  //   if (accountResult == AccountState.success &&
  //       payoutResult == AccountState.success) {
  //     _state = AccountState.success;
  //   }

  //   notifyListeners();
  // }

  // void getPayoutData(int year, int month) async {
  //   var payoutResult = await _accountService.getMonthlyPayout(
  //       year, month);

  //   _payoutState = payoutResult['state'];

  //   if (_payoutState == AccountState.success) {
  //     _payoutItems = payoutResult['data'].payoutItems;
  //   }

  //   notifyListeners();
  // }

}
