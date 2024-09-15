import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class CatagoriesWidget extends StatelessWidget{




  @override
  Widget build(BuildContext context){


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
      Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child:  Row(children: [


          // for(int i=0;i<10;i++)
          //single item
          Padding(padding: EdgeInsets.symmetric(horizontal: 7),
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
                      offset:  Offset(0,3),
                    ),
                  ]
              ),

              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell (
                      onTap: (){
                        Navigator.pushNamed(context, "orderbreakfast");
                      },
                      child: Container(
                        // alignment: Alignment.center,
                        child: Image.asset("assets/images/brekfast.png",
                          height: 130,
                        ),
                      ),
                    ),
                    Text("Breakfast",
                      style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,),
                    ),

                    SizedBox(height: 4),
                    Text("Click on picture for order.",
                      style: TextStyle(fontSize: 10,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\৳100",style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),),

                        Icon(
                            Icons.favorite,
                            color: Colors.deepOrange,size: 26),

                      ],),
                  ],
                ),
              ),
            ),
          ),

          //single item
          Padding(padding: EdgeInsets.symmetric(horizontal: 7),
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
                      offset:  Offset(0,3),
                    ),
                  ]
              ),

              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell (
                      onTap: (){
                        Navigator.pushNamed(context, "ordertea");
                      },
                      child: Container(
                        // alignment: Alignment.center,
                        child: Image.asset("assets/images/tea.png",
                          height: 130,
                        ),
                      ),
                    ),
                    Text("Tea",
                      style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,),
                    ),

                    SizedBox(height: 4),
                    Text("Click on picture for order.",
                      style: TextStyle(fontSize: 10,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\৳10",style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),),

                        Icon(
                            Icons.favorite,
                            color: Colors.deepOrange,size: 26),

                      ],),
                  ],
                ),
              ),
            ),
          ),


          //single item
          Padding(padding: EdgeInsets.symmetric(horizontal: 7),
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
                      offset:  Offset(0,3),
                    ),
                  ]
              ),

              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell (
                      onTap: (){
                        Navigator.pushNamed(context, "orderdrinks");
                      },
                      child: Container(
                        // alignment: Alignment.center,
                        child: Image.asset("assets/images/drinks.png",
                          height: 130,
                        ),
                      ),
                    ),
                    Text("Drinks",
                      style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,),
                    ),

                    SizedBox(height: 4),
                    Text("Click on picture for order.",
                      style: TextStyle(fontSize: 10,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\৳20",style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),),

                        Icon(
                            Icons.favorite,
                            color: Colors.deepOrange,size: 26),

                      ],),
                  ],
                ),
              ),
            ),
          ),

        ],
        ),
      ),

    );

  }
}