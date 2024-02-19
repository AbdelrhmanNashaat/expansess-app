import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateTime = DateFormat.yMd();
const categoryIcons = {
  CategoryList.food: Icons.lunch_dining,
  CategoryList.travel: Icons.flight_takeoff,
  CategoryList.leisure: Icons.movie,
  CategoryList.work: Icons.work,
};

enum CategoryList { food, travel, leisure, work }

class ExpansesModel {
  final String id;
  final String title;
  final CategoryList category;
  final double amount;
  final DateTime date;
  String getFormattedDate() {
    return dateTime.format(date);
  }

  ExpansesModel(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
}
