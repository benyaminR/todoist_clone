import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/blocs/EditBloc.dart';
import 'package:todoist_clone/db.dart';

import 'AddOrEditAppBar.dart';
import 'AddOrEditBody.dart';

class AddOrEditScreen extends StatelessWidget{

  final String docID;
  AddOrEditScreen({this.docID});

  @override
  Widget build(BuildContext context) {

    final FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    return docID != null ? StreamProvider<Task>.value(
        value: DB().getTask(docID, firebaseUser.uid),
        child: AddOrEditContent(true),
      ):
      AddOrEditContent(false);
  }
}

class AddOrEditContent extends StatelessWidget{
  final bool isEdit;
  final TextEditingController _textEditingController = new TextEditingController();
  final DB _db = new DB();
  AddOrEditContent(this.isEdit);
  @override
  Widget build(BuildContext context) {
    final editBloc = Provider.of<EditBloc>(context);
    _mapValues(editBloc, context);
    return Scaffold(
           resizeToAvoidBottomInset:false,
           appBar : AddOrEditAppBar(textEditingController: _textEditingController,),
           body: AddOrEditBody(),
           floatingActionButton: Builder(builder: (context){
             return Align(
               alignment: Alignment.lerp(Alignment.centerRight, Alignment.topRight, 0.35),
               child: FloatingActionButton(
                 backgroundColor: Colors.orange,
                 child: Icon(Icons.send),
                 onPressed:()=> isEdit ? _edit(context,editBloc) : _add(context,editBloc),
               ),
             );
           })
       );
  }

  void _add(context,EditBloc editBloc){
    if(editBloc.task.isNotEmpty){
      final user = Provider.of<FirebaseUser>(context);
      Task t = new Task(
          task: editBloc.task,
          project: editBloc.project,
          priority: editBloc.priority,
          dueDate: editBloc.dueDate,
          isDone: false
      );
      _db.addTask(t, user.uid).then((_)=>Navigator.pop(context));
    }else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please enter your task...')));
    }
  }

  void _edit(context,EditBloc editBloc){
    if(editBloc.task.isNotEmpty){
      final user = Provider.of<FirebaseUser>(context);
      final Task task = Provider.of<Task>(context);
      Task t = new Task(
          task: editBloc.task,
          project: editBloc.project,
          priority: editBloc.priority,
          dueDate: editBloc.dueDate,
          docID: task.docID,
          isDone: task.isDone
      );
      _db.editTask(t, user.uid).then((_)=>Navigator.pop(context));
    }else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Please enter your task...')));
    }
  }

  _mapValues(EditBloc editBloc,context) {
    Task task = isEdit ? Provider.of<Task>(context) : new Task(task: '', dueDate: '', priority: '2', project: 'inbox');
    if (!editBloc.mapped) {
        print("Mapping");
        editBloc.mapFromTask(task);
        editBloc.mapped = true;
    } else {
        print("Already mapped");
      }
    }
}

