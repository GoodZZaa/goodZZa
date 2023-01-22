import '../models/monthbudget_list_model.dart';

class MonthbudgetListDefault {
  List<MonthbudgetList> dummyMonthBudgetList = [
    MonthbudgetList(id: 1, title: '교통비', description: '버스'),
    MonthbudgetList(id: 2, title: '기타', description: '롯데월드'),
    MonthbudgetList(id: 3, title: '식료품', description: '사과'),
    MonthbudgetList(id: 4, title: '생필품', description: '휴지'),
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
        title: monthbudgetList.title,
        description: monthbudgetList.description);

    dummyMonthBudgetList.add(newMonthbudgetList);
    return newMonthbudgetList;
  }

  void deleteList(int id) {}

  void updateList(MonthbudgetList monthbudgetList) {}
}
