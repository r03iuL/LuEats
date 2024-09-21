import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/Cart/cart_provider.dart';

class CartBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "\৳${cartProvider.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (cartProvider.items.isEmpty) {
                      // Show SnackBar if the cart is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Your cart is empty. Please add items to place an order.')),
                      );
                      return;
                    }

                    final cartItems = cartProvider.items;
                    final userId = FirebaseAuth.instance.currentUser?.uid;

                    // Fetch user details from Firestore
                    final userDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .get();

                    final userData = userDoc.data();

                    if (userData == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('User details not found. Cannot place order.')));
                      return;
                    }

                    // Create the order data
                    final orderData = {
                      'items': cartItems
                          .map((item) => {
                        'name': item.name,
                        'quantity': item.quantity,
                        'price': item.price,
                        'totalPrice': item.price * item.quantity,
                      })
                          .toList(),
                      'totalAmount': cartProvider.totalAmount,
                      'orderedAt': Timestamp.now(),
                      'userId': userId,
                      'userName': userData['name'],
                      'designation': userData['designation'],
                      'department': userData['department'],
                      'phone': userData['phone'],
                      'room': userData['room'],
                      'floor': userData['floor'],
                      'building': userData['building'],
                    };

                    try {
                      await FirebaseFirestore.instance.collection('Orders').add(orderData);
                      cartProvider.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order placed successfully!')));
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to place order. Please try again.')));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(cartProvider.items.isEmpty ? Colors.grey : Colors.red),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                  child: Text(
                    "Order Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
