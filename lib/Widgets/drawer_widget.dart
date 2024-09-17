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
          // Use a Container instead of DrawerHeader for more control
          FutureBuilder<Map<String, dynamic>?>(
            future: _fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.blueGrey, // Placeholder color
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.red, // Placeholder color
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  height: 205,
                  color: Colors.grey, // Placeholder color
                  child: Center(child: Text('No user data found')),
                );
              }

              final userData = snapshot.data!;
              final String? imageUrl = userData['imageUrl'];
              final String? name = userData['name'];
              final String? phone = userData['phone'];

              return Container(
                width: double.infinity,
                height: 200, // Adjust height as needed
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange], // Gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the contents vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage("assets/images/default_user.png") as ImageProvider,
                      radius: 60, // Adjust radius to increase the image size
                    ),
                    SizedBox(height: 12), // Space between avatar and text
                    Text(
                      name ?? 'User Name',
                      style: TextStyle(
                        fontSize:20, // Increase font size for larger text
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Use Expanded to ensure that the remaining drawer space is used
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
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
                ListTile(
                  leading: Icon(CupertinoIcons.person, color: Colors.green),
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
                  leading: Icon(CupertinoIcons.cart_fill_badge_plus, color: Colors.green),
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

                //Credit
                // ListTile(
                //   leading: Icon(Icons.money, color: Colors.green),
                //   title: Text(
                //     "Money Section",
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, "moneyPage");
                //   },
                // ),

                //Settings
                // ListTile(
                //   leading: Icon(Icons.settings, color: Colors.green),
                //   title: Text(
                //     "Settings",
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, "signup1");
                //   },
                // ),

                ListTile(
                  leading: Icon(Icons.settings, color: Colors.green),
                  title: Text(
                    "Add Food",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "addfood");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.green),
                  title: Text(
                    "Add Category",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "addcategory");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.deepOrange),
                  title: Text(
                    "Add Launch",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "addlunch");
                  },
                ),
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
