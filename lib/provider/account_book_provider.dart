import 'package:flutter/cupertino.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';

class Account {
  int max;
  int all;

  Account({required this.all, required this.max});
}

enum AccountState { loading, fail, success }

class AccountProvider extends ChangeNotifier {
  DateTime _selectedMonth = DateTime.now();
  DateTime get selectedMonth => _selectedMonth;

  late int _lastDayOfMonth;
  int get lastDayOfMonth => _lastDayOfMonth;

  int _selectedDay = DateTime.now().day;
  int get selectedDay => _selectedDay;

  List<int> get days => _days;
  List<int> _days = <int>[];

  AccountState _state = AccountState.loading;
  AccountState get state => _state;

  late Account _account;
  Account get account => _account;

  List<PaymentItem> paymentItems = <PaymentItem>[
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 9900,
        productName: '넷플릭스',
        date: DateTime(2022, 12, 15, 17, 30),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 10400,
        productName: '올리브영',
        date: DateTime(2022, 12, 15, 19, 55),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        date: DateTime(2022, 12, 15, 13, 32),
        month: 12,
        year: 2022),
  ];

  void setDayList(DateTime date) {
    int diff = date.difference(DateTime(date.year, date.month + 1, 1)).inDays;
    _lastDayOfMonth = date.day - diff;

    _days = [];
    for (int i = 1; i <= _lastDayOfMonth; i++) {
      _days.add(i);
    }
    notifyListeners();
  }

  void getData() async {
    // api 호출 -> 데이터 get
    //_state = ~
    _account = Account(all: 2000, max: 10000);
    _state = AccountState.success;
    notifyListeners();
  }

  void setPlusMonth() {
    _selectedMonth = _selectedMonth.add(Duration(days: lastDayOfMonth));
    setDayList(_selectedMonth);
  }

  void setMinusMonth() {
    _selectedMonth = _selectedMonth.subtract(Duration(days: _lastDayOfMonth));
    setDayList(_selectedMonth);
  }
}
