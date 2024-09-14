import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_app/models/expense_item.dart';

class HiveDatabase {
  final _myBox = Hive.box('expense_database');
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFomatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFomatted);
    }
    _myBox.put('All_EXPENSES', allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      double amount = double.parse(savedExpenses[i][1]);
      DateTime dateTime = savedExpenses[i][2];
      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
