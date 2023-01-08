import 'package:flutter/cupertino.dart';
import 'package:good_zza_code_in_songdo/models/month_budget.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';
import 'package:good_zza_code_in_songdo/service/account_service.dart';

enum AccountState { loading, fail, success }

class AccountProvider extends ChangeNotifier {
  final AccountService _accountService = AccountService();
  late DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;

  List<DateTime> get days => _days;
  List<DateTime> _days = <DateTime>[];

  AccountState _state = AccountState.loading;
  AccountState get state => _state;

  late AccountMonthlyBudget? _accountBudget;
  AccountMonthlyBudget? get accountBudget => _accountBudget;

  List<PayoutItem> _payoutItems = <PayoutItem>[];
  List<PayoutItem> get payoutItems => _payoutItems;

  void init() {
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    getData();
    setDayList(_selectedDate);
  }

  void setDayList(DateTime date) {
    // 월별 날짜 수 계산 및 날짜 리스트 생성
    int diff = date.difference(DateTime(date.year, date.month + 1, 1)).inDays;
    int lastDayOfMonth = date.day - diff;
    print(lastDayOfMonth.toString());

    _days = [];
    for (int i = 1; i < lastDayOfMonth; i++) {
      _days.add(DateTime(date.year, date.month, i));
    }
  }

  void getData() async {
    _accountBudget = await _accountService.getAccountForMonth(
        _selectedDate.year, _selectedDate.month);
    if (_accountBudget == null) {
      _state = AccountState.fail;
    } else {
      _state = AccountState.success;
    }

    MonthlyPayoutResponse? response = await _accountService.getMonthlyPayout(
        _selectedDate.year, _selectedDate.month);
    if (response != null) {
      _payoutItems = response.payoutItems;
    }
  }

  void setDay(int day) {
    _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    notifyListeners();
  }

  void setMonthNext() {
    // 다음달
    _selectedDate = _selectedDate.add(Duration(days: _days.length));
    getData();
    setDayList(_selectedDate);
    notifyListeners();
  }

  void setMonthBefore() {
    // 이전달
    _selectedDate = _selectedDate.subtract(Duration(days: _days.length));
    getData();
    setDayList(_selectedDate);
    notifyListeners();
  }
}
