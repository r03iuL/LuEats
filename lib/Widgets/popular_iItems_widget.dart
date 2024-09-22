import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../Pages/Food/food_details.dart';
import '../Pages/Cart/cart_provider.dart';

class PopularItemsWidget extends StatelessWidget {
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
      stream: FirebaseFirestore.instance
          .collection('Food_items')
          .where('popularity', isEqualTo: 'Popular')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No popular items found.'));
        }

        final popularItems = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Row(
              children: popularItems.map((doc) {
                final foodData = doc.data() as Map<String, dynamic>;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Container(
                    width: 170,
                    height: 230,
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
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodDetailsPage(
                                    imageUrl: foodData['image'] ?? 'assets/images/default_image.png',
                                    name: foodData['name'] ?? 'No Name Available',
                                    description: foodData['description'] ?? 'No Description Available',
                                    price: convertToDouble(foodData['price']),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: Image.network(
                                foodData['image'] ?? 'assets/images/default_image.png',
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            foodData['name'] ?? 'No Name Available',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "৳${convertToDouble(foodData['price'])}",
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
                                    price: convertToDouble(foodData['price']),
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
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
