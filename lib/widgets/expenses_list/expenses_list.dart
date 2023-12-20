import 'package:flutter/material.dart';
import 'package:harcamalar/data/expense.dart';
import 'package:harcamalar/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpenses});
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) => removeExpenses(expenses[index]),
        key: ValueKey(expenses[index]),
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
