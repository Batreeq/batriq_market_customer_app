import 'dart:convert';

import 'package:customerapp/Bloc/ProductItemBloc.dart';
import 'package:customerapp/Bloc/bloc_provider.dart';
import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/DataLayer/CartGroup.dart';
import 'package:customerapp/DataLayer/CartName.dart';
import 'package:customerapp/DataLayer/Product.dart';
import 'package:customerapp/DataLayer/tab.dart';
import 'package:customerapp/Library/FlappySearch/FlappySearch.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/product_detail_screen.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'package:customerapp/models/UserCarts.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mutex/mutex.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:customerapp/models/searchResult.dart';
/*import 'package:flappy_search_bar/flappy_search_bar.dart';*/
import 'package:flutter/rendering.dart';
import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;
import 'package:customerapp/Bloc/appBarTitleBloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../shared_data.dart';
import 'package:customerapp/shared_data.dart';

import 'HomePage.dart';

class CustomAppBar extends StatelessWidget {
  int currentPage = 1;
  final scaffoldKey;

  CustomAppBar({this.currentPage, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {

    appbarBloc = new appBarBloc();
    return Container(
      height: 75,
      child: Stack(
        children: <Widget>[
          Container(
            height: 75,
            color: sharedData.mainColor,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Image.asset(
                'assets/images/menu.png',
                height: 30,
                width: 30,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 0,
            child: Stack(
              children: <Widget>[
                sharedData.isCartNotEmpty == true
                    ? Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      )
                    : Container(),
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      sharedData.selectedIndex = 2;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext c) => HomePagee()));
                    },
                  ),
                )
              ],
            ),
          ),
          BlocProvider<appBarBloc>(
            bloc: appbarBloc,
            child: StreamBuilder<String>(
                stream: appbarBloc.titleStream,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: Text(
                          snapshot.data == null ? appBarTitle : snapshot.data),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  SearchData searchData = new SearchData();
  bool _hasSpeech = false;
  bool _stressTest = false;
  double level = 0.0;
  int _stressLoops = 0;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  bool isVoice = false;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  bool isloading = false;
  Mutex m = Mutex();
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
//    initSpeechState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 130,
            color: sharedData.mainColor,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: SearchBar<Products>(
              searchBarStyle: SearchBarStyle(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(2),
                  borderRadius: BorderRadius.circular(8)),
              onCancelled: () {
                // on press cancel button
                Navigator.of(context).pop();
              },
              speak: (){speechCall();},
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              icon: sharedData.searchIcon,
              hintText: sharedData.searchHintText,
              onSearch: search,
              onError: (error) {
                print(error.toString());
                return Center(
                    child: Text(
                  'لا توجد نتائج',
                  style: sharedData.textInProfileTextStyle,
                ));
              },
              onItemFound: (Products post, int index) {
                // onItemFound callback in order to return the Widget corresponding to one item of the list ,  and return a ListTile :
                return Column(
                  children: <Widget>[
                    index == 0
                        ? SizedBox(
                            height: 20,
                          )
                        : Container(),
                    buildSearchVoiceItem(post, index),
                  ],
                );
              },
            ),
          ),
          /*this is icon to show voice command  */
          /*Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: speechCall,
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset(
                    'assets/images/speech.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ),*/
          isVoice
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      color: Colors.white, child: buildSearchVoiceList()),
                )
              : Container(),
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
              : Container(),
          Container(
            height: speech.isListening ? 250 : 60,
            margin: EdgeInsets.only(top: 200),
            width: double.infinity,
            child: Column(children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            bottom: 10,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: speech.isListening
                                  ? Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: .26,
                                              spreadRadius: level * 1.5,
                                              color:
                                                  Colors.black.withOpacity(.05))
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: IconButton(icon: Icon(Icons.mic)),
                                    )
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              speech.isListening
                  ? Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(lastError),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              speech.isListening
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: sharedData.mainColor,
                      child: Center(
                          child: Text(
                        "تحدث الان  .... ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
            ]),
          ),
        ],
      ),
    );
  }

  static const platformMethodChannel = const MethodChannel('base_64');

  speechCall() async {
    try {
      var resault = await platformMethodChannel.invokeMethod('base_64');

      final extractedData = json.decode(resault) as Map<String, dynamic>;
      String data = extractedData['res'].toString();
      String searchWord = data.substring(1, data.length - 2).split(",")[0];
      getSearchDataByVoiceFromAPI(searchWord);
    } on PlatformException catch (e) {}
  }

  void NavigatorPage(Product product) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProductDetailsScreen(
              product: product,
            )));
  }

  List<Products> productsList;

  // this function called   the user type string and will take the searched String and return a list of Post items generated from the String.
  Future<List<Products>> search(String searchString) async {
    getSearchDataFromAPI(searchString); //.then((val) async {
    if (sharedData != null) {
      productsList = searchData.products;
      // here should be the search api to get te result
      await Future.delayed(Duration(seconds: 5));
      return searchData.products;
    } else {
      sharedData.flutterToast('List is Empty');
    }
  }

  Future<SearchData> getSearchDataFromAPI(String searchString) async {
    // searchString = 'بيض'
    setState(() {
      isVoice = false;
    });
    print(searchString);
    if (searchString != '') {
      var url = sharedData.searchUrl + 'name=' + searchString;
      if (isRegistered()) url += "&api_token=$token";
      final response = await Requests.get(url,
          bodyEncoding: RequestBodyEncoding.FormURLEncoded);
      print(url);
      print(response.json());
      print(response.statusCode);

//      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        // response.raiseForStatus();
        dynamic json = response.json();
        searchData = SearchData.fromJson(json);
        if (searchData.products.length != 0)
          print('name index 0 = ' + searchData.products.elementAt(0).name);
        else
          print('list of products is null ');
        //  search(searchString , searchData
        // fillFeilds(info);
        //return sharedData ;
      }
    } else
      print('Search String is null ');
  }

  Widget buildSearchVoiceList() {
    return ListView.builder(
      itemCount: searchData.products != null ? searchData.products.length : 0,
      itemBuilder: (ctx, i) {
        return buildSearchVoiceItem(searchData.products[i], i);
      },
    );
  }

  Widget buildBottomView(int i, Products product) {
    Map<int, String> counts = new Map();
    final bloc = ProductItemBloc();
    return BlocProvider<ProductItemBloc>(
      bloc: bloc,
      child: StreamBuilder<List<String>>(
          stream: bloc.countStream,
          builder: (context, snapshot) {
            List<String> data = snapshot.data;
            int count = data == null ? 0 : int.parse(data[0]);
            double totalCost = data != null
                ? double.parse(data[1])
                : double.parse(product.price);

            if (data == null) {
              count = 0;
              totalCost = double.parse(product.price);
            } else if (data[2] == i.toString()) {
              count = int.parse(data[0]);
              totalCost = double.parse(data[1]);
            } else {
              if (counts[i] != null) {
                count = int.parse(counts[i]);
                if (count != 0)
                  totalCost = double.parse(product.price) * count;
                else
                  totalCost = double.parse(product.price);
              } else {
                count = 0;
                totalCost = double.parse(product.price);
              }
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    height: 40,
                    width: 30,
                    child: ConstrainedBox(
                        /* plus*/
                        constraints: BoxConstraints.expand(),
                        child: FlatButton(
                            onPressed: () {
                              count++;

                              Future.delayed(Duration(milliseconds: 1500))
                                  .then((v) async {
                                await m.acquire();
                                try {
                                  if (firstTime) {
                                    firstTime = false;
                                    getCartsDialog(count, i, product);
                                  }
                                  print('is first time = ' +
                                      firstTime.toString());
                                } finally {
                                  m.release();
                                  //firstTime= true;
                                  final double totalCost =
                                      double.parse(product.price) * count;
                                  bloc.setCount(<String>[
                                    count.toString(),
                                    totalCost.toString(),
                                    i.toString()
                                  ]);
                                  counts[i] = count.toString();
                                }
                                //  count = 0;
                                final double totalCost =
                                    double.parse(product.price) * count;
                                bloc.setCount(<String>[
                                  count.toString(),
                                  totalCost.toString(),
                                  i.toString()
                                ]);
                                counts[i] = count.toString();
                              });
                              /*    final double totalCost =
                                        double.parse(product.price) * count;
                                    bloc.setCount(<String>[
                                      count.toString(),
                                      totalCost.toString(),
                                      i.toString()
                                    ]);

                                    counts[i] = count.toString();*/
                            },
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset('assets/images/plus.png',
                                fit: BoxFit.fill)))),
                SizedBox(
                  width: 4,
                ),
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
                        Center(child: Text(count.toString()))
                      ],
                    )),
                SizedBox(
                  width: 4,
                ),

                ///minus
                Container(
                    height: 40,
                    width: 30,
                    child: ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: FlatButton(
                            onPressed: () {
                              if (count > 1) {
                                count--;
                                final double totalCost =
                                    double.parse(product.price) * count;
                                bloc.setCount(<String>[
                                  count.toString(),
                                  totalCost.toString(),
                                  i.toString()
                                ]);
                                counts[i] = count.toString();
                              }
                            },
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              'assets/images/minus.png',
                              fit: BoxFit.fill,
                            )))),
                SizedBox(
                  width: 10,
                ),
                product.is_offer != null
                    ? product.is_offer
                        ? Expanded(
                            child: Card(
                            color: Colors.red,
                            child: Text(
                              "عرض",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                          ))
                        : Container()
                    : Container(),
                SizedBox(
                  width: 10,
                ),

                ///add to cart
                /* IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    size: 30,
                  ),
                  color: sharedData.mainColor,
                  onPressed: () {
                    if (token != null && token.length > 10) {
                      getCartNames(
                          Cart(
                          price: product.price,
                          cartTitle  : "",
                          quantity: count ,
                          productId: product.id.toString()));
                    } else {
                      addProductToCart(product.name, product.id, product.price,
                          product.size, count.toString(), product.image);
                    }
                  },
                )*/
              ],
            );
          }),
    );
  }

  Future<void> addProductToCart(name, id, price, size, count, image) async {
    /* check if i have to  add product or edit counter inside  product */
    List<Map> map = await DBHelper.addedBefore("user_cart", id.toString());
    if (map != null && map.isNotEmpty) {
      /*i have to edit count inside product */
      int countInDataBase = 0;
      map.forEach((row) {
        if (row.containsKey("count")) countInDataBase = int.parse(row["count"]);
      });
      countInDataBase += int.parse(count);
      DBHelper.update("user_cart", id.toString(), countInDataBase.toString());
      // widget.showSnackBar("تمت الإضافة إلي سلة المشتريات");
    } else /*i have to add this on database because i don't have this id in database */
      DBHelper.insert('user_cart', {
        'id': id,
        'name': name,
        'price': price,
        'count': count,
        'size': size,
        'image': image,
      });
  }

  showAlert(List<CartName> cartNames, Cart cart) {
    List<Cart> carts = [];
    carts.add(cart);
    //CartGroup groups = CartGroup(groupId: "1", groupItems: carts, groupName: "السلة الرئيسية");
    UserCarts userCarts =
        UserCarts(groupId: "1", userCart: carts, name: "السلة الرئيسية");
    List<bool> inputs = new List<bool>();
    CartName mainCart = CartName(CartNum: "1", cartTitle: "السلة الرئيسية");
    if (cartNames[0].CartNum != "1") {
      cartNames.add(CartName(cartTitle: "السلة الرئيسية", CartNum: "1"));
    }
    for (int i = 0; i < cartNames.length; i++) {
      if (cartNames[i].CartNum == "1") {
        inputs.add(true);
      } else
        inputs.add(false);
    }
    return StatefulBuilder(
      builder: (context, setState) => new AlertDialog(
        content: new Container(
          width: MediaQuery.of(context).size.width - 30,
          height: (inputs.length + 1) * 90.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new ListView.builder(
              itemCount: inputs.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index < inputs.length
                    ? new Card(
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              new CheckboxListTile(
                                  value: inputs[index],
                                  title: new Text(
                                    cartNames[index].cartTitle,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (bool val) {
                                    setState(() {
                                      inputs =
                                          List.filled(inputs.length, false);
                                      inputs[index] = val;
                                      userCarts.groupId =
                                          cartNames[index].CartNum;
                                    });
                                  })
                            ],
                          ),
                        ),
                      )
                    : buildButton(
                        context,
                        userCarts,
                        (int.parse(cartNames[cartNames.length - 1].CartNum) + 1)
                            .toString());
              }),
        ),
      ),
    );
  }

  Widget buildButton(context, UserCarts carts, String lastIndex) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              color: sharedData.mainColor,
              child: MaterialButton(
                child: Text(
                  'تأكيد',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  addToCartWithToken(cartGroupToJson(carts));
                },
              ),
            ),
          ),
          /*   Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: sharedData.mainColor,
                      style: BorderStyle.solid,
                      width: 1)),
              child: MaterialButton(
                child: Text(
                  'إضافة سلة جديدة',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onPressed: () {
                  carts.groupId = lastIndex;
                  Navigator.of(context).pop();
                  showDialog(context: context, child: addCartDialog(carts));
                },
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget addCartDialog(UserCarts carts) {
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
                      'إضافة سلة جديدة',
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
                onChanged: (v) {
                  name = v;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'اكتب اسما للسلة'),
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
                      addToCartWithToken(cartGroupToJson(carts));
                    }
                  },
                  child: new Text(
                    'إضافة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
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

  cartGroupToJson(UserCarts group) {
    final json = jsonEncode(group.userCart.map((i) {
      final cartData = i.toJson();
      final groupData = {'cart_num': group.groupId, 'total_price': '130'};
      cartData.addAll(groupData);
      return cartData;
    }).toList())
        .toString();
    print(json);
    return json;
  }

  addToCartWithToken(data) async {
    final jsonData = {'"data"': data};
    final Map<String, dynamic> formData = {'data': jsonData.toString()};
    Navigator.of(context).pop();
    setState(() {
      isloading = true;
    });
    final Uri url = Uri.parse(
        'https://jaraapp.com/index.php/api/addMultiToCart?api_token=$token');
    final response = await http.post(url, body: formData);
    setState(() {
      isloading = false;
    });
    print(response.body);
    sharedData.flutterToast("تم بنجاح");
  }

  getCartsDialog(int count, int i, Products product) {
    setState(() {
      sharedData.isCartNotEmpty = true ;
      sharedData.writeToStorage(key: 'isCartNotEmpty', value: 'true');
    });

    if (token != null && token.length > 10) {
      getCartNames(Cart(
          price: product.price,
          cartTitle: "",
          quantity: count,
          productId: product.id.toString()));
    } else {
      addProductToCart(product.name.toString(), product.id.toString(),
          product.price, product.size, count.toString(), product.image);
      firstTime = false;
    }
    print(firstTime.toString());

    /*  m.acquire();
    try{
      firstTime = true ;
    }
    finally{
      m.release() ;
    }*/
  }

  getCartNames(Cart cart) async {
    setState(() {
      isloading = true;
    });
    List<CartName> carts = [];
    final url = "https://jaraapp.com/index.php/api/getCarts?api_token=$token";
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData['carts'].forEach((cartname) {
      CartName cartName = CartName(
          CartNum: cartname['cart_num'], cartTitle: cartname['cart_title']);
      carts.add(cartName);
    });
    showDialog(context: context, child: showAlert(carts, cart));
    setState(() {
      isloading = false;
    });
  }

  Widget buildSearchVoiceItem(Products post, i) {
    return InkWell(
      onTap: () {
        NavigatorPage(new Product(
            title: post.name,
            image: post.image,
            size: post.size,
            price: post.price,
            id: post.id.toString(),
            catigory: ProductTab(id: post.categoryId),
            is_offer: post.is_offer,
            is_package:post.is_package));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side:
                new BorderSide(color: Colors.blue.withOpacity(0.3), width: 0.5),
          ),
          child: Container(

            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: 120,
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      post.image,
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
                    padding: EdgeInsets.all(14),
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              post.name ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
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
                              post.price + "  JD",
                              style: TextStyle(
                                  color: sharedData.mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        Expanded(child: buildBottomView(i, post)),

                        post.is_package!=null?post.is_package?Container(
                          width: MediaQuery.of(context).size.width,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: sharedData.mainColor,
                          ),
                          child: Text('باكيج',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                        ):Container():Container()

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<SearchData> getSearchDataByVoiceFromAPI(String searchString) async {
    setState(() {
      isloading = true;
    });
    // searchString = 'بيض'
    print(searchString);
    if (searchString != '') {
      final response = await Requests.get(
          sharedData.searchUrl + 'name=' + searchString,
          bodyEncoding: RequestBodyEncoding.FormURLEncoded);
      print(response.json());
      print(response.statusCode);

//      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        // response.raiseForStatus();
        dynamic json = response.json();
        searchData = SearchData.fromJson(json);
        if (searchData.products.length != 0)
          print('name index 0 = ' + searchData.products.elementAt(0).name);
        else
          print('list of products is null ');
        //  search(searchString , searchData
        // fillFeilds(info);
        //return sharedData ;
      }
    } else
      print('Search String is null ');

    setState(() {
      isVoice = true;
      isloading = false;
    });
  }

  void stressTest() {
    if (_stressTest) {
      return;
    }
    _stressLoops = 0;
    _stressTest = true;
    print("Starting stress test...");
    startListening();
  }

  void changeStatusForStress(String status) {
    if (!_stressTest) {
      return;
    }
    if (speech.isListening) {
      stopListening();
    } else {
      if (_stressLoops >= 100) {
        _stressTest = false;
        print("Stress test complete.");
        return;
      }
      print("Stress loop: $_stressLoops");
      ++_stressLoops;
      startListening();
    }
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    print('start');
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    lastWords = "${result.recognizedWords}";
    getSearchDataByVoiceFromAPI(lastWords);
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    changeStatusForStress(status);
    setState(() {
      lastStatus = "$status";
    });
  }
}
