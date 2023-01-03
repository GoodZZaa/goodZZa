import 'package:good_zza_code_in_songdo/models/payments.dart';

class MonthBudgets {
  int years;
  int months;
  int? budget;
  List<PaymentItem>? paymentItem;

  MonthBudgets(
      {required this.years,
      required this.months,
      this.budget,
      this.paymentItem});
}
