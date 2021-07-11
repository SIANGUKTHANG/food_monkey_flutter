import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:foodmonkey/helpers/ArchPainter.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/pages/Detail.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Preview extends StatefulWidget {
  final Product? product;
  const Preview({Key? key, this.product}) : super(key: key);

  @override
  _PreviewState createState() => _PreviewState(product);
}

class _PreviewState extends State<Preview> {
  Product? product;
  _PreviewState(this.product);
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Preview Page"),
          actions: [
            InkWell(
                onTap: () => Navigator.pushNamed(context, "/cart"),
                child: Constants.getCartAction(context, Constants.primary))
          ],
        ),
        body: Stack(
          children: [
            CustomPaint(
              painter: ArchPainter(msize),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Bug Burger",
                      style: Constants.getTitleTextStyle(40)),
                ),
                SizedBox(height: 20),
                Container(
                  height: 150,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        Constants.changeImage(product?.images?[index] ?? ""),
                        fit: BoxFit.contain,
                      );
                    },
                    itemCount: product?.images?.length ?? 0,
                    pagination: SwiperPagination(),
                    control: SwiperControl(),
                  ),
                ),
                SizedBox(height: 40),
                _buildRichText("Price", "\t\t\t\t\t\t\t\t\t3500 Ks"),
                SizedBox(height: 20),
                _buildRichText("Size", "\t\t\t\t\t\t\t\t\tLarge Size"),
                SizedBox(height: 20),
                _buildRichText("Promo", "\t\t\t\t\t\t\t\t\tCoca Cola"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            Constants.addToCard(product);
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(80))),
                        color: Constants.normal,
                        child: Container(
                          width: 160,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.shopping_cart,
                                  color: Constants.primary, size: 40),
                              Text("Buy Now",
                                  style: TextStyle(
                                      color: Constants.primary, fontSize: 25))
                            ],
                          ),
                        )),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(product: product)));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(80))),
                        color: Constants.normal,
                        child: Container(
                            width: 100,
                            height: 60,
                            child: Center(
                              child: Text("Detail",
                                  style: TextStyle(
                                      color: Constants.primary, fontSize: 25)),
                            )))
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget _buildRichText(text1, text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "$text1\n",
            style: TextStyle(
                fontSize: 45, color: Constants.primary, fontFamily: "English")),
        TextSpan(
            text: "$text2",
            style: TextStyle(
                fontSize: 18, color: Constants.normal, fontFamily: "English"))
      ])),
    );
  }
}
