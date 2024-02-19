import 'package:expansess_app/screens/expanse.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Expanses());
}

class Expanses extends StatelessWidget {
  const Expanses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Expense(),
    );
  }
}
