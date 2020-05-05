import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerapp/DataLayer/Product.dart';
import 'package:customerapp/UI/screens/silver_container.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/shared_data.dart';

class ProductDetailsScreen extends StatefulWidget {
  Product product;
  ProductDetailsScreen({this.product});
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Builder(
          builder: (context) => new SliverContainer(
                  floatingActionButton: Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: sharedData.mainColor,
                        size: 40,
                      ),
                    ),
                  ),
                  expandedHeight: 256.0,
                  slivers: <Widget>[
                    new SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.white),
                      expandedHeight: 256.0,
                      backgroundColor: sharedData.mainColor,
                      pinned: true,
                      flexibleSpace: new FlexibleSpaceBar(
                        title: new Text(
                          widget.product.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        background: CachedNetworkImage(
                          imageUrl: widget.product.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    new SliverList(
                      delegate: new SliverChildListDelegate(
                        new List.generate(1, (int index) {
                          return Container(
                            margin: EdgeInsets.all(15),
                            width: double.infinity,
                            height: 650,
                            child: Column(
                              children: <Widget>[
                                Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        side: new BorderSide(
                                            color: Colors.blue.withOpacity(0.3),
                                            width: 0.5),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    child: Container(
                                      height: 150,
                                      margin: EdgeInsets.all(20),
                                      child: Center(
                                        child: Text(
                                          widget.product.title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )),
                                Text(
                                  "قدم لنا عرض بيع علي هذا الصنف  ",
                                  style: TextStyle(
                                      color: sharedData.mainColor,
                                      fontWeight: FontWeight.normal),
                                ),
                                buildPriceItem(),
                                buildQuantityItem(),
                                buildValidToItem(),
                                buildNotesItem(),
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            child: Image.asset(
                                              'assets/images/btn_orange.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "أرسل عرضك لنا",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ])),
    );
  }

  Widget buildPriceItem() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: 170,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Colors.blue.withOpacity(0.3), width: 0.5),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: TextField(
                focusNode: FocusNode(),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "اكتب السعر",
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(right: 12.0)),
              ),
            ),
          ),
          Text(
            "السعر",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget buildQuantityItem() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: 170,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Colors.blue.withOpacity(0.3), width: 0.5),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: TextField(
                focusNode: FocusNode(),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "اكتب الكمية",
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(right: 12.0)),
              ),
            ),
          ),
          Text(
            "الكمبة",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
  Widget buildValidToItem() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: 170,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Colors.blue.withOpacity(0.3), width: 0.5),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: TextField(
                focusNode: FocusNode(),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "حدد تاريخ الصلاحية",
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(right: 12.0)),
              ),
            ),
          ),
          Text(
            "صلاحية العرض لغاية",
            textAlign: TextAlign.right,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget buildNotesItem() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: 170,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Colors.blue.withOpacity(0.3), width: 0.5),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: TextField(
                focusNode: FocusNode(),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "اكتب ملاحظاتك",
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(right: 12.0)),
              ),
            ),
          ),
          Text(
            "ملاحظات",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }


}
