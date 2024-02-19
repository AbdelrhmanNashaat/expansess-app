import 'package:flutter/material.dart';

import '../../models/expanses.dart';

class ExpansesItem extends StatelessWidget {
  const ExpansesItem({super.key, required this.expanse});
  final ExpansesModel expanse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expanse.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expanse.amount.toString()}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expanse.category]),
                    const SizedBox(width: 4),
                    Text(
                      expanse.getFormattedDate(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
