import '../models/monthbudget_list_model.dart';

class MonthbudgetListDefault {
  List<MonthbudgetList> dummyMonthBudgetList = [
    MonthbudgetList(id: 1, price: '1000', category: '교통비'),
    MonthbudgetList(id: 2, price: '2000', category: '기타'),
    MonthbudgetList(id: 3, price: '3000', category: '식료품'),
    MonthbudgetList(id: 4, price: '4000', category: '생필품'),
  ];

  List<MonthbudgetList> getmonthbudgetList() {
    return dummyMonthBudgetList;
  }

  MonthbudgetList getmonthbudget(int id) {
    return dummyMonthBudgetList[id];
  }

  MonthbudgetList addMonthbudgetList(MonthbudgetList monthbudgetList) {
    MonthbudgetList newMonthbudgetList = MonthbudgetList(
        id: dummyMonthBudgetList.length + 1,
        price: monthbudgetList.price,
        category: monthbudgetList.category);

    dummyMonthBudgetList.add(newMonthbudgetList);
    return newMonthbudgetList;
  }

  void deleteList(int id) {}

  void updateList(MonthbudgetList monthbudgetList) {}
}
