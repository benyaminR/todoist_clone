

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/Models.dart';
import 'package:todoist_clone/db.dart';

class AddProject extends StatefulWidget {
  final String uid;
  AddProject(this.uid);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddProjectState(uid);
  }
}

class AddProjectState extends State<AddProject>{

  final TextEditingController _colorController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  Color _color = Colors.red;
  final String uid;


  AddProjectState(this.uid);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add project"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Name"
              ),
              controller: _nameController,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _colorController,
              onTap: _showColors,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fiber_manual_record,color: _color,),
                suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.grey,)
              ),
            )
          ],
        ),
      ),
    );
  }

  _save(){
    DB().addProject(uid, new Project(project: _nameController.text,color : _color.value)).then((_)=>Navigator.pop(context));
  }

  _showColors(){
    showDialog(context: context,builder:(BuildContext context){
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.red),
                title: Text("Berry red"),
                onTap: ()=> _setColor("Berry red",  Colors.red),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.redAccent),
                title: Text("Red"),
                onTap: ()=> _setColor("Red",  Colors.redAccent),

              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.orange),
                title: Text("Orange"),
                onTap: ()=> _setColor("Orange",  Colors.orange),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.yellow),
                title: Text("Yellow"),
                onTap: ()=> _setColor("Yellow",  Colors.yellow),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.lime),
                title: Text("Lime"),
                onTap: ()=> _setColor("Lime",  Colors.lime),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.green),
                title: Text("Green"),
                onTap: ()=> _setColor("Green",  Colors.green),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.teal),
                title: Text("Teal"),
                onTap: ()=> _setColor("Teal",  Colors.teal),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.blue),
                title: Text("Blue"),
                onTap: ()=> _setColor("Blue",  Colors.blue),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.deepPurple),
                title: Text("Deep purple"),
                onTap: ()=> _setColor("Deep purple",  Colors.deepPurple),
              ),
              ListTile(
                leading: Icon(Icons.fiber_manual_record,color : Colors.grey),
                title: Text("Grey"),
                onTap: ()=> _setColor("Grey",  Colors.grey),
              )
            ],
          ),
        ),
      );
    });
  }

  _setColor(String text, Color color){
    setState(() {
      _color = color;
      _colorController.text = text;
      Navigator.pop(context);
    });
  }
}