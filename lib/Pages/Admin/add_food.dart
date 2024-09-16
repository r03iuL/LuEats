import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../Widgets/admin_app_bar_widget.dart';
import '../../Widgets/drawer_widget.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  File? _imageFile;
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedPopularity;

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
          SnackBar(content: Text('No image selected'), backgroundColor: Colors.grey),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // Upload Image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    _showLoadingDialog();
    try {

      final fileName = _imageFile!.path.split('/').last;
      final storageRef = FirebaseStorage.instance.ref().child('food_images/$fileName');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      _dismissLoadingDialog();

      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e'), backgroundColor: Colors.red),
      );
      return null;
    }
  }

  // Save Food Item to Firestore
  Future<void> _saveFoodItem() async {
    final foodName = _foodNameController.text.trim();
    final foodPrice = _foodPriceController.text.trim();
    final foodDescription = _foodDescriptionController.text.trim();
    final imageUrl = await _uploadImage();

    if (foodName.isEmpty || foodPrice.isEmpty || foodDescription.isEmpty || _selectedCategory == null || _selectedPopularity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.red),
      );
      return;
    }

    _showLoadingDialog(); // Show loading dialog when save start

    try {
      await FirebaseFirestore.instance.collection('Food_items').add({
        'name': foodName,
        'price': foodPrice,
        'description': foodDescription,
        'image': imageUrl ?? '',
        'category': _selectedCategory,
        'popularity': _selectedPopularity,
      });

      _dismissLoadingDialog();  // Dismiss loading dialog when save is successful

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Food item added successfully'), backgroundColor: Colors.green),
      );

      // Clear input fields and image
      _foodNameController.clear();
      _foodPriceController.clear();
      _foodDescriptionController.clear();
      setState(() {
        _imageFile = null;
        _selectedCategory = null;
        _selectedPopularity = null;
      });

      Navigator.pushNamed(context, "homepage");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding food item: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // Fetch Categories from Firestore
  Future<List<String>> _fetchCategories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Food_categories').get();
    return snapshot.docs.map((doc) => doc['name'].toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add New Food Item'),
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
                Text(
                  "Add New Food Item",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Food Picture:",
                      style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: _pickImage,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Food Item Name",
                      style: TextStyle(fontSize: 18, color: Colors.deepOrange, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _foodNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter food item name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Food Item Price",
                      style: TextStyle(fontSize: 18, color: Colors.deepOrange, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _foodPriceController,
                        decoration: InputDecoration(
                          hintText: 'Enter food item price',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 18, color: Colors.deepOrange, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _foodDescriptionController,
                        minLines: 3,
                        maxLines: 20,
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    "Select Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.deepOrange),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: FutureBuilder<List<String>>(
                    future: _fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error loading categories");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text("No categories available");
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(border: InputBorder.none),
                              value: _selectedCategory,
                              items: snapshot.data!.map((category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // Popularity Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    "Select Popularity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.deepOrange),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(border: InputBorder.none),
                        value: _selectedPopularity,
                        items: [
                          DropdownMenuItem(value: 'Popular', child: Text('Popular')),
                          DropdownMenuItem(value: 'Newest', child: Text('Newest')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedPopularity = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: ElevatedButton(
                    onPressed: _saveFoodItem,
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),
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
