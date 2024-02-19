import 'package:expansess_app/widgets/expanses_list/expanses_item.dart';
import 'package:flutter/material.dart';

import '../../models/expanses.dart';

class ExpansesList extends StatelessWidget {
  const ExpansesList(
      {super.key, required this.expanses, required this.onRemoveExpanse});
  final void Function(ExpansesModel expansesModel) onRemoveExpanse;
  final List<ExpansesModel> expanses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(
              expanses[index],
            ),
            child: ExpansesItem(
              expanse: expanses[index],
            ),
            onDismissed: (direction) => onRemoveExpanse(expanses[index]),
          );
        },
        itemCount: expanses.length,
      ),
    );
  }
}
