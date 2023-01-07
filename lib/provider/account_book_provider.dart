import 'package:flutter/cupertino.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';

class Account {
  int max;
  int all;

  Account({required this.all, required this.max});
}

enum AccountState { loading, fail, success }

class AccountProvider extends ChangeNotifier {
  late DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;

  List<DateTime> get days => _days;
  List<DateTime> _days = <DateTime>[];

  AccountState _state = AccountState.loading;
  AccountState get state => _state;

  late Account _account;
  Account get account => _account;

  // 임시 더미데이터
  List<PaymentItem> paymentItems = <PaymentItem>[
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        market: '7eleven',
        date: DateTime(2022, 12, 15),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 9900,
        productName: '넷플릭스',
        market: '넷플릭스',
        date: DateTime(2022, 12, 15),
        month: 12,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 10400,
        productName: '올리브영',
        market: 'cj',
        date: DateTime(2022, 1, 15),
        month: 1,
        year: 2022),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        market: '7eleven',
        date: DateTime(2023, 1, 15),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 1400,
        productName: '편의점',
        market: '7eleven',
        date: DateTime(2023, 1, 3),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 7200,
        productName: '올리브영',
        market: 'cj',
        date: DateTime(2023, 1, 3),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 12000,
        productName: '마트 장보기',
        market: '하나로마트',
        date: DateTime(2023, 1, 3),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 7200,
        productName: '올리브영',
        market: 'cj',
        date: DateTime(2023, 1, 3),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 12000,
        productName: '마트 장보기',
        market: '하나로마트',
        date: DateTime(2023, 1, 3),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 7200,
        productName: '올리브영',
        market: 'cj',
        date: DateTime(2023, 1, 5),
        month: 1,
        year: 2023),
    PaymentItem(
        amount: 1,
        price: 12000,
        productName: '캠핑 장보기',
        market: '롯데마트',
        date: DateTime(2023, 1, 5),
        month: 1,
        year: 2023),
  ];

  void initDate() {
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
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
    // api 호출 -> 데이터 get
    //_state = ~
    _account = Account(all: 2000, max: 10000);
    _state = AccountState.success;
  }

  void setDay(int day) {
    _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    notifyListeners();
  }

  void setMonthNext() {
    // 다음달
    _selectedDate = _selectedDate.add(Duration(days: _days.length));
    setDayList(_selectedDate);
    notifyListeners();
  }

  void setMonthBefore() {
    // 이전달
    _selectedDate = _selectedDate.subtract(Duration(days: _days.length));
    setDayList(_selectedDate);
    notifyListeners();
  }
}
