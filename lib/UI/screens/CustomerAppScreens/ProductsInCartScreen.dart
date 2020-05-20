import 'package:customerapp/Bloc/CartGroupBloc.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'package:customerapp/models/UserCarts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/Bloc/bloc_provider.dart';
import 'package:requests/requests.dart';

import '../../../shared_data.dart';

class ProductsInCartScreen extends StatefulWidget {
  List<ProductDetailsFromCart> products;

  ProductsInCartScreen(this.products);
  @override
  State<StatefulWidget> createState() {
    return _ProductsInCartScreen(this.products);
  }
}

class _ProductsInCartScreen extends State {
  final bloc = CartGroupBloc();

  List<ProductDetailsFromCart> products;

  _ProductsInCartScreen(this.products);
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedData.appBar(context, 'المنتجات', null, (){}),
      body: getBody()
    );
  }

  getBody(){
    return getList();
  }

  getList(){
   return buildGroupItem(context, products , bloc);

  }

  Widget buildGroupItem(context, List<ProductDetailsFromCart> cartGroup, bloc) {
    return Column(
        children: mapIndexed(cartGroup, (index, item) => buildItem(context, item, bloc)).toList()
    );
  }

  Iterable<E> mapIndexed<E, T>(Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

  Widget buildItem(context, ProductDetailsFromCart product, CartGroupBloc bloc) {
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
                    product.image,
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
                            product.name ?? "",
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
                            /*    if (isRegistered()) {
                                  deleteFromCart(cart.id);
                                  bloc.getCartData(token);
                                } else {
                                  DBHelper.delete(
                                      'user_cart', cart.id.toString());
                                  bloc.fetchCartData();
                                }*/
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
                            product.price.toString() + "  JD",
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
                                     /*         if (!isRegistered()) {
                                                DBHelper.update(
                                                    'user_cart',
                                                    cart.id,
                                                    (cart.quantity + 1)
                                                        .toString());
                                                bloc.fetchCartData();
                                              } else {
                                                updateCart(
                                                    cart.id,
                                                    (cart.quantity + 1)
                                                        .toString(),
                                                    bloc);
                                              }*/
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
                                        Center(
                                            child:
                                                Text(product.quantity.toString()))
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
                                            /*  if (!isRegistered()) {
                                                DBHelper.update(
                                                    'user_cart',
                                                    cart.id,
                                                    cart.quantity > 1
                                                        ? (cart.quantity - 1)
                                                            .toString()
                                                        : 1.toString());
                                                bloc.fetchCartData();
                                              } else {
                                                cart.quantity > 1
                                                    ? updateCart(
                                                        cart.id,
                                                        (cart.quantity - 1)
                                                            .toString(),
                                                        bloc)
                                                    : print("");
                                              }*/
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

  Future<void> updateCart(productId, quantity, CartGroupBloc bloc) async {
    print("boom $productId  $quantity  $token");
    var params = Map<String, dynamic>();
    setState(() {
      isloading = true;
    });
    params['api_token'] = token;
    params['cart_id'] = productId;
    params['quantity'] = quantity;
    final String url = 'https://jaraapp.com/index.php/api/updateItem';
    final response = await Requests.post(url, body: params);
    bloc.getCartData(token);
    setState(() {
      isloading = false;
    });
  }

  deleteFromCart(id) async {
    setState(() {
      isloading = true;
    });
    final uri =
        "https://jaraapp.com/index.php/api/deleteFromCart?api_token=$token&id=$id";
    await Requests.post(uri);
    setState(() {
      isloading = false;
    });
  }
}
