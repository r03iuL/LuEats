import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;  // Firebase Authentication instance
  final _formKey = GlobalKey<FormState>();  // Key to identify the form for validation

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

  // Function to handle user sign-up with Firebase
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create a new user with email and password using Firebase
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Signup Successful!"),  // Notify user of success
          backgroundColor: Colors.green,
        ));

        // Navigate to another page after successful sign-up
        Navigator.pushNamed(context, "login1");
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? "An error occurred"),  // Display error message
          backgroundColor: Colors.red,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong"),  // General error message
          backgroundColor: Colors.red,
        ));
      }
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
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$').hasMatch(value)) {
      return 'Password must contain one uppercase, one lowercase, and one number';
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
                key: _formKey,  // Wrap the form with a GlobalKey to manage form validation state
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
                    _buildFormField("Full Name", "Enter Your Name", _nameController, _validateRequired),

                    // Email address
                    _buildFormField("Email address", "abc123@gmail.com", _emailController, _validateRequired),

                    // Password
                    _buildFormField("Password", ".............", _passwordController, _validatePassword, obscureText: true),

                    // Confirm Password
                    _buildFormField("Confirm Password", ".............", _confirmPasswordController, _validateConfirmPassword, obscureText: true),

                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Additional Information", style: TextStyle(fontSize: 18, color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Department
                    _buildFormField("Department", "CSE", _departmentController, _validateRequired),

                    // Designation
                    _buildFormField("Designation", "Lecturer", _designationController, _validateRequired),

                    // Phone Number
                    _buildFormField("Phone Number", "Enter Your Number", _mobileController, _validatePhone),

                    // Building
                    _buildFormField("Building", "RKB/RAB", _buildingController, _validateRequired),

                    // Floor
                    _buildFormField("Floor", "1st/2nd/3rd/4th", _floorController, _validateRequired),

                    // Room Number
                    _buildFormField("Room Number", "Room Number or Name", _roomController, _validateRequired),

                    SizedBox(height: 50),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _signUp,  // Call the signup function if form is valid
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
                          Navigator.pushNamed(context, "login1");  // Navigate to login page
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

  // Helper method to build form fields
  Widget _buildFormField(String label, String hintText, TextEditingController controller, String? Function(String?) validator, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 18, color: Colors.black)),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            obscureText: obscureText,
            validator: validator,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
