import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Widgets/drawer_widget.dart';
import '../Cart/cart_provider.dart';

class OrderLunchPage extends StatefulWidget {
  @override
  _OrderLunchPageState createState() => _OrderLunchPageState();
}

class _OrderLunchPageState extends State<OrderLunchPage> {
  int quantity = 1;
  bool isLoading = true;
  Map<String, dynamic>? lunchData;

  @override
  void initState() {
    super.initState();
    fetchLunchDetails(); // Fetch the only lunch document details
  }

  Future<void> fetchLunchDetails() async {
    try {
      // Fetch the first (and only) document from the 'lunch_items' collection
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('lunch_item')
          .limit(1) // As we know there is only one document
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot document = snapshot.docs.first;

        setState(() {
          lunchData = document.data() as Map<String, dynamic>?;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("No lunch items found.");
      }
    } catch (e) {
      print("Error fetching lunch details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading..."),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (lunchData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Lunch Details"),
        ),
        body: Center(
          child: Text("Error loading lunch details."),
        ),
      );
    }

    // Retrieve lunch details from Firestore data
    String imageUrl = lunchData!['image'] ?? '';
    String name = lunchData!['name'] ?? 'Lunch';
    String description = lunchData!['description'] ?? '';
    double price = double.tryParse(lunchData!['price']?.toString() ?? '0') ?? 0.0;

    double totalPrice = price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_image.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Arc(
                    edge: Edge.TOP,
                    arcType: ArcType.CONVEY,
                    height: 30,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 60, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "৳${price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(CupertinoIcons.minus,
                                              color: Colors.white, size: 15),
                                          onPressed: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                            }
                                          },
                                        ),
                                        Text(
                                          "$quantity",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(CupertinoIcons.plus,
                                              color: Colors.white, size: 15),
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 25),
                                child: SingleChildScrollView(
                                  child: Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total: ৳${totalPrice.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      final cartProvider =
                                      Provider.of<CartProvider>(context,
                                          listen: false);
                                      cartProvider.addItem(CartItem(
                                        name: name,
                                        imageUrl: imageUrl,
                                        description: description,
                                        price: price,
                                        quantity: quantity,
                                      ));
                                      Navigator.pushNamed(context, "cartPage");
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 15),
                                      ),
                                    ),
                                    icon: Icon(CupertinoIcons.cart,
                                        color: Colors.white),
                                    label: Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }
}
