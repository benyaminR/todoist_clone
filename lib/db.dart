
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoist_clone/Models.dart';

class DB{
  Firestore _firestore = Firestore.instance;

  Stream<List<Task>> getTasks(uid,String value) {
    String field = "project";
    String equalTo = value;
    if(value == "Today"){
      field = "dueDate";
      var time = DateTime.now();
      equalTo = "${time.day}.${time.month}.${time.year}";
      print(equalTo);
    }


    return _firestore.
    collection(uid).
    where(field ,isEqualTo: equalTo).
    snapshots().
    map((list)=>
      list.documents.map((snapshot)=>Task.fromSnapshot(snapshot)
      ).toList()
    );
  }


  Stream<List<Project>> getProjects(String uid){
    return _firestore
        .collection(uid)
        .document("userProjects")
        .collection("projects")
        .snapshots()
        .map((list)=> list.documents.map((snapshot)=>Project.fromSnapshot(snapshot)).toList());
  }

  Future<void> addTask(Task task,uid){
    return _firestore.collection(uid).document().setData(task.toMap());
  }
  
  Stream<Task> getTask(docID,uid){
    return _firestore.collection(uid).document(docID).snapshots().map((snapshot)=>Task.fromSnapshot(snapshot));
  }
  
  Future<void> editTask(Task task,uid){
    print("A task with the following id has been edited : ${task.docID}");
    return _firestore.collection(uid).document(task.docID).updateData(task.toMap());
  }
  
  Future<void> deleteTask(uid,docID){
    return _firestore.collection(uid).document(docID).delete();
  }

  Future<void> completeTask(String uid,String docID,Task task){
    task.isDone = true;
    return _firestore.collection(uid).document(docID).updateData(task.toMap());
  }

  Future<void> addProject(String uid,Project project){
    return _firestore.collection(uid).document("userProjects").collection("projects").add(project.toMap());
  }

}