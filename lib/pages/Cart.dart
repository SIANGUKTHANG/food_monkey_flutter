import 'package:flutter/material.dart';
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
                      Text(Constants.cartProducts[index]?.name ?? "")),
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
                      Text("350,000 Ks",
                          style: Constants.getTitleTextStyle(30)),
                    ],
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                      onPressed: () {},
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
}
