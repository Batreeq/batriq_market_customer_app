import 'package:customerapp/UI/wigets/ProductItemValue.dart';
import 'package:customerapp/models/PointsProducts.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class ReplacePoints extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReplacePoints();
  }
}

class _ReplacePoints extends State {
  BuildContext context;

  PointsProducts products;

  @override
  void initState() {
    super.initState();

    products = new PointsProducts();
    submitUserData();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: sharedData.appBar(context, 'استبدل نقاطي ', null, () {}),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (products.pointsProducts == null)
      return Container();
    else
      return buildGridList(context);
  }

  submitUserData() async {
    var response;
    print('i\'m in submit method ');
    response = await Requests.get(
      sharedData.pointsProductsUrl,
    );

    if (response != null) {
      print(response.json());
      print(response.statusCode);
    } else
      print('response is null');

    sharedData.showLoadingDialog(context); //invoking login
    await Future.delayed(Duration(seconds: 3));

    if (response.statusCode == 200) {
      response.raiseForStatus();
      dynamic json = response.json();

      setState(() {
        products = PointsProducts.fromJson(json);
      });
      if (null != products) {
        //buildGridList(context);
      } else
        print('points products = null');

      Navigator.of(context).pop();
    }
  }

  Widget buildGridList(context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          /*        childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 2),*/
          mainAxisSpacing: 18,
        ),
        // physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(right: 5, left: 0, top: 8, bottom: 8),
        itemCount: products.pointsProducts.length,
        itemBuilder: (ctx, i) {
          return Container(
            child: ProductItemValue(
              product: products.pointsProducts.elementAt(i),
            ),
          );
        },
      ),
    );
  }
}
