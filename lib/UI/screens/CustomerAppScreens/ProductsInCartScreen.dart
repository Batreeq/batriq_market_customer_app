import 'package:customerapp/Bloc/CartGroupBloc.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'package:customerapp/models/MyProductsModel.dart';
import 'package:customerapp/models/UserCarts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/Bloc/bloc_provider.dart';
import 'package:requests/requests.dart';

import '../../../shared_data.dart';

class ProductsInCartScreen extends StatefulWidget {
Cart cart ;
  ProductsInCartScreen({this.cart});
  @override
  State<StatefulWidget> createState() {
    return _ProductsInCartScreen(this.cart);
  }
}

class _ProductsInCartScreen extends State {
  final bloc = CartGroupBloc();

  Cart cart;

  int atIndex = 0;

  _ProductsInCartScreen(this.cart);

  bool isloading = false;
  Cart c;

  bool minus = false,
      plus = false;

  ProductDetailsFromCart product;

  //int quantity = 0;

  @override
  void initState() {
    super.initState();

    if(isRegistered()) {
      product = cart.productDetails.elementAt(0);
      c = this.cart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: sharedData.appBar(context, 'المنتجات', null, () {}),
        body: getBody()
    );
  }

  getBody() {
    if(isRegistered())
    return buildGroupItem(context, c.productDetails, bloc);
    else return buildGroupItemLocal(context,myProductList);
  }




  Widget buildGroupItem(context, List<ProductDetailsFromCart> cartGroup, bloc) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(c.cartTitle)),
          ),
          Column(
              children: mapIndexed(cartGroup, (index, item) =>
                  buildItem(context, item, bloc, index)).toList()
          ),
        ],
      ),
    );
  }

  /*To show data in form database */
  Widget buildGroupItemLocal(context, List<MyProductModel> cartGroup) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("السلة الرئيسية")),
          ),
          Column(
              children: mapIndexed(cartGroup, (index, item) =>
                  buildItemLocal(context, item, index)).toList()
          ),
        ],
      ),
    );
  }

  Widget buildItem(context, ProductDetailsFromCart product, CartGroupBloc bloc,
      int index) {
    // product = c.productDetails.elementAt(index);
    //quantity = product.quantity;

   // print( 'product q = ' + product.quantity.toString());

    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      height: 140,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
              //product image
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
             // image divider
              Container(
                color: Colors.blue.withOpacity(0.3),
                height: double.infinity,
                width: 1,
              ),
            // product info
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
                          // name
                          Text(
                            product.name ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          //close button
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
                                  deleteFromCart(product.id , index);
                                  bloc.getCartData(token);
                                } else {
                                  DBHelper.delete('user_cart', c.id.toString());
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
                            product.price.toString() + "  JD",
                            style: TextStyle(
                                color: sharedData.mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
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
                                                setState(() {
                                                 // plus = true ;
                                                //  int q = product.quantity;
                                                  cart.productDetails.elementAt(index).quantity += 1 ;
                                               //   quantity ++;
                                                });
                                                if (!isRegistered()) {
                                                  print ('user not registered ') ;
                                                  DBHelper.update(
                                                      'user_cart',
                                                      c.id,
                                                      ( product.quantity  )
                                                          .toString());
                                                  bloc.fetchCartData();
                                                } else {
                                                  updateCart(
                                                      c.id,
                                                      (
                                                          product.quantity  )
                                                          .toString(),
                                                      bloc);
                                                }
                                              },
                                              padding: EdgeInsets.all(0.0),
                                              child: Image.asset(
                                                  'assets/images/plus.png',
                                                  fit: BoxFit.fill)))),

                                  /// Counter
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
                                      )
                                  ),

                                  ///minus
                                  Container(
                                      height: 40,
                                      width: 30,
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints.expand(),
                                          child: FlatButton(
                                              onPressed: () {

                                                setState(() {
                                                  minus = true ;
                                                });

                                                print('in on press : quantity = ' /*+ quantity.toString() + ' :: ' +*/ 'product q = ' + product.quantity.toString());
                                                if (product.quantity > 1) {
                                                   if (!isRegistered()) {

                                                    print(
                                                        'quantity more than 0 its ' +
                                                            product.quantity.toString());
                                                    DBHelper.update(
                                                        'user_cart',
                                                        c.id,
                                                            product.quantity > 1
                                                            ? (
                                                            product.quantity - 1)
                                                            .toString()
                                                            : 1.toString()
                                                    );
                                                    bloc.fetchCartData();
                                                  }
                                                 else  {
                                                     setState(() {
                                                       minus = true ;
                                                       cart.productDetails.elementAt(index).quantity -= 1 ;
                                                    //   quantity --;
                                                     });
                                                     print(' in if quantity = ' /*+ quantity.toString() + ' :: ' +*/
                                                         'product q = ' + product.quantity.toString());
                                                     this.product = product;
                                                     updateCart(c.id, (product.quantity).toString(), bloc);
                                                   }
                                                }  else if (product.quantity == 1 || product.quantity == 1)  {
                                                  // delete product here
                                                  if (isRegistered()) {
                                                    updateCart(product.id, product.quantity.toString(), bloc);
                                                    deleteFromCart(product.id , index );
                                                    bloc.getCartData(token);
                                                  } else {
                                                    DBHelper.delete(
                                                        'user_cart',
                                                        product.id.toString());
                                                    bloc.fetchCartData();
                                                  }
                                                  setState(() {
                                                    cart.productDetails.removeAt(index);
                                                  });
                                                }/*

                                                setState(() {
                                                  int q = product.quantity;
                                                  product.quantity = (q --);
                                                  quantity -- ;
                                                });*/
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

  /*To show data in form database */
  Widget buildItemLocal(context, MyProductModel product,
      int index) {


    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      height: 140,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
              //product image
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
              // image divider
              Container(
                color: Colors.blue.withOpacity(0.3),
                height: double.infinity,
                width: 1,
              ),
              // product info
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
                          // name
                          Text(
                            product.name ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          //close button
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
                              onPressed: () async {
                               {
                                  DBHelper.delete('user_cart', product.id.toString());
                                 // subCartSize();
                                 await initMyProductData();
                                 setState(() {});
                                //  bloc.fetchCartData();
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
                                            onPressed: () async {



                                               int  newCount=int.parse(product.count);
                                                 newCount++;
                                                DBHelper.update(
                                                    'user_cart',
                                                    product.id,newCount.toString());
                                                await initMyProductData();
                                               // addCartSize();
                                                setState(() {});




                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Image.asset(
                                                'assets/images/plus.png',
                                                fit: BoxFit.fill)))),

                                /// Counter
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
                                            Text(product.count))
                                      ],
                                    )
                                ),

                                ///minus
                                Container(
                                    height: 40,
                                    width: 30,
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints.expand(),
                                        child: FlatButton(
                                            onPressed: () async {

                                              setState(() {
                                                minus = true ;
                                              });

                                              int myCount=int.parse(product.count);
                                              if (myCount > 1) {



                                                myCount--;
                                                  DBHelper.update(
                                                      'user_cart',
                                                      product.id,
                                                      myCount.toString()
                                                  );
                                                await initMyProductData();

                                                setState(() {

                                                });


                                              }  else if (myCount== 1)  {
                                                // delete product here

                                                  DBHelper.delete(
                                                      'user_cart',
                                                      product.id.toString());
                                               //   subCartSize();
                                                  await initMyProductData();
                                                  setState(() {

                                                  });



                                              }/*

                                              setState(() {
                                                int q = product.quantity;
                                                product.quantity = (q --);
                                                quantity -- ;
                                              });*/
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

  Iterable<E> mapIndexed<E, T>(Iterable<T> items,
      E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }


  Future<void> updateCart(productId, String quantity, CartGroupBloc bloc) async {
    print("boom $productId  $quantity  $token");
    var params = Map<String, dynamic>();
    setState(() {
      isloading = true;
    });
    params['api_token'] = token;
    params['cart_id'] = productId;
    params['quantity'] = quantity;
    final String url = 'https://jaraapp.com/index.php/api/updateItem';

    print(url);
    print('product id ' + productId.toString());
    print(token);
    print(params.toString());
    print('quantity ' + quantity.toString());

    final response = await Requests.post(url, body: params);
    if (response.statusCode == 200){
      print('success');
    print(response.json().toString());
    }
    else
      print('not success' + response.statusCode.toString());

    int q = int.parse(quantity);
    print(minus.toString() + plus.toString());

    /* if (minus ) {
      int q = int.parse(product.quantity);
      setState(() {
        minus = false;
        product.quantity = (q ++).toString();
      });
      print (quantity .toString());
    }
    else  if (plus) {
      int q = int.parse(product.quantity);
      setState(() {
        plus = false;
      product.quantity = (q ++).toString();
      });
      print (quantity .toString());
    }*/
/*    if (plus)
      setState(() {
        product.quantity = q;
        this.quantity ++;
      });
    else if (minus)
      setState(() {
        product.quantity = q;
        this.quantity --;
      });*/

    bloc.getCartData(token);
    setState(() {
      isloading = false;
    });
  }

  deleteFromCart(id , int index ) async {
    setState(() {
      isloading = true;
    });

    print ('will delete ' + id.toString());
    final uri =
        "https://jaraapp.com/index.php/api/deleteFromCart?api_token=$token&id=$id";
    final response = await Requests.post(uri);
    if (response.statusCode == 200)
      print('successfully deleted ');
    setState(() {
      isloading = false;
      cart.productDetails.removeAt(index);
    });
  }
}