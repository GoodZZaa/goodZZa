import 'package:good_zza_code_in_songdo/pages/monthbudget_list.dart';

class MonthbudgetList {
  late int? id;
  late String price;
  late String category;

  MonthbudgetList({this.id, required this.price, required this.category});

  /*late String title;
  late String content;
  late bool isDone;*/

  // TodoModel({this.title = "", this.content = "", this.isDone = false});
}

class SaveMonthbudgetList {
  List<MonthbudgetList> saveMonthbudgetList = [];

  MonthbudgetList getMonthbudget(int id) {
    return saveMonthbudgetList[id];
  }

  List<MonthbudgetList> getmonthbudgetList() {
    return saveMonthbudgetList;
  }

  MonthbudgetList addMonthbudgetList(MonthbudgetList monthbudgetList) {
    MonthbudgetList newMonthbudgetList = MonthbudgetList(
        id: saveMonthbudgetList.length + 1,
        price: monthbudgetList.price,
        category: monthbudgetList.category);

    saveMonthbudgetList.add(newMonthbudgetList);
    return newMonthbudgetList;
  }

  void updateMonthbudgetList(MonthbudgetList monthbudgetList) {
    for (int i = 0; i < saveMonthbudgetList.length; i++) {
      if (saveMonthbudgetList[i].id == monthbudgetList.id) {
        saveMonthbudgetList[i] = monthbudgetList;
      }
    }
  }

  void deleteMonthbudgetList(int id) {
    for(int i =0; i<saveMonthbudgetList.length; i++){
      if(saveMonthbudgetList[i].id == id){
        saveMonthbudgetList.removeAt(i);
      }
    }
  }




}
