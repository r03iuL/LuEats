import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  // Variable to hold the image file
  File? _imageFile;
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryTaglineController = TextEditingController();

  bool _isLoading = false;  // Added to manage loading state

  // Show Loading Dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Dismiss Loading Dialog
  void _dismissLoadingDialog() {
    Navigator.pop(context);  // Dismisses the loading dialog
  }

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
      // Handle any errors that might occur during image picking
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

    _showLoadingDialog();

    try {
      final fileName = _imageFile!.path.split('/').last;
      final storageRef = FirebaseStorage.instance.ref().child('category_images/$fileName');
      final uploadTask = storageRef.putFile(_imageFile!);

      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      _dismissLoadingDialog();

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

  // Save Category to Firestore
  Future<void> _saveCategory() async {
    final categoryName = _categoryNameController.text.trim();
    final categoryTagline = _categoryTaglineController.text.trim();
    final imageUrl = await _uploadImage();

    if (categoryName.isEmpty || categoryTagline.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _showLoadingDialog(); // Show loading dialog when save start

    try {
      await FirebaseFirestore.instance.collection('Food_categories').add({
        'name': categoryName,
        'tagline': categoryTagline,
        'image': imageUrl ?? '',
      });

      _dismissLoadingDialog();  // Dismiss loading dialog when save is successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear input fields and image
      _categoryNameController.clear();
      _categoryTaglineController.clear();
      setState(() {
        _imageFile = null;
      });

      Navigator.pushNamed(context, "homepage");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding category: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 40),
                // Add Items Text
                Text(
                  "Add New Food Category",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 25),
                // Upload Category Picture
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Category Picture:",
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
                // Category Name
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category Name",
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
                        controller: _categoryNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter food category name',
                          border: InputBorder.none, // Remove default border
                        ),
                      ),
                    ),
                  ),
                ),

                // Category Tagline
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category Tagline",
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
                        controller: _categoryTaglineController,
                        decoration: InputDecoration(
                          hintText: 'Enter category tagline',
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
                    onPressed: _saveCategory,
                    child: Text(
                      "ADD Category",
                      style: TextStyle(fontSize: 19),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
