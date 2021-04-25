import 'package:budgetapp/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Budget UI',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Homepage(),
    );
  }
}
