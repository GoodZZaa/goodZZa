import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  int _test = 2;

  int get test => _test;

  // page 업데이트
  setTest(int value) {
    _test = value;
    notifyListeners();
  }
}
