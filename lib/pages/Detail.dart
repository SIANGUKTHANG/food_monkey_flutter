import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Detail extends StatefulWidget {
  final Product? product;
  const Detail({Key? key, this.product}) : super(key: key);

  @override
  _DetailState createState() => _DetailState(product);
}

class _DetailState extends State<Detail> {
  Product? product;
  _DetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
          actions: [
            InkWell(
                onTap: () => Navigator.pushNamed(context, "/cart"),
                child: Constants.getCartAction(context, Constants.primary))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product?.name ?? "",
                        style: Constants.getTitleTextStyle(40)),
                    InkWell(
                        onTap: () {
                          setState(() {
                            Constants.addToCard(product);
                          });
                        },
                        child: Constants.getCartAction(
                            context, Constants.secondary))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRichText(
                        "Price", "\t\t\t\t\t\t\t${product?.price} Ks"),
                    _buildRichText("Size", "\t\t\t\t\t\t\t${product?.size}"),
                    _buildRichText(
                        "Promo", "\t\t\t\t\t\t\t${product?.discount} Ks"),
                  ],
                ),
                SizedBox(height: 20),
                Text(Constants.sampleText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Constants.normal, fontSize: 16)),
                SizedBox(height: 20),
                Table(
                  border: TableBorder.all(color: Constants.normal),
                  children: [
                    TableRow(children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Feature",
                              style: TextStyle(
                                color: Constants.accent,
                                fontSize: 20,
                              )),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Value",
                              style: TextStyle(
                                color: Constants.accent,
                                fontSize: 20,
                              )),
                        ),
                      ),
                    ]),
                    _buidTableRow("Size", "Large Size"),
                    _buidTableRow("Parcel", "Plastic Bag"),
                    _buidTableRow("Size", "Large Size"),
                    _buidTableRow("Parcel", "Plastic Bag"),
                  ],
                ),
                SizedBox(height: 20),
                Text(Constants.sampleText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Constants.normal, fontSize: 16)),
                SizedBox(height: 20),
                Center(
                    child: Text("Delivery",
                        style: Constants.getTitleTextStyle(20))),
                Image.network(Constants.sampleImg1),
                SizedBox(height: 20),
                Center(
                    child: Text("Warranty",
                        style: Constants.getTitleTextStyle(20))),
                Image.network(Constants.sampleImg1),
              ],
            ),
          ),
        ));
  }

  TableRow _buidTableRow(f, v) {
    return TableRow(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(f,
              style: TextStyle(
                color: Constants.normal,
                fontSize: 16,
              )),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(v,
              style: TextStyle(
                color: Constants.normal,
                fontSize: 16,
              )),
        ),
      ),
    ]);
  }

  Widget _buildRichText(text1, text2) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "$text1\n",
          style: TextStyle(
              fontSize: 30, color: Constants.normal, fontFamily: "English")),
      TextSpan(
          text: "$text2",
          style: TextStyle(
              fontSize: 16,
              color: Constants.accent,
              fontFamily: "English",
              fontWeight: FontWeight.bold))
    ]));
  }
}
