import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../Widgets/drawer_widget.dart';

class AddLunch extends StatefulWidget {
  const AddLunch({Key? key}) : super(key: key);

  @override
  _AddLunchState createState() => _AddLunchState();
}

class _AddLunchState extends State<AddLunch> {
  // Variable to hold the image file
  File? _imageFile;
  final TextEditingController _lunchPriceController = TextEditingController();
  final TextEditingController _lunchDescriptionController = TextEditingController();

  // Image Picker Function
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected'),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Upload Image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      final fileName = _imageFile!.path.split('/').last;
      final storageRef = FirebaseStorage.instance.ref().child('lunch_images/$fileName');
      final uploadTask = storageRef.putFile(_imageFile!);

      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  // Delete Previous Lunch Data
  Future<void> _deletePreviousLunch() async {
    try {
      // Query the previous lunch item in Firestore
      final QuerySnapshot lunchSnapshot = await FirebaseFirestore.instance
          .collection('lunch_item')
          .limit(1) // Assuming only one lunch item exists
          .get();

      if (lunchSnapshot.docs.isNotEmpty) {
        final lunchDoc = lunchSnapshot.docs.first;
        final previousImageUrl = lunchDoc['image'];

        // Delete the lunch document from Firestore
        await lunchDoc.reference.delete();

        // Delete the image from Firebase Storage
        if (previousImageUrl != null && previousImageUrl.isNotEmpty) {
          final storageRef = FirebaseStorage.instance.refFromURL(previousImageUrl);
          await storageRef.delete();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting previous lunch: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Save New Lunch Item to Firestore
  Future<void> _saveLunchItem() async {
    final lunchPrice = _lunchPriceController.text.trim();
    final lunchDescription = _lunchDescriptionController.text.trim();
    final imageUrl = await _uploadImage();

    if (lunchPrice.isEmpty || lunchDescription.isEmpty || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // First, delete the previous lunch item and its associated image
      await _deletePreviousLunch();

      // Add the new lunch item to Firestore
      await FirebaseFirestore.instance.collection('lunch_item').add({
        'price': lunchPrice,
        'description': lunchDescription,
        'image': imageUrl ?? '',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lunch item added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear input fields and image
      _lunchPriceController.clear();
      _lunchDescriptionController.clear();
      setState(() {
        _imageFile = null;
      });

      Navigator.pushNamed(context, "homepage");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding lunch item: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add New Lunch Item'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 40),
                // Add Lunch Text
                Text(
                  "Add New Lunch Item",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 25),
                // Upload Lunch Picture
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Lunch Picture:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Image Placeholder or Display
                GestureDetector(
                  onTap: _pickImage, // Call the image picker when tapped
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : Icon(Icons.camera_alt, size: 40, color: Colors.grey[600]),
                  ),
                ),

                SizedBox(height: 20),

                // Lunch Price
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lunch Price",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4), // Square border
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _lunchPriceController,
                        decoration: InputDecoration(
                          hintText: 'Enter lunch price',
                          border: InputBorder.none, // Remove default border
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                ),

                // Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4), // Square border
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _lunchDescriptionController,
                        minLines: 3, // Set the minimum number of lines
                        maxLines: 20, // Set the maximum number of lines
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          border: InputBorder.none, // Remove default border
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),
                // ADD Button
                Container(
                  height: 45,
                  width: 170,
                  child: ElevatedButton(
                    onPressed: _saveLunchItem,
                    child: Text(
                      "Add Lunch",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Change text color to white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
