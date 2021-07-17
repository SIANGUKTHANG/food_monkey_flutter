import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: Constants.cartProducts.length,
                  itemBuilder: (context, index) =>
                      _buildCartProduct(Constants.cartProducts[index])),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Constants.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sub Total : ",
                          style: TextStyle(
                              color: Constants.primary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 20),
                      Text("${Constants.getCartTotal()} Ks",
                          style: Constants.getTitleTextStyle(30)),
                    ],
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                      onPressed: () {
                        if (Constants.user == null) {
                          Navigator.pushNamed(context, "/login");
                        } else {
                          print("Upload Order Now");
                        }
                      },
                      color: Constants.normal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Order Now",
                            style: TextStyle(
                                color: Constants.primary,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ))
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildCartProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Stack(overflow: Overflow.visible, children: [
        Card(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(Constants.changeImage(product.images?[0]),
                  width: 120, height: 120),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(product.name ?? "",
                      style: Constants.getTitleTextStyle(30)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Constants.normal,
                                  fontFamily: 'English'),
                              children: [
                            TextSpan(text: "Price ${product.price}\n"),
                            TextSpan(
                                text:
                                    "Total ${(product.price ?? 0) * product.count}")
                          ])),
                      SizedBox(width: 30),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                Constants.reduceProductCount(product);
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Constants.normal,
                                  shape: BoxShape.circle),
                              child:
                                  Icon(Icons.remove, color: Constants.primary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Text(
                                product.count.toString().padLeft(2, "0"),
                                style: TextStyle(fontSize: 20)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Constants.addProductCount(product);
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Constants.normal,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.add, color: Constants.primary),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: -10,
          child: InkWell(
            onTap: () {
              setState(() {
                Constants.removeProduct(product);
              });
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Constants.accent, shape: BoxShape.circle),
              child: Icon(Icons.clear, color: Constants.primary),
            ),
          ),
        ),
      ]),
    );
  }
}
