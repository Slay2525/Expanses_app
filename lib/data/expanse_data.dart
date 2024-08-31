import 'package:expense_app/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/dataTime/data_time_helper.dart';

class ExpenseData extends ChangeNotifier{
  List<ExpenseItem> overallExpenseList = [];
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
  }

  void deleteExpense(ExpenseItem expenseToDelete) {
    overallExpenseList.remove(expenseToDelete);
    notifyListeners();
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpensesSummary() {
    Map<String, double> dailyExpensesSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = expense.amount;
      if(dailyExpensesSummary.containsKey(date)){
        double currentAmount = dailyExpensesSummary[date]!;
        currentAmount += amount;
        dailyExpensesSummary[date] = currentAmount;
      }else{
        dailyExpensesSummary[date] = amount;
      }
    }
    return dailyExpensesSummary;
  }
}
