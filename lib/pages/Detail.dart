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
        appBar: AppBar(title: Text("Detail")),
        body: Column(
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
          ],
        ));
  }
}
