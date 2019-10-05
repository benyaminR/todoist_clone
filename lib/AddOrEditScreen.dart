import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/db.dart';

class AddOrEditScreen extends StatelessWidget{
  final TextEditingController _textEditingController = new TextEditingController();
  final DB _db = new DB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddOrEdit"),
      ),
      body: AddOrEditBody(_textEditingController),
      floatingActionButton: Builder(builder: (context){
        return FloatingActionButton(
          child: Icon(Icons.send),
          onPressed:()=>_add(context),
        );
      })
    );
  }

  void _add(context){
    if(_textEditingController.text.isNotEmpty){
      final user = Provider.of<FirebaseUser>(context);
      Task task = new Task(
          task: _textEditingController.text,
          project: 'project',
          priority: '2',
          dueDate: '07.08.2019'
      );
      _db.addTask(task, user.uid).then((_)=>Navigator.pop(context));
    }else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please enter your task...')));
    }
  }

}

class AddOrEditBody extends StatelessWidget{
  final TextEditingController _textEditingController;
  AddOrEditBody(this._textEditingController);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Enter your task...'
          ),
        )
      ],
    );
  }

}