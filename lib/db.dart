
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoist_clone/Models.dart';

class DB{
  Firestore _firestore = Firestore.instance;

  Stream<List<Task>> getTasks(uid) {
    //String uid = (await FirebaseAuth.instance.currentUser()).uid;
    return _firestore.collection(uid).snapshots().map((list)=>
      list.documents.map((snapshot)=>Task.fromSnapshot(snapshot)
      ).toList()
    );

  }



}