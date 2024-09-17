import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _departmentController;
  late TextEditingController _designationController;
  late TextEditingController _buildingController;
  late TextEditingController _floorController;
  late TextEditingController _roomController;
  late FocusNode _nameFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _departmentFocusNode;
  late FocusNode _designationFocusNode;
  late FocusNode _buildingFocusNode;
  late FocusNode _floorFocusNode;
  late FocusNode _roomFocusNode;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;  // For managing loading state

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _departmentController = TextEditingController();
    _designationController = TextEditingController();
    _buildingController = TextEditingController();
    _floorController = TextEditingController();
    _roomController = TextEditingController();

    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _departmentFocusNode = FocusNode();
    _designationFocusNode = FocusNode();
    _buildingFocusNode = FocusNode();
    _floorFocusNode = FocusNode();
    _roomFocusNode = FocusNode();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = userDoc.data()!;

      _nameController.text = data['name'] ?? '';
      _phoneController.text = data['phone'] ?? '';
      _departmentController.text = data['department'] ?? '';
      _designationController.text = data['designation'] ?? '';
      _buildingController.text = data['building'] ?? '';
      _floorController.text = data['floor'] ?? '';
      _roomController.text = data['room'] ?? '';
      setState(() {
        _imageUrl = data['imageUrl'];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

        // Retrieve current user data to get the previous image URL
        final userDoc = await userDocRef.get();
        final oldImageUrl = userDoc.data()?['imageUrl'];

        // If there is an existing image URL, delete it from Firebase Storage
        if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
          final oldImageRef = FirebaseStorage.instance.refFromURL(oldImageUrl);
          await oldImageRef.delete();
        }

        // Convert XFile to File
        final file = File(pickedFile.path);

        // Upload new image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('$userId.jpg');
        final uploadTask = storageRef.putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          _imageUrl = downloadUrl;
          _isLoading = false; // Hide loading indicator
        });

        // Update Firestore with the new image URL
        await userDocRef.update({'imageUrl': _imageUrl});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image updated successfully')),
        );
      } catch (e) {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image')),
        );
      }
    }
  }



  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;  // Show loading indicator
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

          // Update user data
          await userDocRef.update({
            'name': _nameController.text,
            'phone': _phoneController.text,
            'department': _departmentController.text,
            'designation': _designationController.text,
            'building': _buildingController.text,
            'floor': _floorController.text,
            'room': _roomController.text,
            'imageUrl': _imageUrl, // Ensure this is a valid URL after upload
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile')));
      } finally {
        setState(() {
          _isLoading = false;  // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _imageUrl != null
                            ? NetworkImage(_imageUrl!)
                            : null,
                        child: _imageUrl == null
                            ? Icon(Icons.camera_alt,
                            size: 40, color: Colors.grey[600])
                            : null,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator(),  // Show loading indicator
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Full Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Full Name",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Phone Number
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone Number",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        decoration: InputDecoration(
                          hintText: "0188888888",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length != 11) {
                            return 'Phone number must be 11 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Department
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Department",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _departmentController,
                        focusNode: _departmentFocusNode,
                        decoration: InputDecoration(
                          hintText: "eg. CSE",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Designation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Designation",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _designationController,
                        focusNode: _designationFocusNode,
                        decoration: InputDecoration(
                          hintText: "eg. Lecturer",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Building
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Building",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _buildingController,
                        focusNode: _buildingFocusNode,
                        decoration: InputDecoration(
                          hintText: "Building Number",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Floor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Floor",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _floorController,
                        focusNode: _floorFocusNode,
                        decoration: InputDecoration(
                          hintText: "Floor Number",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Room
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Room",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      TextFormField(
                        controller: _roomController,
                        focusNode: _roomFocusNode,
                        decoration: InputDecoration(
                          hintText: "Room Number",
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // Update Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: ElevatedButton(
                    onPressed: _updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Update Profile',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
