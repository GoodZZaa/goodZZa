import 'package:flutter/material.dart';

import '../models/month_budget_item.dart';
import '../pages/monthbudget_list.dart';

class BudgetListProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<MonthBudgetItem> _selectedBudgetList = [];
  List<MonthBudgetItem> get selectedBudgetList => _selectedBudgetList;

  setIndex(index) {
    _selectedIndex = index;
    notifyListeners();
  }

  deleteItem(int index) {
    _selectedBudgetList.removeAt(index);
    notifyListeners();
  }

  editItem(int index, MonthBudgetItem item) {
    _selectedBudgetList[index] = item;
    notifyListeners();
  }

  addItem(MonthBudgetItem item) {
    _selectedBudgetList.add(item);
    notifyListeners();
  }
}
