import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Track loading state

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        User? user = userCredential.user;
        if (user != null) {
          await user.reload();
          user = _auth.currentUser;

          if (user != null && user.emailVerified) {
            Navigator.pushNamed(context, "homepage");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please verify your email address.'), backgroundColor: Colors.red),
            );
            await _auth.signOut();
          }
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred.'), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
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
              padding: EdgeInsets.only(left: widthX * 0.01, right: widthX * 0.01),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      child: Center(child: Image(image: AssetImage('assets/images/Illustration.jpg'))),
                      height: 250,
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.deepOrange, fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text("Email address", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Container(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: "example@lus.ac.bd",
                              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
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
                          child: Text("Password", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Container(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: '*********',
                              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
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
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
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
                          onPressed: _isLoading ? null : _loginUser, // Disable button when loading
                          child: _isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                              : Text("Login", style: TextStyle(fontSize: 19)),
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
                          Navigator.pushNamed(context, "signup1");
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
