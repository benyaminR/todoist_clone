import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/MainScreen/TaskListWidget.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/blocs/DrawerBloc.dart';
import 'package:todoist_clone/db.dart';

class MainScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var drawerBloc = Provider.of<DrawerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(drawerBloc.list),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text("B",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white
                      ),),
                    ),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("b.radmard77@gmail.com",style: TextStyle(color: Colors.white)),
                        Row(
                          children: <Widget>[
                            Icon(Icons.check_circle,color: Colors.white,),
                            Text("5/6",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.orange
              ),
            ),
            ListTile(
              title: Text("Inbox"),
              leading: Icon(Icons.inbox),
              trailing: Text("10"),
              onTap: ()=> drawerBloc.list = "Inbox",
            ),
            ListTile(
              title: Text("Today"),
              leading: Icon(Icons.today),
              trailing: Text("3"),
              onTap: ()=> drawerBloc.list = "Today",
            ),
            ListTile(
              title: Text("Next 7 Days"),
              leading: Icon(Icons.calendar_today),
              trailing: Text("4"),
              onTap: ()=> drawerBloc.list = "Next 7 Days",
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            )
          ],
        )
      ),
      body: StreamProvider<List<Task>>.value(
        value: _getTasks(user.uid,drawerBloc),
        child: TaskListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:()=> _add(context),
      ),
    );
  }
  Stream<List<Task>> _getTasks(String uid, DrawerBloc drawerBloc){
    return DB().getTasks(uid,drawerBloc.list);
  }

  void _add(context){
      Navigator.pushNamed(context, '/main/addOrEdit');
  }
}
