import 'package:flutter/material.dart';

class Task {
  String id;
  String taskName;
  DateTime taskDate;
  TimeOfDay dueTime;
  String repeatInterval;

  Task({
    required this.id,
    required this.taskName,
    required this.taskDate,
    required this.dueTime,
    required this.repeatInterval,
  });

  // Convert Task object to a map
  Map<String, dynamic> taskToMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDate': taskDate,
      'dueTime': dueTime,
      'repeatInterval': repeatInterval,
    };
  }

  // Convert the map to Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['name'],
      taskDate: DateTime.parse(map['date']),
      dueTime: TimeOfDay(
        hour: int.parse(map['time'].split(':')[0]),
        minute: int.parse(map['time'].split(':')[1]),
      ),
      repeatInterval: map['repeatInterval'],
    );
  }
}
