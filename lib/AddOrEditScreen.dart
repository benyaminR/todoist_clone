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
      appBar:AppBar(
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(left: 200,right: 200,bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Task",
                    style: new TextStyle(
                    fontSize:18
                    ),
                  ),
                  TextField(
                    style: new TextStyle(
                      fontSize: 50
                    ),
                    decoration: InputDecoration(
                        hintText: "Add a task",
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(175)),
      ),
      body: docID != null ? StreamProvider<Task>.value(value: DB().getTask(docID, firebaseUser.uid),child: AddOrEditBody(_textEditingController),) : AddOrEditBody(_textEditingController),
      floatingActionButton: Builder(builder: (context){
        return Align(
          alignment: Alignment.lerp(Alignment.centerRight, Alignment.topRight, 0.35),
          child: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: Icon(Icons.send),
            onPressed:()=> docID != null ? _edit(context) : _add(context),
          ),
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
    return Padding(
      padding: const EdgeInsets.only(left:130 ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          //project
          ListTile(
            title: Text("Project"),
            subtitle: Text("project"),
            leading: Icon(Icons.assignment),
          ),
          SizedBox(
            height: 8,
          ),
          //due date
          ListTile(
            title: Text("Due date"),
            subtitle: Text("08.10.2023"),
            leading: Icon(Icons.calendar_today),
          ),
          SizedBox(
            height: 8,
          ),
          //priority
          ListTile(
            title: Text("Priority"),
            subtitle: Text("priority 2"),
            leading: Icon(Icons.outlined_flag,),
          ),
        ],
      ),
    );
  }

}