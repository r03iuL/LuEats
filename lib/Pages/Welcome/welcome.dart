// ignore_for_file: prefer_const_constructors, implementation_imports, sort_child_properties_last, avoid_unnecessary_containers, camel_case_types
import 'package:flutter/material.dart';
import '../Authentication/sign_up.dart';
import '../Authentication/log_in.dart';

// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var widthX = MediaQuery.of(context).size.width;
    var heightX = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      child: Center(
                        child: Image.asset('assets/images/Illustartion2.png'),
                      ),
                      height: 300,
                    ),
                    Container(
                      child: Text(
                        "Welcome to LuEats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 255, 139, 7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0), // Adjust the value as needed
                      child: Text(
                        "Your on campus food delivery system powered by Leading University Cafeteria.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20,
                            color: Colors.orangeAccent,
                          fontWeight: FontWeight.w400),

                      ),
                    ),


                    SizedBox(height: 30),
                    Container(
                      child: SizedBox(
                        height: 55,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()), // Changed to Login with PascalCase
                            );
                          },
                          child: Text("Login", style: TextStyle(fontSize: 19)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: SizedBox(
                        height: 55,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Signup()), // Changed to Signup with PascalCase
                            );
                          },
                          child: Text("Sign Up", style: TextStyle(fontSize: 19)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: SizedBox(
                        height: 55,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Signup()), // Changed to Signup with PascalCase
                            );
                          },
                          child: Text("Admin", style: TextStyle(fontSize: 19)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
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
