
import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  final String task;
  final String dueDate;
  final String priority;
  final String project;
  bool isDone;
  final String docID;
  Task({this.task, this.dueDate, this.priority, this.project,this.isDone,this.docID});

  factory Task.fromSnapshot(DocumentSnapshot snapshot){
    return Task(
      task :      snapshot['task'],
      dueDate:    snapshot['dueDate'],
      priority:   snapshot['priority'],
      project:    snapshot['project'],
      isDone:     snapshot['isDone'],
      docID:      snapshot.documentID
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'task' : task,
      'dueDate' : dueDate,
      'priority' : priority,
      'project' : project,
      'isDone' : isDone
    };
  }
}