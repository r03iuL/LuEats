import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FoodItemsGrid extends StatelessWidget {
  final Query foodQuery; // This will allow us to pass different queries (e.g., for all foods or for specific categories)
  final void Function(Map<String, dynamic> foodData) onItemTap; // A callback function to handle item tap navigation

  FoodItemsGrid({required this.foodQuery, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: foodQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No food items found.'));
        }

        final foodItems = snapshot.data!.docs;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // To allow scrolling within a scrollable parent
          itemCount: foodItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Show items in two columns
            crossAxisSpacing: 0, // Horizontal margin between items
            mainAxisSpacing: 10, // Vertical margin between items
            childAspectRatio: 10 / 13, // Set the aspect ratio to match the desired size
          ),
          itemBuilder: (context, index) {
            final foodData = foodItems[index].data() as Map<String, dynamic>;

            return GestureDetector(
              onTap: () => onItemTap(foodData), // Call the provided callback function when an item is tapped
              child: Container(
                margin:EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10), // Padding inside the container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10), // Adjust vertical space above the image
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "orderpage", arguments: foodData);
                          },
                          child: Image.network(
                            foodData['image'], // Display the image from Firestore
                            fit: BoxFit.cover, // Ensure image covers the width of the container
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        foodData['name'], // Display the food name
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "৳${foodData['price']}", // Display the price
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "orderpage", arguments: foodData);
                            },
                            child: Icon(
                              CupertinoIcons.cart,
                              color: Colors.deepOrange,
                              size: 26,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
