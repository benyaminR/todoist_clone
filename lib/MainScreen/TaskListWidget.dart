import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/AddOrEditScreen/AddOrEditScreen.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/blocs/EditBloc.dart';
import 'package:todoist_clone/db.dart';

/*
Return a list of tasks
Note: Doesn't show tasks that are marked as done!
 */
class TaskListWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    var tasks = Provider.of<List<Task>>(context);

    return ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemCount: tasks != null ? tasks.length : 0,
        itemBuilder: (context,i){
          return !tasks[i].isDone ? Dismissible(
            key: new Key(i.toString()),
            onDismissed:(DismissDirection dir)=> dir == DismissDirection.startToEnd ? _done(context,tasks[i].docID,tasks[i]):_delete(context,tasks[i].docID),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.green,
              child: Icon(Icons.done,color: Colors.white,),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete,color: Colors.white,),
            ),
            child: ListTile(
              isThreeLine: true,
              title: Text(tasks[i].task),
              subtitle: Text(tasks[i].dueDate),
              trailing: Container(
                width: 60,
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[
                    Text(tasks[i].project),
                    _findLeading(int.tryParse(tasks[i].priority),)
                  ],
                ),
              ),
              onTap: ()=> _edit(context,tasks[i].docID),
            ),
          ):
          Container();
        });
  }

  Widget _findLeading(int priority){
    Color color;
    switch(priority){
      case 0 : color = Colors.red;break;
      case 1 : color = Colors.yellow;break;
      case 2 : color = Colors.blue;break;
      case 3 : color = Colors.grey;break;
    }
    return Icon(Icons.fiber_manual_record,color: color,size: 16,);
  }

  void _edit(context,docID){

  }

  void _editScreen(context,docID){
    final EditBloc editBloc = new EditBloc();
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChangeNotifierProvider<EditBloc>.value(value: editBloc,child: AddOrEditScreen(docID: docID,),)));
  }

  void _delete(context,docID){
    var uid = Provider.of<FirebaseUser>(context).uid;
    DB().deleteTask(uid,docID);
  }

  void _done(context,docID,task){
    var uid = Provider.of<FirebaseUser>(context).uid;
    DB().completeTask(uid, docID, task);
  }
}