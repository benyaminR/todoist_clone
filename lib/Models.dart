
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
    return snapshot != null ?Task(
      task :      snapshot['task'] ?? '',
      dueDate:    snapshot['dueDate'] ?? DateTime.now(),
      priority:   snapshot['priority'] ?? '2',
      project:    snapshot['project'] ?? 'inbox',
      isDone:     snapshot['isDone'] ?? false,
      docID:      snapshot.documentID ?? ''
    ) : Task(
      task:'',
      dueDate: DateTime.now().toString(),
      priority: '2',
      project: 'inbox',
      isDone: false,
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