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
  final String docID;

  AddOrEditScreen({this.docID});

  @override
  Widget build(BuildContext context) {
    final FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: docID != null ? Text("Edit") : Text("Add"),
      ),
      body: docID != null ? StreamProvider<Task>.value(value: DB().getTask(docID, firebaseUser.uid),child: AddOrEditBody(_textEditingController),) : AddOrEditBody(_textEditingController),
      floatingActionButton: Builder(builder: (context){
        return FloatingActionButton(
          child: Icon(Icons.send),
          onPressed:()=> docID != null ? _edit(context) : _add(context),
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
          dueDate: '07.08.2019',
          isDone: false
      );
      _db.addTask(task, user.uid).then((_)=>Navigator.pop(context));
    }else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please enter your task...')));
    }
  }

  void _edit(context){
    if(_textEditingController.text.isNotEmpty){
      final user = Provider.of<FirebaseUser>(context);
      Task task = new Task(
          task: _textEditingController.text,
          project: 'project',
          priority: '2',
          dueDate: '07.08.2019',
          docID: docID,
          isDone: false
      );
      _db.editTask(task, user.uid).then((_)=>Navigator.pop(context));
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
    //before assigning any data we need to check whether we have
    //task because this widget works with edit and add
    final Task task = Provider.of<Task>(context);

    if(task != null){
      _textEditingController.text = task.task;
    }

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