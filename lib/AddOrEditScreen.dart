import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/db.dart';

class AddOrEditScreen extends StatelessWidget{
  final String docID;

  AddOrEditScreen({this.docID});
  @override
  Widget build(BuildContext context) {
    final FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    return docID != null ? StreamProvider<Task>.value(
      value: DB().getTask(docID, firebaseUser.uid),
      child: AddOrEditContent(isEdit: true,),
    ):
    AddOrEditContent(isEdit: false,);
  }

}

class AddOrEditContent extends StatelessWidget{
  final bool isEdit;
  final TextEditingController _textEditingController = new TextEditingController();
  final DB _db = new DB();

  AddOrEditContent({this.isEdit});

  @override
  Widget build(BuildContext context) {

    final Task task = isEdit ? Provider.of<Task>(context) : Task.fromSnapshot(null);

    return Scaffold(
        resizeToAvoidBottomInset:false,
        appBar : AddOrEditAppBar(task:task,textEditingController: _textEditingController,),
        body: AddOrEditBody(task:task),
        floatingActionButton: Builder(builder: (context){
          return Align(
            alignment: Alignment.lerp(Alignment.centerRight, Alignment.topRight, 0.35),
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              child: Icon(Icons.send),
              onPressed:()=> isEdit ? _edit(context,task.docID) : _add(context),
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

  void _edit(context,docID){
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


class AddOrEditAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Task task;
  final TextEditingController textEditingController;
  AddOrEditAppBar({this.task, this.textEditingController});
  @override
  Widget build(BuildContext context) {
    //assign text
    textEditingController.text = task.task;

    return AppBar(
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
                  controller: textEditingController,
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
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(230);

}

class AddOrEditBody extends StatelessWidget{
  final bool isEdit;
  final Task task;
  AddOrEditBody({this.isEdit,this.task});

  @override
  Widget build(BuildContext context) {
    //before assigning any data we need to check whether we have
    //task because this widget works with edit and add
    //fromSnapshot returns a task with default values if there is no snapshot specified
    return Padding(
      padding: const EdgeInsets.only(left:130),
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