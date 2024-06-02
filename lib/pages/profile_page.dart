import "package:cloud_firestore/cloud_firestore.dart";
import "package:eco_to_do_app/components/my_drawer.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current User
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const Text(
            "PROFILE",
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
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              Map<String, dynamic>? user = snapshot.data!.data();

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user!["username"],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user["email"],
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text("No Data");
            }
          },
        ));
  }
}
