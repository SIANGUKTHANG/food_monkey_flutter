import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/pages/Preview.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class ProductPage extends StatefulWidget {
  final String? type, name;
  const ProductPage({Key? key, this.type, this.name}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(type, name);
}

class _ProductPageState extends State<ProductPage> {
  final String? type, name;
  _ProductPageState(this.type, this.name);

  int currentIndex = 0;
  bool isLoading = false;

  int pageNo = 0;
  List<Product> products = [];

  loadProduct() async {
    setState(() {
      isLoading = true;
    });
    List<Product> ps = await Api.getPagintatedProduct(pageNo);
    // await Future.delayed(Duration(seconds: 5));
    setState(() {
      products.addAll(ps);
      pageNo++;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$type : $name"),
          actions: [
            InkWell(
                onTap: () => Navigator.pushNamed(context, "/cart"),
                child: Constants.getCartAction(context, Constants.primary))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 30,
              padding: EdgeInsets.only(top: 3),
              // decoration: BoxDecoration(
              //   color: Constants.accent,
              // ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Constants.tags.length,
                  itemBuilder: (context, index) =>
                      _buildTitleTab(index, Constants.tags[index])),
            ),
            Expanded(
                child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  loadProduct();
                }
                return false;
              },
              child: _buildProductGrid(),
            )),
            Container(
              child: isLoading ? CircularProgressIndicator() : null,
            )
          ],
        ));
  }

  Widget _buildProductGrid() {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => _buildProductCard(products[index]));
  }

  Widget _buildProductCard(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Text(product.name ?? ""),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Preview(product: product)));
              },
              child: Image.network(
                Constants.changeImage(product.images?[0] ?? ""),
                width: 120,
                height: 120,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        Constants.addToCard(product);
                      });
                    },
                    child: Icon(Icons.shopping_cart,
                        color: Constants.accent, size: 26)),
                Text("${product.price.toString()} Ks",
                    style: TextStyle(
                      color: Constants.normal,
                      fontSize: 16,
                    )),
                Icon(Icons.remove_red_eye, color: Constants.accent, size: 26),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleTab(index, Tag tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(children: [
          Text(tag.name ?? "",
              style: TextStyle(color: Constants.normal, fontSize: 16)),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
                color: index == currentIndex
                    ? Constants.accent
                    : Colors.transparent),
          )
        ]),
      ),
    );
  }
}
