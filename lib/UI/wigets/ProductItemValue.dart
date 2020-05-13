import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart';
import 'package:customerapp/models/PointsProducts.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class ProductItemValue extends StatefulWidget {
  ProductItemValue({this.product});
  ProductsFromPoints product;
  @override
  State<StatefulWidget> createState() {
    return _ProductItemValue(product);
  }
}

class _ProductItemValue extends State {
  ProductsFromPoints product;

  _ProductItemValue(this.product);

  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductsScreen(
                      offerId: product.id.toString(),
                    ),
              ),
            );
          },
          child: Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      image: DecorationImage(
                          image:
                          CachedNetworkImageProvider(product.productImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          color: Colors.white10.withOpacity(0.5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              product.productName + '',
                              textAlign: TextAlign.center,
                              style: sharedData.optionStyle,
                              softWrap: true,
                            ),
                            Text(
                              product.points + ' نقطة',
                              textAlign: TextAlign.center,
                              style: sharedData.size19Style,
                              softWrap: true,
                            ),
                          ],
                        )),
                  ),
                  new RaisedButton(
                    child: setUpButtonChild(),
                    onPressed: () {
                      setState(() {
                        if (_state == 0) {
                          replacePoint();
                        }
                      });
                    },
                    elevation: 4.0,
                    // minWidth: double.infinity,
                    color: sharedData.yellow,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  replacePoint() async {
    String token = await sharedData.readFromStorage(key: 'token');
    if (null != token) {
      doReplacementRequest(token, product.id);
    }
  }

  doReplacementRequest(String token, int id) async {
    setState(() {
      _state = 1;
    });
    var response;
    print('i\'m in submit method ');
    print (token );
    response = await Requests.post(sharedData.replacePointsUrl,
        body: toJson(token, id));

    if (response != null) {
      print(response.json());
      print(response.statusCode);
    } else
      print('response is null');

    await Future.delayed(Duration(seconds: 3));

    if (response.statusCode == 200) {
      response.raiseForStatus();
      dynamic json = response.json();

      setState(() {
        _state = 200;
      });
    }
    else
      setState(() {
        _state = 0 ;
      });
  }

  Map<String, dynamic> toJson(String token, int id) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (product != null) {
      data['points_product'] = this.product.id;
      data['api_token'] = token;
    }
    return data;
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "استبدال",
        style: TextStyle(
          //color: Colors.white,
          fontSize: 12.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      sharedData.flutterToast('تم استبدال نقاطك');
      return Icon(Icons.check, color: Colors.white);
    }
  }
}