import 'monthbudget_list_model.dart';

class TodoArguments {
  final bool isUpdate;
  final bool isDelete;
  final MonthbudgetList item;
  final int index;

  const TodoArguments(
      {this.isUpdate = false,
      this.isDelete = false,
      required this.index,
      required this.item});
}
