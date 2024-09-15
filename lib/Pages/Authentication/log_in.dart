import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers to capture user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Key to handle form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Method to handle login logic
  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firebase login using email and password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        // Check if the email is verified
        User? user = userCredential.user;
        if (user != null) {
          await user.reload(); // Reload user to get updated information
          user = _auth.currentUser;

          if (user != null && user.emailVerified) {
            // Email is verified, navigate to homepage
            Navigator.pushNamed(context, "homepage");
          } else {
            // Email is not verified
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please verify your email address.'), backgroundColor: Colors.red),
            );
            // Log out the user
            await _auth.signOut();
          }
        }
      } on FirebaseAuthException catch (e) {
        // Display raw error message from Firebase
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred.'), backgroundColor: Colors.red),
        );
      } catch (e) {
        // Display raw error message for unexpected errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    var widthX = MediaQuery.of(context).size.width;
    var heightX = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.only(
                left: widthX * 0.01,
                right: widthX * 0.01,
              ),
              child: Form(
                key: _formKey, // Attach form key to validate inputs
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
                    Container(
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "Email address",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Container(
                        child: TextFormField(
                          controller: _emailController, // Capture email input
                          decoration: InputDecoration(
                              hintText: "example@lus.ac.bd",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          // Validate email input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Container(
                        child: TextFormField(
                          controller: _passwordController, // Capture password input
                          obscureText: true, // Hide password characters
                          decoration: InputDecoration(
                              hintText: '*********',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          // Validate password input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "forgetpass");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Text(
                              "Forget Password",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: SizedBox(
                        height: 45,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _loginUser, // Call the login method
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 19),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Don't have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "signup1");  // Navigate to signup page
                        },
                        child: Text("Sign Up", style: TextStyle(fontSize: 19)),
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
