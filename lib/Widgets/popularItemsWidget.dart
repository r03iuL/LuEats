import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';


class  popularItemsWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return SingleChildScrollView( 
      scrollDirection: Axis.horizontal,
      child:
      Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child:  Row(children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            width: 170,
            height: 225,
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "orderburger");
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/images.png",
                        height: 130,
                      ),
                    ),
                  ),
                  Text(
                    "Hot Burger",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Test our hot burger",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\৳60",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "orderburger");
                        },
                        child: Icon(
                          CupertinoIcons.cart,
                          color: Colors.blue,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),




        //single item
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            width: 170,
            height: 225,
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "ordermojo");
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/mojo.png",
                        height: 130,
                      ),
                    ),
                  ),
                  Text(
                    "MOJO",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Soft drinks",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\৳20",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "ordermojo");
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
        ),

        //single item
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            width: 170,
            height: 225,
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "orderkhicuri");
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/khicuri.png",
                        height: 130,
                      ),
                    ),
                  ),
                  Text(
                    "Khichuri",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Test our hot khichuri",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\৳50",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "orderkhicuri");
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
        ),



        //single item
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            width: 170,
            height: 225,
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "orderbiriyani");
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/biriyani.png",
                        height: 130,
                      ),
                    ),
                  ),
                  Text(
                    "Chicken Biriyani",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Test our hot Biriyani",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\৳100",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "orderbiriyani");
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
        ),


//single item
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Container(
            width: 170,
            height: 225,
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "orderpizza");
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/pizza.png",
                        height: 130,
                      ),
                    ),
                  ),
                  Text(
                    "Pizza",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Test our hot pizza",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\৳150",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "orderpizza");
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
        )



      ],
      ),
      ),

    );
  }
}