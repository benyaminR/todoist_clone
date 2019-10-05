import 'package:flutter/material.dart';
import 'package:todoist_clone/AddOrEditScreen.dart';
import 'package:todoist_clone/Authentication.dart';
import 'package:todoist_clone/MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/' :(context)=> Authentication(),
        '/main' : (context) => MainScreen(),
        '/main/addOrEdit' : (context) => AddOrEditScreen()
      },
    );
  }
}
