import "package:flutter/material.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            // Drawer Header
            const DrawerHeader(
              child: Icon(
                Icons.public,
              ),
            ),

            // Task list
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: const Icon(Icons.task_alt),
                title: const Text("TASK LIST"),
                onTap: () {
                  Navigator.pop(context);

                  // Navigate to Task List page
                  Navigator.pushNamed(context, '/home_page');
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Profile
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("PROFILE"),
                onTap: () {
                  Navigator.pop(context);

                  // Navigate to Profile page
                  Navigator.pushNamed(context, '/profile_page');
                },
              ),
            ),
          ],
        ),

        //Logout Button
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LOGOUT"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    ));
  }
}
