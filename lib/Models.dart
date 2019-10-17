
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';

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
      task :      snapshot['task'] ?? '',
      dueDate:    snapshot['dueDate'] ?? DateTime.now(),
      priority:   snapshot['priority'] ?? '2',
      project:    snapshot['project'] ?? 'inbox',
      isDone:     snapshot['isDone'] ?? false,
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

class Project{
  final String project;
  final int color;

  Project({this.project,this.color});

  factory Project.fromSnapshot(DocumentSnapshot snapshot){
    return Project(
        project: snapshot['project'],
        color : snapshot['color']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'project' : project,
      'color' : color
    };
  }
}