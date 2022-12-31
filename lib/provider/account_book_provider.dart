import 'package:flutter/cupertino.dart';

class Account {
  int max;
  int all;

  Account({required this.all, required this.max});
}

enum AccountState { loading, fail, success }

class AccountProvider extends ChangeNotifier {
  int _selectedMonth = DateTime.now().month;
  int get month => _selectedMonth;

  AccountState _state = AccountState.loading;
  AccountState get state => _state;

  late Account _account;
  Account get account => _account;

  void getData() async {
    // api 호출 -> 데이터 get
    //_state = ~
    _account = Account(all: 2000, max: 10000);
    _state = AccountState.success;
    notifyListeners();
  }

  void setPlusDate() {
    if (_selectedMonth == 12) {
      _selectedMonth = 1;
    } else {
      ++_selectedMonth;
    }
    notifyListeners();
  }

  void setMinusDate() {
    if (_selectedMonth == 1) {
      _selectedMonth = 12;
    } else {
      --_selectedMonth;
    }

    notifyListeners();
  }
}
