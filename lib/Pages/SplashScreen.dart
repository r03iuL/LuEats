import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to signup page after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushNamed(context, "signup1");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/splash.png",
              height: 800,
              width: 350,
            ),
          ),
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ), // Buffering sign
          ),
        ],
      ),
    );
  }
}
