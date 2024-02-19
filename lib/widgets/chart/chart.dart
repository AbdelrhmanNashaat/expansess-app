import 'package:expansess_app/models/expanses.dart';
import 'package:expansess_app/screens/expanse.dart';
import 'package:expansess_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<ExpansesModel> expenses;
  List<ExpansesBucket> get buckets {
    return [
      ExpansesBucket.forCategory(expenses, CategoryList.food),
      ExpansesBucket.forCategory(expenses, CategoryList.leisure),
      ExpansesBucket.forCategory(expenses, CategoryList.travel),
      ExpansesBucket.forCategory(expenses, CategoryList.work),
    ];
  }

  double get maxTotalExpanse {
    double maxTotalExpanse = 0;
    for (var element in buckets) {
      if (element.getTotal() > maxTotalExpanse) {
        maxTotalExpanse = element.getTotal();
      }
    }
    return maxTotalExpanse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final ele in buckets)
                  ChartBar(
                    fill: ele.getTotal() == 0
                        ? 0
                        : ele.getTotal() / maxTotalExpanse,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[e.categoryList],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
