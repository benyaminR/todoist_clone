
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/blocs/EditBloc.dart';

class AddOrEditBody extends StatelessWidget{

  AddOrEditBody();
  @override
  Widget build(BuildContext context) {
    final editBloc = Provider.of<EditBloc>(context);
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
            subtitle: Text("${editBloc.project}"),
            leading: Icon(Icons.assignment),
            onTap: ()=> _onProject(context,editBloc),
          ),
          SizedBox(
            height: 8,
          ),
          //due date
          ListTile(
            title: Text("Due date"),
            subtitle: Text("${editBloc.dueDate}"),
            leading: Icon(Icons.calendar_today),
            onTap:() => _onDate(context,editBloc),
          ),
          SizedBox(
            height: 8,
          ),
          //priority
          ListTile(
            title: Text("Priority"),
            subtitle: Text('priority ${editBloc.priority}'),
            leading: Icon(Icons.outlined_flag,),
            onTap: ()=>_onPriority(context,editBloc),
          ),

        ],
      ),
    );
  }

  void _onPriority(context,EditBloc editBloc) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Priority"),
            content: Container(
              width: 500,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      title: Text("Priority 1"),
                      leading: Icon(Icons.flag,color: Colors.red,),
                      onTap: ()=> _onSelectPriority(1,context,editBloc),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                    ListTile(
                      title: Text("Priority 2"),
                      leading: Icon(Icons.flag,color: Colors.yellow,),
                      onTap: ()=> _onSelectPriority(2,context,editBloc),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                    ListTile(
                      title: Text("Priority 3"),
                      leading: Icon(Icons.flag,color: Colors.blue,),
                      onTap: ()=> _onSelectPriority(3,context,editBloc),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                    ListTile(
                      title: Text("Priority 4"),
                      leading: Icon(Icons.flag,color: Colors.grey,),
                      onTap: ()=> _onSelectPriority(4,context,editBloc),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: ()=>Navigator.pop(context),
              )
            ],
          );
        }
    );
  }
  void _onProject(context,EditBloc editBloc) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Project"),
            content: Container(
              width: 500,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      title: Text("Inbox"),
                      leading: Icon(Icons.fiber_manual_record,color: Colors.red,),
                      onTap: ()=> _onSelectProject('Inbox',context,editBloc),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                    ListTile(
                      title: Text("Work"),
                      leading: Icon(Icons.fiber_manual_record,color: Colors.yellow,),
                      onTap: ()=> _onSelectProject('Work',context,editBloc),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                    ListTile(
                      title: Text("Movies to Watch"),
                      leading: Icon(Icons.fiber_manual_record,color: Colors.blue,),
                      onTap: ()=> _onSelectProject('Movies to Watch',context,editBloc),
                    ),
                    Divider(color: Colors.grey,height: 0,),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: ()=>Navigator.pop(context),
              )
            ],
          );
        }
    );
  }

  void _onDate(context,EditBloc editBloc){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        }).then((dateTime)=>{
      editBloc.dueDate = '${dateTime.day}.${dateTime.month}.${dateTime.year}',
    });

  }

  void _onSelectPriority(int priority,context,EditBloc editBloc){
    Navigator.pop(context);
    editBloc.priority = priority.toString();
  }

  void _onSelectProject(String project,context,EditBloc editBloc){
    Navigator.pop(context);
    editBloc.project = project;
  }

}