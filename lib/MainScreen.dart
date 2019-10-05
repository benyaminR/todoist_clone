import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Todoist"),
      ),
      body: Text("Main Screen"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:()=> _add(context),
      ),
    );
  }

  void _add(context){
      Navigator.pushNamed(context, '/main/addOrEdit');
  }
}