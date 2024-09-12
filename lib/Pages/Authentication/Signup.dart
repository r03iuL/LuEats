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
  final TextEditingController _mobileController = TextEditingController();

  // Function to handle user sign-up with Firebase
  Future<void> _signUp() async {
    try {
      // Create a new user with email and password using Firebase
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), // Getting the email from the text field
        password: _passwordController.text.trim(), // Getting the password from the text field
      );

      // Optionally save additional user information like name and mobile number to Firestore
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Signup Successful!"),  // Notify user of success
        backgroundColor: Colors.green,
      ));

      // Navigate to another page after successful sign-up
      Navigator.pushNamed(context, "storeinfo");
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors (e.g., weak password, email already in use)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "An error occurred"),  // Display error message
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      // Handle any other non-Firebase errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),  // General error message
        backgroundColor: Colors.red,
      ));
    }
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
                      "Sign UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Full Name", style: TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: TextFormField(
                        controller: _nameController,  // Capturing name input from the user
                        decoration: InputDecoration(
                          hintText: 'Enter Your Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Email address", style: TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: TextFormField(
                        controller: _emailController,  // Capturing email input from the user
                        decoration: InputDecoration(
                          hintText: 'name@gmail.com',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password", style: TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: TextFormField(
                        controller: _passwordController,  // Capturing password input
                        decoration: InputDecoration(
                          hintText: '.............',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        obscureText: true,  // Hide password input
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Mobile", style: TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: TextFormField(
                        controller: _mobileController,  // Capturing mobile number input
                        decoration: InputDecoration(
                          hintText: 'Enter Your Number',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate the form before signing up
                          if (_formKey.currentState?.validate() ?? false) {
                            _signUp();  // Call the signup function if form is valid
                          }
                        },
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
}
