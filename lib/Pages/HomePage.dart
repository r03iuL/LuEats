import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/CategoriesWidget.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/NewestItemsWidget.dart';
import '../Widgets/popularItemsWidget.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // custom app bar
          AppBarWidget(),

          // search
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0,3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.deepOrange,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search Here .. ",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.filter_list),
                  ],
                ),
              ),
            ),
          ),

          // Category
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Catagories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),

          //Category Widget
          CatagoriesWidget(),

          // popular Items
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Popular",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
         //popular items widget
          popularItemsWidget(),

          //newest Items
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10),
            child: Text(
              "New Items",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),

          //new items widget
          NewestItemsWidget(),
        ],
      ),
      drawer:DrawerWidget(),


      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0,3),
            ),
          ]
        ),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, "cartPage");
          },
        child: Icon(CupertinoIcons.cart,
          size: 30,
          color: Colors.white,),

          backgroundColor: Colors.deepOrange,
        ),
      ),
    );
  }
}
