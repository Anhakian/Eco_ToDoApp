import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String taskName;
  Timestamp taskDateTime;
  String repeatInterval;
  bool completed;
  String userEmail;

  Task({
    required this.id,
    required this.taskName,
    required this.taskDateTime,
    required this.repeatInterval,
    required this.completed,
    required this.userEmail,
  });

  // Convert Task object to a map
  Map<String, dynamic> taskToMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDateTime': taskDateTime, // Store dueTime as Timestamp
      'repeatInterval': repeatInterval,
      'completed': completed,
      'userEmail': userEmail,
    };
  }

  // Convert the map to Task object
  factory Task.mapToTask(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['taskName'],
      taskDateTime: map['taskDateTime'], // Convert from Timestamp
      repeatInterval: map['repeatInterval'],
      completed: map['completed'],
      userEmail: map['userEmail'],
    );
  }
}
