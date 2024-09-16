import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lueats1/Pages/Welcome/welcome.dart';
import 'Pages/Authentication/forgot_pass.dart';
import 'Pages/Welcome/splash_screen.dart';
import 'Pages/Authentication/sign_up.dart';
import 'Pages/Authentication/log_in.dart';
import 'Pages/Cart/cart_page.dart';
import 'Pages/HomePage/home_page.dart';
import 'Pages/MoneyPage.dart';
import 'Pages/Itemsingara.dart';
import 'Pages/Itemsomuca.dart';
import 'Pages/Orderbreakfast.dart';
import 'Pages/Orderdrinks.dart';
import 'Pages/Ordertea.dart';
import 'Pages/Lunch/order_lunch.dart';
import 'Pages/Orderpizza.dart';
import 'Pages/Orderbiriyani.dart';
import 'Pages/Orderburger.dart';
import 'Pages/Ordercupnoodles.dart';
import 'Pages/Ordermojo.dart';
import 'Pages/Orderkhicuri.dart';
import 'Pages/Admin/add_food.dart';
import 'Pages/Admin/add_category.dart';
import 'Pages/Admin/add_lunch.dart';

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
        "welcome": (context) => Welcome(),
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
        "forgetpass": (context) => Forgetpass(),
        "addfood": (context) => AddFood(),
        "addfood": (context) => AddFood(),
        "addlunch": (context) => AddLunch(),
        "addcategory": (context) => AddCategory(),


      },
    );
  }
}
