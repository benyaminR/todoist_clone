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
    var projects = Provider.of<List<Project>>(context);

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
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Projects"),
              leading: Icon(Icons.folder_open,color:Colors.grey),
              trailing: FlatButton(
                padding: EdgeInsets.only(left: 16),
                onPressed: ()=> Navigator.pushNamed(context, '/main/addProject'),
                child: Icon(Icons.add,color: Colors.grey,),
              ),
            ),
            ListTile(
              title: Text("Work"),
              leading: Icon(Icons.fiber_manual_record,color:Colors.yellow),
              onTap: ()=> drawerBloc.list = "Work",
            ),
            ListTile(
              title: Text("Movies to Watch"),
              leading: Icon(Icons.fiber_manual_record,color:Colors.blue),
              onTap: ()=> drawerBloc.list = "Movies to Watch",
            ),
            if(projects != null)...[
              for(int i = 0; i < projects.length ; i++)...{
                ListTile(
                  title: Text(projects[i].project),
                  leading: Icon(Icons.fiber_manual_record,color: Color(projects[i].color),),
                  onTap: ()=>drawerBloc.list = projects[i].project,
                )
              },
            ],
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
