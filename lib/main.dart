import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/AddOrEditScreen.dart';
import 'package:todoist_clone/Authentication.dart';
import 'package:todoist_clone/MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value:FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/' :(context)=> Authentication(),
          '/main' : (context) => MainScreen(),
          '/main/addOrEdit' : (context) => AddOrEditScreen()
        },
      ),
    );
  }
}
