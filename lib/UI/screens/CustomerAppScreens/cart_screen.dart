import 'dart:convert';
import 'package:customerapp/Bloc/CartGroupBloc.dart';
import 'package:customerapp/Bloc/bloc_provider.dart';
import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/DataLayer/CartGroup.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'order_confirm_screen.dart';

class CartScreen extends StatefulWidget {
  String title;
  CartScreen({this.title});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isloading = false;

  deleteFromCart(id) async {
    setState(() {
      isloading = true;
    });
    final uri =
        "https://jaraapp.com/index.php/api/deleteFromCart?api_token=$token&id=$id";
    await http.post(uri);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    appbarBloc.setTitle("سلة المشتريات");
    return Stack(
      children: <Widget>[
        BlocProvider<CartGroupBloc>(
          bloc: bloc,
          child: StreamBuilder<List<CartGroup>>(
              stream: bloc.cartDataStream,
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(child: Text(''))
                    : buildCartList(snapshot.data, bloc, context);
              }),
        ),
        isloading
            ? Center(
                child: Container(
                  child: SpinKitPulse(
                      duration: Duration(milliseconds: 1000),
                      color: sharedData.mainColor,
                      size: 70
//                    lineWidth: 2,
                      ),
                  width: 100,
                  height: 100,
                ),
              )
            : Container()
      ],
    );
  }

  double totalCost = 0.0;
  List<Cart> data;
  final bloc = CartGroupBloc();

//  Widget buildProductList(context) {
//    return BlocProvider<CartDataBloc>(
//      bloc: bloc,
//      child: StreamBuilder<Object>(
//          stream: bloc.cartDataStream,
//          builder: (context, snapshot) {
//            data = snapshot.data;
//            if (data != null) totalCost = 0.0;
//            return (data != null && data.length > 0)
//                ? ListView.builder(
//                    itemCount: data == null ? 0 : data.length + 1,
//                    itemBuilder: (context, i) {
//                      return (data != null && i == data.length)
//                          ? Column(
//                              children: <Widget>[
//                                Container(
//                                  margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
//                                  child: Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Text(
//                                        "إجمالي السعر",
//                                        style: TextStyle(
//                                            color: Colors.black,
//                                            fontSize: 16,
//                                            fontWeight: FontWeight.normal),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Container(
//                                  margin: EdgeInsets.all(10),
//                                  height: 80,
//                                  width: double.infinity,
//                                  child: Stack(
//                                    children: <Widget>[
//                                      Positioned(
//                                        left: 0,
//                                        right: 0,
//                                        top: 0,
//                                        bottom: 0,
//                                        child: InkWell(
//                                          onTap: () {
//                                            Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                builder: (context) =>
//                                                    ConfiremOrderScreen(),
//                                              ),
//                                            );
//                                          },
//                                          child: Container(
//                                            child: Image.asset(
//                                              'assets/images/btn_orange.png',
//                                              fit: BoxFit.fill,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      Center(
//                                        child: Text(
//                                          "تأكيد الطلب",
//                                          style: TextStyle(
//                                              color: Colors.black,
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.normal),
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ),
//                                Container(
//                                  margin: EdgeInsets.all(10),
//                                  height: 80,
//                                  width: double.infinity,
//                                  child: Stack(
//                                    children: <Widget>[
//                                      Positioned(
//                                        left: 0,
//                                        right: 0,
//                                        top: 0,
//                                        bottom: 0,
//                                        child: FlatButton(
//                                          padding: EdgeInsets.all(0),
//                                          onPressed: () {},
//                                          child: Image.asset(
//                                            'assets/images/btn_orange.png',
//                                            fit: BoxFit.fill,
//                                          ),
//                                        ),
//                                      ),
//                                      Center(
//                                        child: Text(
//                                          "مشاركة",
//                                          style: TextStyle(
//                                              color: Colors.black,
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.normal),
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            )
//                          : buildItem(context, i, data[i], bloc);
//                    })
//                : Center(
//                    child: Text('السلة فارغة'),
//                  );
//          }),
//    );
//  }

  Widget shareCartDialog(String cartNum, ctx) {
    String name = "";
    return new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Row(
                children: <Widget>[
                  new Container(
                    // padding: new EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Text(
                      'مشاركة السلة',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // dialog centre
            new Expanded(
              child: new Container(
                  child: new TextField(
                keyboardType: TextInputType.phone,
                onChanged: (v) {
                  name = v;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 13),
                    hintText: 'اكتب رقم هاتف المرسل اليه'),
              )),
              flex: 2,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                decoration: new BoxDecoration(
                  color: sharedData.mainColor,
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    if (name.length > 2) {
                      shareCart(name, cartNum, ctx);
//                      Navigator.of(context).pop();
                    } else
                      sharedData.flutterToast("رقم الهاتف غير صحيح");
                  },
                  child: new Text(
                    'إرسال',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  shareCart(String phone, String cartNum, ctx) async {
    Map<String, dynamic> params = new Map();
    params['api_token'] = token;
    params['to_user'] = phone;
    params['cart_num'] = cartNum;
    print(
        'https://jaraapp.com/index.php/api/shareCart?api_token=$token&to_user=$phone&cart_num=$cartNum');
    final Uri url = Uri.parse('https://jaraapp.com/index.php/api/shareCart');
    var response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      sharedData.flutterToast(" تم بنجاح مشاركة السلة مع  $phone $cartNum");
    } else {
      sharedData.flutterToast("رقم الهاتف غير صحيح");
    }
//    Navigator.of(ctx).pop();
  }

  Widget buildCartList(List<CartGroup> data, bloc, ctx) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            margin: EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                buildGroupDevider(data[index].groupName),
                buildGroupItem(context, data[index], bloc),
                Container(
                  height: 40,
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          color: sharedData.mainColor,
                          child: MaterialButton(
                            child: Text(
                              'تأكيد الطلب',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              confirmOrder(
                                  data[index].groupId, data[index].groupItems);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: sharedData.mainColor,
                                  style: BorderStyle.solid,
                                  width: 1)),
                          child: MaterialButton(
                            child: Text(
                              'مشاركة السلة',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  child: shareCartDialog(
                                      data[index].groupId, ctx));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        });
  }

  confirmOrder(cartNum, List<Cart> carts) {
    if (isRegistered()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfiremOrderScreen(
            cartNum: cartNum,
          ),
        ),
      );
    } else {
      sendCartToApi(CartGroup(
          groupId: "1", groupItems: carts, groupName: "السلة الرئيسية"));
    }
  }

  cartGroupToJson(CartGroup group) {
    final json = jsonEncode(group.groupItems.map((i) {
      final cartData = i.toJson();
      final groupData = {'cart_num': group.groupId, 'total_price': '130'};
      cartData.addAll(groupData);
      return cartData;
    }).toList())
        .toString();
    print(json);
    return json;
  }

  sendCartToApi(cartData) async {
    final jsonData = {'"data"': cartData};
    final Map<String, dynamic> formData = {'data': jsonData.toString()};
    setState(() {
      isloading = true;
    });
    final Uri url = Uri.parse(
        'https://jaraapp.com/index.php/api/addMultiToCart?api_token=$token');
    final response = await http.post(url, body: formData);
    setState(() {
      isloading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfiremOrderScreen(
          cartNum: "1",
        ),
      ),
    );
    print(response.body);
  }

  Widget buildGroupDevider(title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      color: Colors.black38,
      height: 40,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget buildGroupItem(context, CartGroup cartGroup, bloc) {
    return Column(
        children: mapIndexed(cartGroup.groupItems,
            (index, item) => buildItemm(context, item, bloc)).toList());
  }

  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

//  Widget buildItem(context, i, Cart cart, CartDataBloc bloc) {
//    return Container(
//      margin: EdgeInsets.fromLTRB(5, i == 0 ? 20 : 5, 5, 0),
//      height: 195,
//      width: MediaQuery.of(context).size.width,
//      child: Card(
//        clipBehavior: Clip.antiAliasWithSaveLayer,
//        shape: RoundedRectangleBorder(
//            side:
//                new BorderSide(color: Colors.blue.withOpacity(0.3), width: 0.5),
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(20),
//                bottomLeft: Radius.circular(20))),
//        child: Container(
//          height: double.infinity,
//          width: double.infinity,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Flexible(
//                child: Container(
//                  padding: EdgeInsets.all(15),
//                  height: double.infinity,
//                  width: double.infinity,
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Container(
//                            height: 30,
//                            width: 30,
//                            child: FlatButton(
//                              child: Icon(
//                                Icons.close,
//                                size: 40,
//                                color: sharedData.mainColor,
//                              ),
//                              materialTapTargetSize:
//                                  MaterialTapTargetSize.shrinkWrap,
//                              onPressed: () {
//
//                              },
//                              padding: EdgeInsets.all(0),
//                            ),
//                          ),
//                          Text(
//                            cart.title,
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontSize: 16,
//                                fontWeight: FontWeight.normal),
//                          ),
//                        ],
//                      ),
//                      Padding(
//                        padding: EdgeInsets.all(5),
//                      ),
//                      Text(
//                        ("${cart.quantity} x ${cart.price}"),
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 16,
//                            fontWeight: FontWeight.normal),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.all(5),
//                      ),
//                      Text(
//                        "عروض أصنافي",
//                        style: TextStyle(
//                            color: Colors.deepOrange,
//                            fontSize: 14,
//                            fontWeight: FontWeight.normal),
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Container(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                ///minus
//                                Container(
//                                    height: 25,
//                                    width: 20,
//                                    child: ConstrainedBox(
//                                        constraints: BoxConstraints.expand(),
//                                        child: FlatButton(
//                                            onPressed: () {
//
//                                            },
//                                            padding: EdgeInsets.all(0.0),
//                                            child: Image.asset(
//                                              'assets/images/minus.png',
//                                              fit: BoxFit.fill,
//                                            )))),
//                                Container(
//                                    height: 30,
//                                    width: 40,
//                                    child: Stack(
//                                      children: <Widget>[
//                                        Container(
//                                          child: Image.asset(
//                                            'assets/images/count.png',
//                                            fit: BoxFit.fill,
//                                          ),
//                                          height: 30,
//                                          width: 40,
//                                        ),
//                                        Center(child: Text(cart.quantity))
//                                      ],
//                                    )),
//
//                                ///plus
//                                Container(
//                                    height: 25,
//                                    width: 20,
//                                    child: ConstrainedBox(
//                                        constraints: BoxConstraints.expand(),
//                                        child: FlatButton(
//                                            onPressed: () {
//
//                                            },
//                                            padding: EdgeInsets.all(0.0),
//                                            child: Image.asset(
//                                                'assets/images/plus.png',
//                                                fit: BoxFit.fill)))),
//                              ],
//                            ),
//                            width: 120,
//                            height: 40,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Container(
//                color: Colors.blue.withOpacity(0.3),
//                height: double.infinity,
//                width: 1,
//              ),
//              Container(
//                height: double.infinity,
//                width: 150,
//                padding: EdgeInsets.all(10),
//                child: ClipRRect(
//                  borderRadius: BorderRadius.circular(10),
//                  child: Image.network(
//                    cart.image,
//                    fit: BoxFit.fill,
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }

  Widget buildItemm(context, Cart cart, CartGroupBloc bloc) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: Colors.blue.withOpacity(0.3), width: 0.5),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: double.infinity,
                width: 120,
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    cart.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                color: Colors.blue.withOpacity(0.3),
                height: double.infinity,
                width: 1,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            cart.title ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: FlatButton(
                              child: Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.red,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {
                                if (isRegistered()) {
                                  deleteFromCart(cart.id);
                                  bloc.getCartData(token);
                                } else {
                                  DBHelper.delete('user_cart', cart.id);
                                  bloc.fetchCartData();
                                }
                              },
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ///total price
                          Text(
                            "عروض اصنافي" + "  JD",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),

                          ///price
                          Text(
                            cart.price.toString() + "  JD",
                            style: TextStyle(
                                color: sharedData.mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ///plus
                                Container(
                                    height: 40,
                                    width: 30,
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints.expand(),
                                        child: FlatButton(
                                            onPressed: () {
                                              if (!isRegistered()) {
                                                DBHelper.update(
                                                    'user_cart',
                                                    cart.id,
                                                    (int.parse(cart.quantity) +
                                                            1)
                                                        .toString());
                                                bloc.fetchCartData();
                                              } else {
                                                updateCart(
                                                    cart.id,
                                                    (int.parse(cart.quantity) +
                                                            1)
                                                        .toString(),
                                                    bloc);
                                              }
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Image.asset(
                                                'assets/images/plus.png',
                                                fit: BoxFit.fill)))),
                                Container(
                                    height: 30,
                                    width: 40,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            'assets/images/count.png',
                                            fit: BoxFit.fill,
                                          ),
                                          height: 30,
                                          width: 40,
                                        ),
                                        Center(child: Text(cart.quantity))
                                      ],
                                    )),

                                ///minus
                                Container(
                                    height: 40,
                                    width: 30,
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints.expand(),
                                        child: FlatButton(
                                            onPressed: () {
                                              if (!isRegistered()) {
                                                DBHelper.update(
                                                    'user_cart',
                                                    cart.id,
                                                    int.parse(cart.quantity) > 1
                                                        ? (int.parse(cart
                                                                    .quantity) -
                                                                1)
                                                            .toString()
                                                        : 1.toString());
                                                bloc.fetchCartData();
                                              } else {
                                                int.parse(cart.quantity) > 1
                                                    ? updateCart(
                                                        cart.id,
                                                        (int.parse(cart
                                                                    .quantity) -
                                                                1)
                                                            .toString(),
                                                        bloc)
                                                    : print("");
                                              }
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Image.asset(
                                              'assets/images/minus.png',
                                              fit: BoxFit.fill,
                                            )))),
                              ],
                            ),
                            width: 120,
                            height: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    readToken();
    !isRegistered() ? bloc.fetchCartData() : bloc.getCartData(token);
  }

  Future<void> updateCart(productId, quantity, CartGroupBloc bloc) async {
    print("boom $productId  $quantity  $token");
    var params = Map<String, dynamic>();
    setState(() {
      isloading = true;
    });
    params['api_token'] = token;
    params['cart_id'] = productId;
    params['quantity'] = quantity;
    final url = Uri.parse('https://jaraapp.com/index.php/api/updateItem');
    final response = await http.post(url, body: params);
    bloc.getCartData(token);
    setState(() {
      isloading = false;
    });
  }

  readToken() async {
    token = await sharedData.readFromStorage(key: 'token');
    print(token);
  }
}
