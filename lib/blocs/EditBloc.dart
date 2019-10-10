import 'package:flutter/cupertino.dart';
import 'package:todoist_clone/Models.dart';

class EditBloc with ChangeNotifier{

  bool _mapped = false;
  bool get mapped => _mapped;
  set mapped(bool val){
    _mapped = val;
  }

  String _dueDate;
  String get dueDate => _dueDate;
  set dueDate(String val){
    _dueDate = val;
    notifyListeners();
  }

  String _project;
  String get project => _project;
  set project(String val){
    _project= val;
    notifyListeners();
  }

  String _priority;
  String get priority => _priority;
  set priority(String val){
    _priority = val;
    notifyListeners();
  }

  String _task;
  String get task => _task;
  set task(String val){
    _task = val;
    notifyListeners();
  }


  mapFromTask(Task task){
   _task = task.task;
   _priority = task.priority;
   _project = task.project;
   _dueDate = task.dueDate;
  }

}