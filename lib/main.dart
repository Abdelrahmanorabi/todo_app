import 'package:flutter/material.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/my_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      initialRoute:HomeScreen.routeName ,
      routes: {
        HomeScreen.routeName:(_)=>HomeScreen(),
      },
    );
  }
}
