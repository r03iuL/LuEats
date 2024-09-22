import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Widgets/food_items_grid_widget.dart';

class FoodItemsByCategoryPage extends StatelessWidget {
  final String categoryName;

  FoodItemsByCategoryPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Query to get food items for the selected category
    Query foodQuery = FirebaseFirestore.instance
        .collection('Food_items')
        .where('category', isEqualTo: categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food in $categoryName',
          style: TextStyle(
              fontSize: 24, // Adjust the font size
              fontWeight: FontWeight.bold, // Adjust the font weight
              color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FoodItemsGrid(
          foodQuery: foodQuery,
          onItemTap: (foodData) {
            // Navigate to order page or handle item tap action
            Navigator.pushNamed(context, "orderpage", arguments: foodData);
          },
        ),
      ),
    );
  }
}
