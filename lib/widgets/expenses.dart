import 'package:flutter/material.dart';
import 'package:harcamalar/data/expense.dart';
import 'package:harcamalar/main.dart';
import 'package:harcamalar/widgets/expenses_list/expenses_list.dart';
import 'package:harcamalar/widgets/new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 24.55,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 44.66,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void _appBarAc() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpenses(onAddexpenses: _harcamaEkle),
    );
  }

  void _harcamaEkle(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted Expense'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No expense detected, Please add'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpenses: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _appBarAc,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
