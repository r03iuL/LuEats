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
                      // Dynamically show total amount
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
                    final cartItems = cartProvider.items;
                    final userId = FirebaseAuth.instance.currentUser?.uid;

                    // Step 1: Fetch user details from Firestore
                    final userDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .get();

                    final userData = userDoc.data();

                    if (userData == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'User details not found. Cannot place order.')));
                      return;
                    }

                    // Step 2: Create the order data, including user details
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
                      'userName': userData['name'], // User's name
                      'designation': userData['designation'], // User's designation
                      'department': userData['department'], // User's department
                      'phone': userData['phone'], // User's phone number
                      'room': userData['room'], // User's room number
                      'floor': userData['floor'], // User's floor
                      'building': userData['building'], // User's building
                    };

                    try {
                      // Step 3: Save the order to Firestore (under a collection 'Orders')
                      await FirebaseFirestore.instance
                          .collection('Orders')
                          .add(orderData);

                      // Step 4: Clear the cart after the order is placed
                      cartProvider.clearCart();

                      // Step 5: Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Order placed successfully!')));

                      // Step 6: Send notification to admin (if implemented)
                      // await sendNotificationToAdmin();
                    } catch (error) {
                      // Handle errors (e.g., show an error message)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Failed to place order. Please try again.')));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
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
