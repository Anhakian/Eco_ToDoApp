import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_to_do_app/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current User
  User? user = FirebaseAuth.instance.currentUser;

  // Get Tasks
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("Tasks");

  // Post Tasks
  Future<void> addTask(Task task) {
    task = Task(
      id: task.id,
      taskName: task.taskName,
      taskDateTime: task.taskDateTime,
      repeatInterval: task.repeatInterval,
      completed: task.completed,
      userEmail: user!.email!,
    );

    return tasks.doc(task.id).set(task.taskToMap());
  }

  // Read Tasks
  Stream<List<Task>> getTasksStream() {
    if (user == null) {
      return Stream.value([]);
    }
    return tasks
        .where('userEmail', isEqualTo: user!.email)
        .orderBy("dueTime")
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return Task.mapToTask(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
