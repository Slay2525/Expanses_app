import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/expanse_data.dart';
import '../models/expense_item.dart';
import '../components/expense_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newExpanseAmountController = TextEditingController();
  TextEditingController newExpanseNameController = TextEditingController();
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpanseNameController,
            ),
            TextField(controller: newExpanseAmountController)
          ],
        ),
        actions: [
          MaterialButton(onPressed: save, child: Text('Save')),
          MaterialButton(onPressed: cancel, child: Text('Cancel'))
        ],
      ),
    );
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpanseNameController.text,
      amount:
          double.parse(newExpanseAmountController.text), //Without double.parse
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpanseAmountController.clear();
    newExpanseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, expenseData, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => ExpenseTile(
            name: expenseData.getAllExpenseList()[index].name,
            amount: expenseData.getAllExpenseList()[index].amount,
            dateTime: expenseData.getAllExpenseList()[index].dateTime,
          ),
          itemCount: expenseData.getAllExpenseList().length,
        ),
      ),
    );
  }
}
