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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: sharedData.grayColor12),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                onTap: () {
                  setState(() {
                    if (_state == 0) {
                      replacePoint();
                    }
                  });
                },
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 70.0,
                          width: 115.0,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(3.0)),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    product.productImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                                color: Colors.white10.withOpacity(0.5),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 130,
                                    child: Text(
                                      product.productName + '',
                                      textAlign: TextAlign.center,
                                      style: sharedData.pointsTextStyle,
                                      softWrap: true,
                                      maxLines: 10,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Text(
                                      product.points + ' نقطة',
                                      textAlign: TextAlign.center,
                                      style: sharedData.pointsStyle,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
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
    int userPoints = 0;
    if (sharedData.userInfo != null && sharedData.userInfo.points != null )
       userPoints = int.parse(sharedData.userInfo.points);

    int productPoints = int.parse(product.points);
    if (token == null || token == '')
      sharedData.flutterToast('عذرا ليس لديك حساب');
    else if (userPoints < productPoints)
      sharedData.flutterToast('عذرا لا تمتلك النقاط الكافية ');
    else {
      sharedData.showLoadingDialog(context);
      var response;
      print('i\'m in submit method ');
      print(token);
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

        sharedData.flutterToast('تم استبدال نقاطك ');
        setState(() {
          _state = 200;
          sharedData.userInfo.points = (int.parse(sharedData.userInfo.points) -
              int.parse(product.points))
              .toString();
        });
      } else
        Navigator.of(context).pop();

      setState(() {
          _state = 0;
        });
    }
  }

  Map<String, dynamic> toJson(String token, int id) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (product != null) {
      data['points_poduct'] = this.product.id;
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