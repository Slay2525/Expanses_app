import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/expanse_data.dart';
import '../models/expense_item.dart';
import '../components/expense_tile.dart';
import '../components/expense_summary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newExpanseDollarController = TextEditingController();
  TextEditingController newExpanseNameController = TextEditingController();
  TextEditingController newExpanseCentsController = TextEditingController();
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
              decoration: const InputDecoration(
                hintText: 'Expense name'
              ),
            ),
            Row(
              children: [
              Expanded(
                  child: TextField(
                    controller: newExpanseDollarController,
                       decoration: const InputDecoration(
                hintText: 'Dollars'
              ),
                  ),
                ),
                SizedBox(width: 4,),
              Expanded(
                  child: TextField(
                    controller: newExpanseCentsController,
                       decoration: const InputDecoration(
                hintText: 'Cents'
              ),
                  ),
                )
              ],
            )
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
    String amount =
        '${newExpanseDollarController.text}.${newExpanseCentsController.text}';

    ExpenseItem newExpense = ExpenseItem(
      name: newExpanseNameController.text,
          amount: double.parse(amount),
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
    newExpanseDollarController.clear();
    newExpanseCentsController.clear();
    newExpanseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, expenseData, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          body: ListView(
            children: [
              ExpenseSummary(
                startOfWeek: expenseData.startOfWeekDate(),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ExpenseTile(
                  name: expenseData.getAllExpenseList()[index].name,
                  amount: expenseData.getAllExpenseList()[index].amount,
                  dateTime: expenseData.getAllExpenseList()[index].dateTime,
                ),
                itemCount: expenseData.getAllExpenseList().length,
              ),
            ],
          )),
    );
  }
}
