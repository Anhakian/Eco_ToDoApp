import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current User
  User? user = FirebaseAuth.instance.currentUser;

  // Get Tasks
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("Tasks");

  // Post Tasks
  Future<void> addTasks(String task, String recurrence, DateTime startTime) {
    return tasks.add({
      'UserEmail': user!.email,
      'Description': task,
      'Recurrence': recurrence,
      'StartTime': startTime,
      'Completed': false,
      'CreatedAt': Timestamp.now(),
    });
  }

  // Read Tasks
  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("CreatedAt")
        .snapshots();

    return tasksStream;
  }
}
