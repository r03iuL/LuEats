import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget{



  @override
  Widget build(BuildContext context){


    return Drawer(

      child: Column(
        children: [

        DrawerHeader(
          padding: EdgeInsets.zero,

          child: UserAccountsDrawerHeader(
            decoration:BoxDecoration(
              color: Colors.deepOrange,

            ) ,
            currentAccountPicture:CircleAvatar(
              backgroundImage: AssetImage("assets/images/l1.png",),


            ),


            accountName: Text("            LuEATS",
              style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),),
            accountEmail: Text("              01778958475",
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold),

            ),

          ),
          ),



          SizedBox(
            height: 30,
          ),
          //List Tittle
          ListTile(
            leading: Icon(CupertinoIcons.home,color: Colors.green,
            ),
            title: Text("Home", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

            ),),
            onTap: () {
              Navigator.pushNamed(context, "homepage");
            },
          ),

          //List Tittle
          ListTile(
            leading: Icon(CupertinoIcons.person,color: Colors.green,
            ),
            title: Text("Account", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

            ),),
            onTap: () {
              Navigator.pushNamed(context, "loginpage");
            },
          ),
          //List Tittle
          ListTile(
            leading: Icon(CupertinoIcons.cart_fill_badge_plus,color: Colors.green,
            ),
            title: Text("Order", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

            ),),
            onTap: () {
              Navigator.pushNamed(context, "cartPage");
            },
          ),

          //List Tittle
          ListTile(
            leading: Icon(Icons.money,color: Colors.green,
            ),
            title: Text("Money Section", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

            ),),
            onTap: () {
              Navigator.pushNamed(context, "moneyPage");
            },
          ),
          //List Tittle
          ListTile(
            leading: Icon(Icons.settings,color: Colors.green,
            ),
            title: Text("Settings", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            onTap: () {
              Navigator.pushNamed(context, "signup1");
            },
          ),
          //List Tittle
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded,color: Colors.green,
            ),
            title: Text("Log Out", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

            ),),
          ),
      ],),
    );
  }

}
