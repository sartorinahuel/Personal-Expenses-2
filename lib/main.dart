import 'package:flutter/material.dart';

import 'package:flutter_personal_expenses_2/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses 2',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
