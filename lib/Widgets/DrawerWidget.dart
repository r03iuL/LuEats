import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              // currentAccountPicture: CircleAvatar(
              //   backgroundImage: AssetImage("assets/images/l1.png"),
              // ),
              accountName: Text(
                "LuEATS",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "01778958475",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          // Home
          ListTile(
            leading: Icon(CupertinoIcons.home, color: Colors.green),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "homepage");
            },
          ),
          // Account
          ListTile(
            leading: Icon(CupertinoIcons.person, color: Colors.green),
            title: Text(
              "Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "loginpage");
            },
          ),
          // Order
          ListTile(
            leading: Icon(CupertinoIcons.cart_fill_badge_plus, color: Colors.green),
            title: Text(
              "Order",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "cartPage");
            },
          ),
          // Money Section
          ListTile(
            leading: Icon(Icons.money, color: Colors.green),
            title: Text(
              "Money Section",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "moneyPage");
            },
          ),
          // Settings
          ListTile(
            leading: Icon(Icons.settings, color: Colors.green),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "signup1");
            },
          ),
          // Log Out
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded, color: Colors.green),
            title: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              // Show confirmation dialog
              bool? shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Log Out'),
                    content: Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Log Out'),
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout ?? false) {
                try {
                  // Sign out the user
                  await FirebaseAuth.instance.signOut();
                  // Navigate to the login page
                  Navigator.pushReplacementNamed(context, "login1");
                } catch (e) {
                  // Handle sign out error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error logging out. Please try again."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
