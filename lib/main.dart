import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/Authentication/Forgetpass.dart';
import 'Pages/Welcome/SplashScreen.dart';
import 'Pages/Authentication/Signup.dart';
import 'Pages/Authentication/Login.dart';
import 'Pages/Cart/CartPage.dart';
import 'Pages/HomePage/HomePage.dart';
import 'Pages/MoneyPage.dart';
import 'Pages/Itemsingara.dart';
import 'Pages/Itemsomuca.dart';
import 'Pages/Orderbreakfast.dart';
import 'Pages/Orderdrinks.dart';
import 'Pages/Ordertea.dart';
import 'Pages/Orderlunch.dart';
import 'Pages/Orderpizza.dart';
import 'Pages/Orderbiriyani.dart';
import 'Pages/Orderburger.dart';
import 'Pages/Ordercupnoodles.dart';
import 'Pages/Ordermojo.dart';
import 'Pages/Orderkhicuri.dart';
import 'Pages/Authentication/Storeinfopage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyAUPZMOwewwxKJf1wbm67RkFD4oToSD7H8',
        appId: '1:222637984390:android:72bbec3611a46ae49fdf07',
        messagingSenderId: '222637984390',
        projectId: 'lueats-cde05',
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F3),
      ),
      routes: {
        "/": (context) => SplashScreen(),
        "signup1": (context) => Signup(),
        "login1": (context) => Login(),
        "homepage": (context) => HomePage(),
        "moneyPage":(context) => MoneyPage(),
        "cartPage": (context) => CartPage(),
        "itemsingara": (context) => Itemsingara(),
        "itemsomuca": (context) => Itemsomuca(),
        "orderbreakfast": (context) => Orderbreakfast(),
        "orderdrinks": (context) => Orderdrinks(),
        "ordertea": (context) => Ordertea(),
        "orderlunch": (context) => Orderlunch(),
        "orderpizza": (context) => Orderpizza(),
        "orderbiriyani": (context) => Orderbiriyani(),
        "orderburger": (context) => Orderburger(),
        "ordercupnoodles": (context) => Ordercupnoodles(),
        "ordermojo": (context) => Ordermojo(),
        "orderkhicuri": (context) => Orderkhicuri(),
        "storeinfo": (context) => StoreinfoPage(),
        "forgetpass": (context) => Forgetpass(),


      },
    );
  }
}
