import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart'; // Import Provider for cart functionality
import '../Pages/food_details.dart'; // Import the FoodDetailsPage
import '../Pages/Cart/cart_provider.dart'; // Import CartProvider for managing cart items

class FoodItemsGrid extends StatelessWidget {
  final Query foodQuery;
  final void Function(Map<String, dynamic> foodData)? onItemTap;

  FoodItemsGrid({required this.foodQuery, this.onItemTap});

  double convertToDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is num) {
      return value.toDouble();
    } else {
      return 0.0;
    }
  }

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
          physics: NeverScrollableScrollPhysics(),
          itemCount: foodItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            childAspectRatio: 10 / 13,
          ),
          itemBuilder: (context, index) {
            final foodData = foodItems[index].data() as Map<String, dynamic>;

            final price = convertToDouble(foodData['price']);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailsPage(
                      imageUrl: foodData['image'],
                      name: foodData['name'],
                      description: foodData['description'],
                      price: price,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodDetailsPage(
                                  imageUrl: foodData['image'],
                                  name: foodData['name'],
                                  description: foodData['description'],
                                  price: price,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            foodData['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        foodData['name'],
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
                            "৳${price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final cartProvider = Provider.of<CartProvider>(context, listen: false);

                              final cartItem = CartItem(
                                name: foodData['name'] ?? 'No Name Available',
                                imageUrl: foodData['image'] ?? 'assets/images/default_image.png',
                                description: foodData['description'] ?? 'No Description Available',
                                price: price,
                                quantity: 1,
                              );

                              cartProvider.addItem(cartItem);

                              // Show Snackbar notification
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${foodData['name']} added to cart!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
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
