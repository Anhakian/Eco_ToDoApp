import "package:eco_to_do_app/components/my_drawer.dart";
import "package:eco_to_do_app/components/task_tile.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // App Bar
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const Text(
            "TASK TO DO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),

        // Drawer
        drawer: const MyDrawer(),

        // Add Task Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),

        // Task List
        body: ListView(children: [
          TaskTile(
            taskName: "Name",
            taskCompleted: false,
            onChanged: (p0) {},
            deleteFunction: (p0) {},
          ),
        ]));
  }
}
