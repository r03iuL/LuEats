import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  Future<Map<String, dynamic>?> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users') // Replace with your collection name
            .doc(user.uid)
            .get();

        if (doc.exists) {
          return doc.data() as Map<String, dynamic>?;
        } else {
          print("Document does not exist");
          return null;
        }
      } catch (e) {
        print("Error fetching user data: $e");
        return null;
      }
    } else {
      print("User is not logged in");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          FutureBuilder<Map<String, dynamic>?>(
            future: _fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.blueGrey,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.red,
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  height: 205,
                  color: Colors.grey,
                  child: Center(child: Text('No user data found')),
                );
              }

              final userData = snapshot.data!;
              final String? imageUrl = userData['imageUrl'];
              final String? name = userData['name'];

              return Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage("assets/images/default_user.png") as ImageProvider,
                      radius: 60,
                    ),
                    SizedBox(height: 12),
                    Text(
                      name ?? 'User Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(CupertinoIcons.home, color: Colors.orange),
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
                ListTile(
                  leading: Icon(CupertinoIcons.person, color: Colors.orange),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "profile");
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.cart_fill_badge_plus, color: Colors.orange),
                  title: Text(
                    "Order History",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "orderhistory");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app_rounded, color: Colors.orange),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
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
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, "login1");
                      } catch (e) {
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
          ),
        ],
      ),
    );
  }
}
