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

          String imageUrl = userData['imageUrl'] ?? ''; // Default to empty string
          if (imageUrl.isEmpty) {
            imageUrl = 'assets/images/default_user.png'; // Path to your default image
          }

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
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/default_user.png', // Fallback in case of error
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileDetailRow('Name:', userData['name'] ?? 'Not provided'),
                SizedBox(height: 12),
                _buildProfileDetailRow('Email:', userData['email'] ?? 'Not provided'),
                SizedBox(height: 12),
                _buildProfileDetailRow('Phone:', userData['phone'] ?? 'Not provided'),
                SizedBox(height: 12),
                _buildProfileDetailRow('Department:', userData['department'] ?? 'Not provided'),
                SizedBox(height: 12),
                _buildProfileDetailRow('Designation:', userData['designation'] ?? 'Not provided'),
                SizedBox(height: 12),
                _buildProfileDetailRow('Floor:', userData['floor'] ?? 'Not provided'),
                SizedBox(height: 12),
                _buildProfileDetailRow('Room:', userData['room'] ?? 'Not provided'),
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

  Widget _buildProfileDetailRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
