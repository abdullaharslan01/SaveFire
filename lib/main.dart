import 'package:flutter/material.dart';
import 'package:savefire/data.dart';
import 'package:savefire/home_page.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  
   MainApp({super.key});
  ProjeData data = ProjeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: data.projeTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: HomePage());
  }
}
