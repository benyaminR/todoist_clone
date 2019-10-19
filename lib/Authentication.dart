

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoist_clone/AuthenticationUtility.dart';
import 'package:todoist_clone/SignInMethods.dart';

class Authentication extends StatelessWidget{

  final AuthenticationUtility _authenticationUtility = new AuthenticationUtility();

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
              onPressed: ()=> _signIn(context,SignInMethods.Google),
            ),
            RaisedButton(
              child: Text("Anonymous"),
              onPressed: ()=> _signIn(context,SignInMethods.Anonymous),
            )
          ],
        ),
      )
    );
  }

  void _signIn(context,method){
    Future future;
    if(method == SignInMethods.Anonymous){
      future = _authenticationUtility.signInAnonymous();
    }else if(method == SignInMethods.Google){
      future = _authenticationUtility.signInWithGoogle();
    }
    future.then((_)=>Navigator.pushNamed(context, '/main'));
  }
}

