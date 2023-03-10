import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  // page 업데이트
  setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
