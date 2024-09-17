import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  // Controllers to hold the input values from TextFormFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  // Focus nodes to listen for focus change events
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _departmentFocusNode = FocusNode();
  final FocusNode _designationFocusNode = FocusNode();
  final FocusNode _buildingFocusNode = FocusNode();
  final FocusNode _floorFocusNode = FocusNode();
  final FocusNode _roomFocusNode = FocusNode();

  // Variable to hold the image file
  File? _imageFile;


  @override
  void initState() {
    super.initState();

    // Attach listeners to the focus nodes to validate on focus change
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _mobileFocusNode.addListener(() {
      if (!_mobileFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _departmentFocusNode.addListener(() {
      if (!_departmentFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _designationFocusNode.addListener(() {
      if (!_designationFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _buildingFocusNode.addListener(() {
      if (!_buildingFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _floorFocusNode.addListener(() {
      if (!_floorFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _roomFocusNode.addListener(() {
      if (!_roomFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    // Dispose focus nodes to prevent memory leaks
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _mobileFocusNode.dispose();
    _departmentFocusNode.dispose();
    _designationFocusNode.dispose();
    _buildingFocusNode.dispose();
    _floorFocusNode.dispose();
    _roomFocusNode.dispose();
    super.dispose();
  }

  //Image Picker Function
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No image selected'),
          backgroundColor: Colors.grey,
        ));
      }
    } catch (e) {
      // Handle any errors that might occur during image picking
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }


  // Function to handle user sign-up with Firebase
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          await user.sendEmailVerification();

          // Upload image to Firebase Storage
          String? imageUrl;
          if (_imageFile != null) {
            imageUrl = await _uploadImage(user.uid);
          }

          // Store user data along with image URL in Firestore
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'phone': _mobileController.text.trim(),
            'department': _departmentController.text.trim(),
            'designation': _designationController.text.trim(),
            'building': _buildingController.text.trim(),
            'floor': _floorController.text.trim(),
            'room': _roomController.text.trim(),
            'imageUrl': imageUrl,
            'createdAt': Timestamp.now(),
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Signup Successful! Please verify your email."),
            backgroundColor: Colors.green,
          ));

          await Future.delayed(Duration(seconds: 2));
          await _auth.signOut();
          Navigator.pushNamed(context, "login1");
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? "An error occurred"),
          backgroundColor: Colors.red,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  // Function to upload image to Firebase Storage
  Future<String?> _uploadImage(String uid) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('user_images/$uid.jpg');
      final uploadTask = await storageRef.putFile(_imageFile!);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to upload image"),
        backgroundColor: Colors.red,
      ));
      return null;
    }
  }

  // Validator for phone number (must be 11 digits)
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'Phone number must be 11 digits';
    }
    return null;
  }

  // Validator for password (must contain one uppercase, one lowercase, and one number)
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Minimum one uppercase,one lowercase,and one number';
    }
    return null;
  }


  // Validator to check if password and confirm password match
  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // General required field validator
  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Custom email validator that checks for proper format and @lus.ac.bd
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@lus.ac.bd$').hasMatch(value)) {
      return 'Email must be in the format abc@lus.ac.bd';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      child: Center(
                          child: Image(
                              image: AssetImage('assets/images/Illustration.jpg'))),
                      height: 250,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),

                    // Full Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Full Name", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            decoration: InputDecoration(
                              hintText: "Enter Your Name",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateRequired,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                    // Email address
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email address", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                              hintText: "example@lus.ac.bd",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateEmail,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                    // Password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Password", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                              hintText: "******",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            //obscureText: true,
                            validator: _validatePassword,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                    // Confirm Password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Confirm Password", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            decoration: InputDecoration(
                              hintText: "******",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            //obscureText: true,
                            validator: _validateConfirmPassword,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Additional Information",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25, color: Colors.orangeAccent, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30),

                    // Image picker
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Profile Picture",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18, color: Colors.black)),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.grey[200],
                              backgroundImage:
                              _imageFile != null ? FileImage(_imageFile!) : null,
                              child: _imageFile == null
                                  ? Icon(Icons.camera_alt,
                                  size: 40, color: Colors.grey[600])
                                  : null,
                            ),
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
                          Text("Phone Number", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _mobileController,
                            focusNode: _mobileFocusNode,
                            decoration: InputDecoration(
                              hintText: "0188888888",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validatePhone,
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
                          Text("Department", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _departmentController,
                            focusNode: _departmentFocusNode,
                            decoration: InputDecoration(
                              hintText: "eg. CSE",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateRequired,
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
                          Text("Designation", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _designationController,
                            focusNode: _designationFocusNode,
                            decoration: InputDecoration(
                              hintText: "eg. Lecturer",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateRequired,
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
                          Text("Building", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _buildingController,
                            focusNode: _buildingFocusNode,
                            decoration: InputDecoration(
                              hintText: "RAB/RKB",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateRequired,
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
                          Text("Floor", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _floorController,
                            focusNode: _floorFocusNode,
                            decoration: InputDecoration(
                              hintText: "1st/2nd/3rd",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateRequired,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                    // Room Number
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Room Number", style: TextStyle(fontSize: 18, color: Colors.black)),
                          TextFormField(
                            controller: _roomController,
                            focusNode: _roomFocusNode,
                            decoration: InputDecoration(
                              hintText: "eg. CSE Faculty Room",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: _validateRequired,
                          ),
                        ],
                      ),
                    ),

                    // Signup button
                    SizedBox(height: 30),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        child: Text("Sign Up", style: TextStyle(fontSize: 19)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Already signed up?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "login1");
                        },
                        child: Text("Login", style: TextStyle(fontSize: 19)),
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
        ),
      ),
    );
  }
}
