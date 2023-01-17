import 'package:flutter/material.dart';

import '../models/month_budget.dart';
import '../models/payments.dart';
import '../service/account_service.dart';
import 'account_book_provider.dart';

class HistoryMonthProvider extends ChangeNotifier {
  final AccountService _accountService = AccountService();

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
    var accountResult = await _accountService.getAccountForMonth(year, month);
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
