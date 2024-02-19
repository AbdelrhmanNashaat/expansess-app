// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expansess_app/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

import '../models/expanses.dart';
import '../widgets/expanses_list/expanses_list.dart';
import '../widgets/new_expense.dart';

class Expense extends StatefulWidget {
  const Expense({
    Key? key,
  }) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<ExpansesModel> registeredExpanses = [
    ExpansesModel(
      category: CategoryList.work,
      title: 'flutter Course',
      amount: 29.9,
      date: DateTime.now(),
    ),
    ExpansesModel(
      category: CategoryList.food,
      title: 'Cinema',
      amount: 30.9,
      date: DateTime.now(),
    ),
    ExpansesModel(
      category: CategoryList.travel,
      title: 'Travel',
      amount: 20.9,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expanses Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return NewExpense(
                      onAddExpense: addExpense,
                    );
                  });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: registeredExpanses),
          ExpansesList(
              expanses: registeredExpanses, onRemoveExpanse: removeExpense),
        ],
      ),
    );
  }

  void addExpense(ExpansesModel expansesModel) {
    setState(() {
      registeredExpanses.add(expansesModel);
    });
  }

  void removeExpense(ExpansesModel expansesModel) {
    setState(() {
      registeredExpanses.remove(expansesModel);
    });
  }
}

class ExpansesBucket {
  final CategoryList categoryList;
  final List<ExpansesModel> expanses;
  ExpansesBucket({required this.categoryList, required this.expanses});
  ExpansesBucket.forCategory(List<ExpansesModel> allExpanses, this.categoryList)
      : expanses = allExpanses
            .where((element) => element.category == categoryList)
            .toList();
  double getTotal() {
    double sum = 0;
    for (var expanse in expanses) {
      sum += expanse.amount;
    }
    return sum;
  }
}
