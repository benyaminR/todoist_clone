import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/AddOrEditScreen/AddOrEditScreen.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/blocs/EditBloc.dart';
import 'package:todoist_clone/db.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todoist"),
      ),
      body: StreamProvider<List<Task>>.value(
        value: DB().getTasks(user.uid),child: Tasks(),
      ),
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
/*
Return a list of tasks
Note: Doesn't show tasks that are marked as done!
 */
class Tasks extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<List<Task>>(context,listen: true);
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context,i){
          return !tasks[i].isDone ? Dismissible(
            key: new Key(i.toString()) ,
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
              title: Text(tasks[i].task),
              onTap: ()=> _edit(context,tasks[i].docID),
            ),
          )
              :
          Container()
          ;
        });
  }

  void _edit(context,docID){
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