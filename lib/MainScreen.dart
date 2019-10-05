import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/Models.dart';
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
 */
class Tasks extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<List<Task>>(context);
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context,i){
          return ListTile(
            title: Text(tasks[i].task),
            onTap: null,
          );
        });
  }
}