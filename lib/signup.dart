// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
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
                parent: AlwaysScrollableScrollPhysics()
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: widthX * 0.01,
                  right: widthX * 0.01,
                ),
                child: Column(
                  children: [
                    
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Sign UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 139, 7),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "Full Name",
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
                              hintText: 'Enter Your Name',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
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
                              hintText: 'anything@gmail.com',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                          decoration: InputDecoration(
                              hintText: '**************',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),
                    
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "Mobile",
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
                              hintText: 'Enter Your Number',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: SizedBox(
                        height: 45,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Action diye dio
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: SizedBox(
                        height: 45,
                        width: 300,
                        child: InkWell(
                          onTap: () {
                            
                          },
                          child: Ink(
                            color: Color.fromARGB(255, 238, 238, 240),
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Align(
                                alignment: Alignment.center,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage('assets/google.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Login with Google',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
