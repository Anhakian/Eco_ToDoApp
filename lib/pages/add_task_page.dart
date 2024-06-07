import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_to_do_app/components/my_button.dart';
import 'package:eco_to_do_app/models/task.dart';
import 'package:eco_to_do_app/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final List<String> repeatValues = ['None', 'Daily', 'Weekly', 'Monthly'];
  String selectedRepeatValue = 'None';

  final FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

  void selectDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: selectedDate,
    ).then(
      (value) {
        if (value != null) {
          setState(() {
            selectedDate = value;
          });
        }
      },
    );
  }

  void selectTime() {
    showTimePicker(
      context: context,
      initialTime: selectedTime,
    ).then(
      (value) {
        if (value != null) {
          setState(() {
            selectedTime = value;
          });
        }
      },
    );
  }

  Future<void> addTaskToFirestore() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Combine selectedDate and selectedTime into a single DateTime object
    final taskDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Convert taskDateTime to a Timestamp
    final taskTimestamp = Timestamp.fromDate(taskDateTime);

    // Retrieve current user's email
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? '';

    // Create task ID
    String taskId = _firestoreDatabase.tasks.doc().id;
    Task task = Task(
      id: taskId,
      taskName: taskController.text,
      taskDateTime: taskTimestamp,
      repeatInterval: selectedRepeatValue,
      completed: false,
      userEmail: userEmail, // Set the email directly here
    );

    Map<String, dynamic> taskData = task.taskToMap();

    try {
      await FirebaseFirestore.instance.collection('Tasks').add(taskData);
      print('Task added to Firestore successfully!');
      print(task.userEmail);
    } on FirebaseException catch (e) {
      print('Error adding task to Firestore: $e');
    } finally {
      Navigator.of(context).pop(); // Close the loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(
          "ADD TASK",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Add Task",
                hintStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: const TextStyle(
                fontSize: 25, // Adjust the font size as needed
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 30,
                ),
                const SizedBox(
                  width: 30.0,
                ),
                GestureDetector(
                  onTap: selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                GestureDetector(
                  onTap: selectTime,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      selectedTime.format(context),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Text(
                  "Repeat",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                DropdownButton<String>(
                  value: selectedRepeatValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRepeatValue = newValue!;
                    });
                  },
                  items: repeatValues.map(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  buttonText: 'Add',
                  onTap: addTaskToFirestore,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
