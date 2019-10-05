

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoist_clone/SignInMethods.dart';

class Authentication extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todoist"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Log In",textScaleFactor: 5,),
            RaisedButton(
              child: Text("Google"),
              onPressed: ()=> _signIn(SignInMethods.Google),
            ),
            RaisedButton(
              child: Text("Anonymous"),
              onPressed: ()=> _signIn(SignInMethods.Anonymous),
            )
          ],
        ),
      )
    );
  }

  void _signIn(method){

  }
}

