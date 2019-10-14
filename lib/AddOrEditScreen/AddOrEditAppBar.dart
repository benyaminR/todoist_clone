import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/blocs/EditBloc.dart';

class AddOrEditAppBar extends StatefulWidget implements PreferredSizeWidget{
  final TextEditingController textEditingController;
  AddOrEditAppBar({this.textEditingController});

  @override
  Size get preferredSize => Size.fromHeight(230);

  @override
  State<StatefulWidget> createState() {
    return AddOrEditAppBarState(textEditingController: textEditingController);
  }
}

class AddOrEditAppBarState extends State<AddOrEditAppBar>{
  final TextEditingController textEditingController;
  bool mapped = false;

  AddOrEditAppBarState({this.textEditingController});

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(_listenToField);
  }
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  _listenToField(){
    if(!mapped) {
      textEditingController.text =
      Provider.of<EditBloc>(context) != null ? Provider
          .of<EditBloc>(context)
          .task : '';
      mapped = true;
    }
    Provider.of<EditBloc>(context).task = textEditingController.text;
    print(textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    //assign text
    return AppBar(
      bottom: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(left: 200,right: 200,bottom: 50),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Task",
                style: new TextStyle(
                    fontSize:18,
                    color: Colors.white
                ),
              ),
              TextField(
                controller: textEditingController,
                onChanged: (task)=> Provider.of<EditBloc>(context).task = task,
                autofocus: true,
                style: new TextStyle(
                    fontSize: 50,
                    color: Colors.white
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

}