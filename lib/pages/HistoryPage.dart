import 'package:flutter/material.dart';
import 'package:foodmonkey/models/History.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History> hs = [];
  _loadHistoryProducts() async {
    List<History> hss = await Api.getMyOrders();
    setState(() {
      hs = hss;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHistoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      _buildCustomNav(),
      Expanded(
          child: ListView.builder(
              itemCount: hs.length,
              itemBuilder: (context, index) => _buildOrder(hs[index])))
    ]));
  }

  Widget _buildCustomNav() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Constants.accent,
          ),
        )
      ]),
    );
  }

  Widget _buildOrder(History history) {
    return Container(
      color: Constants.normal,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(history.created?.split("T")[0] ?? "",
                style: TextStyle(color: Constants.primary)),
            RaisedButton(
                onPressed: () {},
                color: Constants.normal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(history.total.toString(),
                    style: TextStyle(color: Constants.primary)))
          ],
        ),
        children: [
          ...List.generate(history.items?.length ?? 0,
              (index) => _buildItemCard(history.items?[index]))
        ],
      ),
    );
  }

  Widget _buildItemCard(var item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Constants.accent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              Constants.changeImage(item.images[0]),
              width: 80,
              height: 80,
            ),
            Column(
              children: [
                Text(item.name,
                    style: TextStyle(color: Constants.primary, fontSize: 20)),
                Text("${item.price} * ${item.count}",
                    style: TextStyle(color: Constants.primary, fontSize: 14))
              ],
            ),
            RaisedButton(
                onPressed: () {},
                color: Constants.normal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text("${item.price * item.count}",
                    style: TextStyle(color: Constants.primary)))
          ],
        ),
      ),
    );
  }
}
