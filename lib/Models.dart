
import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  final String task;
  final String dueDate;
  final String priority;
  final String project;
  final String docID;
  Task({this.task, this.dueDate, this.priority, this.project,this.docID});

  factory Task.fromSnapshot(DocumentSnapshot snapshot){
    return Task(
      task :      snapshot['task'],
      dueDate:    snapshot['dueDate'],
      priority:   snapshot['priority'],
      project:    snapshot['project'],
      docID:      snapshot.documentID
    );
  }

  Map<String,String> toMap(){
    return {
      'task' : task,
      'dueDate' : dueDate,
      'priority' : priority,
      'project' : project
    };
  }
}