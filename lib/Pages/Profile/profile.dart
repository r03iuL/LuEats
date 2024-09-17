import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('No user logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.orange,
                          width: 4), // Border around profile picture
                    ),
                    child: ClipOval(
                      child: Image.network(
                        userData['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['name'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['email'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['phone'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Department:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['department'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Designation:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['designation'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Floor:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['floor'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Room:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Expanded(
                        child: Text(userData['room'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "editprofile");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Edit Info'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

