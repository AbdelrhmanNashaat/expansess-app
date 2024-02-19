import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expanses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(ExpansesModel expansesModel) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;
  final formatter = DateFormat().add_yMd();
  CategoryList category = CategoryList.food;
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'No Date Selected '
                          : formatter.format(selectedDate!),
                    ),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final firstDate =
                            DateTime(now.year - 1, now.month, now.day);
                        final DateTime? pickedTime = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: firstDate,
                            lastDate: now);
                        setState(() {
                          selectedDate = pickedTime;
                        });
                      },
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                  value: category,
                  items: CategoryList.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newVal) {
                    setState(() {
                      if (newVal == null) {
                        return;
                      } else {
                        category = newVal;
                      }
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final double? amount = double.tryParse(amountController.text);
                  final bool amountValidation = amount == null || amount <= 0;
                  if (titleController.text.trim().isEmpty ||
                      amountValidation ||
                      selectedDate == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Invalid Data'),
                        content: const Text(
                            'Look again\nare all fields complete ?\nor you write some thing wrong'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    widget.onAddExpense(
                      ExpansesModel(
                          category: category,
                          title: titleController.text,
                          amount: amount,
                          date: selectedDate!),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Expense'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
