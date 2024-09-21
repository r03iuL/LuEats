import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/Admin/add_category.dart';
import 'Pages/Admin/add_food.dart';
import 'Pages/Admin/add_lunch.dart';
import 'Pages/Authentication/forgot_pass.dart';
import 'Pages/Authentication/log_in.dart';
import 'Pages/Authentication/sign_up.dart';
import 'Pages/Cart/cart_page.dart';
import 'Pages/Cart/cart_provider.dart'; // Import your CartProvider
import 'Pages/HomePage/home_page.dart';
import 'Pages/Lunch/order_lunch.dart';
import 'Pages/Profile/profile.dart';
import 'Pages/Profile/update_profile_page.dart';
import 'Pages/Welcome/splash_screen.dart';
import 'Pages/Welcome/welcome.dart';
import 'Pages/order_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAUPZMOwewwxKJf1wbm67RkFD4oToSD7H8',
      appId: '1:222637984390:android:72bbec3611a46ae49fdf07',
      messagingSenderId: '222637984390',
      projectId: 'lueats-cde05',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(), // Provide the CartProvider
      child: MaterialApp(
        title: "Food App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF5F5F3),
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => SplashScreen(),
          "signup1": (context) => Signup(),
          "login1": (context) => Login(),
          "homepage": (context) => HomePage(),
          "welcome": (context) => Welcome(),
          "cartPage": (context) => CartPage(),
          "forgetpass": (context) => Forgetpass(),
          "addfood": (context) => AddFood(),
          "addlunch": (context) => AddLunch(),
          "addcategory": (context) => AddCategory(),
          "profile": (context) => ProfilePage(),
          "editprofile": (context) => UpdateProfilePage(),
          "orderhistory": (context) => OrderHistoryPage(),
          "orderlunch": (context) => OrderLunchPage(),
        },
      ),
    );
  }
}
