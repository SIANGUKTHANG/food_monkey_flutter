import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/pages/Product.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Page")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleText(context, "Tags"),
            Container(
              height: 150,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Product(
                                  type: "Tag",
                                  name: Constants.tags[index].name)));
                    },
                    child: Image.network(
                      Constants.changeImage(Constants.tags[index].image ?? ""),
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: Constants.tags.length,
                pagination: SwiperPagination(),
                control: SwiperControl(),
              ),
            ),
            _buildTitleText(context, "Categories"),
            SizedBox(height: 20),
            GridView.builder(
                shrinkWrap: true,
                itemCount: Constants.cats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) =>
                    _buildCategoryCard(context, Constants.cats[index]))
          ],
        ));
  }

  Widget _buildCategoryCard(BuildContext context, Category cat) {
    return Container(
      child: Card(
        color: Constants.primary,
        child: Column(
          children: [
            SizedBox(height: 3),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Product(type: "Category", name: cat.name)));
                },
                child: Image.network(Constants.changeImage(cat.image ?? ""))),
            SizedBox(height: 3),
            Text(cat.name ?? "")
          ],
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context, String text) {
    return Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
          color: Constants.secondary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
      child: Text(text, style: Constants.getTitleTextStyle(30)),
    );
  }
}

  // child: Text(text,
      //     style: Theme.of(context).textTheme.headline6?.copyWith(
      //         color: Constants.normal,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 35)),