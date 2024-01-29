// ignore_for_file: prefer_const_constructors, implementation_imports, sort_child_properties_last, avoid_unnecessary_containers, camel_case_types

import 'package:chotop/login.dart';
import 'package:chotop/signup.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
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
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: EdgeInsets.only(
                  left: widthX * 0.01,
                  right: widthX * 0.01,
                ),
                child: Column(children: [
                  SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Welcome to LuEats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 139, 7),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                        child: Image(
                            image: AssetImage('assets/Illustartion2.png'))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: SizedBox(
                      height: 55,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push( context,
                            MaterialPageRoute(
                                builder: (context) => const login()),
                          );
                        },
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
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: SizedBox(
                      height: 55,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push( context,
                            MaterialPageRoute(
                                builder: (context) => const signup()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 19),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
