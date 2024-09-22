import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Widgets/food_items_grid_widget.dart';

class SearchPage extends StatefulWidget {
  final String searchTerm;

  SearchPage({required this.searchTerm});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Stream<QuerySnapshot> foodQueryStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream for the food items collection
    foodQueryStream = FirebaseFirestore.instance.collection('Food_items').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Results",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodQueryStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No food items found.'));
          }

          final foodItems = snapshot.data!.docs;

          // Filter food items based on search term (case-insensitive)
          final filteredItems = foodItems.where((doc) {
            final foodData = doc.data() as Map<String, dynamic>;
            final name = foodData['name']?.toLowerCase() ?? '';
            return name.contains(widget.searchTerm.toLowerCase());
          }).toList();

          if (filteredItems.isEmpty) {
            return Center(child: Text('No matching food items found.'));
          }

          return FoodItemsGrid(
            foodQuery: FirebaseFirestore.instance.collection('Food_items').where(
              FieldPath.documentId,
              whereIn: filteredItems.map((doc) => doc.id).toList(),
            ),
            onItemTap: (foodData) {
              // Handle item tap
            },
          );
        },
      ),
    );
  }
}
