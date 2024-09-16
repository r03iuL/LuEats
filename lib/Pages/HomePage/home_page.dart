import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/NewestItemsWidget.dart';
import '../../Widgets/app_bar_widget.dart';
import '../../Widgets/categories_widget.dart';
import '../../Widgets/drawer_widget.dart';
import '../../Widgets/food_items_grid_widget.dart';
import '../../Widgets/popular_iItems_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // custom app bar
          AppBarWidget(),

          SizedBox(height: 20),

          // Banner with gradient background
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            // Add padding from the sides
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
            // Add padding top and bottom
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0), // Rounded corners
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange], // Gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    // Padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Exclusive launch package only for you.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "orderlunch");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Background color
                            foregroundColor: Colors.red, // Text color
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            "Order Now!",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 0),
                  // Padding inside the container
                  child: Image.asset(
                    'assets/images/launch.png', // Replace with your image path
                    height: 120, // Adjust height as needed
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

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
          CategoriesWidget(),

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
          PopularItemsWidget(),

          //newest Items
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10),
            child: Text(
              "All Items",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
        // SizedBox(height: 10,),
          //Food items widget
          FoodItemsGrid(
            foodQuery: FirebaseFirestore.instance.collection('Food_items'),
            onItemTap: (foodData) {
              // Navigate to food detail page when an item is tapped
              Navigator.pushNamed(context, "orderpage", arguments: foodData);
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ]),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "cartPage");
          },
          child: Icon(
            CupertinoIcons.cart,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrange,
        ),
      ),
    );
  }
}
