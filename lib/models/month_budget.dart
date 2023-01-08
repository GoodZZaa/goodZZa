class AccountMonthlyBudget {
  int years;
  int months;
  int remainingBalance;
  int totalBalance;

  AccountMonthlyBudget(
      {required this.years,
      required this.months,
      required this.remainingBalance,
      required this.totalBalance});

  factory AccountMonthlyBudget.fromJson(
          int years, int months, Map<String, dynamic> json) =>
      AccountMonthlyBudget(
          years: years,
          months: months,
          remainingBalance: json['remainingBalance'],
          totalBalance: json['totalBalance']);
}
