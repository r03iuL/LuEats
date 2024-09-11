// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<Forgetpass> {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      child: Text(
                        "Forget Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 30),

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
                          decoration: InputDecoration(
                              hintText: 'name@gmail.com',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
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
                            "New password",
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
                          decoration: InputDecoration(
                              hintText: '...........',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
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
                            "Confirm new password",
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
                          decoration: InputDecoration(
                              hintText: '...........',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),




                    SizedBox(height: 50),


                    Container(
                      child: SizedBox(
                        height: 45,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "resetpassword");
                          },
                          child: Text(
                            "Reset",
                            style: TextStyle(fontSize: 19),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                        ),
                      ),
                    ),


                    SizedBox(height: 40),
                    Container(
                      child: Text(
                        "Remembered your password? Click to login",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        height: 45,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "login1");
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
