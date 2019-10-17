import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/AddOrEditScreen/AddOrEditScreen.dart';
import 'package:todoist_clone/Authentication.dart';
import 'package:todoist_clone/MainScreen/MainScreen.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/blocs/DrawerBloc.dart';
import 'package:todoist_clone/blocs/EditBloc.dart';
import 'package:todoist_clone/db.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value:FirebaseAuth.instance.onAuthStateChanged),
        ChangeNotifierProvider<DrawerBloc>.value(value: DrawerBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/' :(context)=> Authentication(),
          '/main' : (context) => MainScreen(),
          '/main/addOrEdit' : (context) => ChangeNotifierProvider<EditBloc>.value(
            value: EditBloc(),
            child: AddOrEditScreen(),)
        },
      ),
    );
  }
}
