import 'dart:convert';
import 'package:customerapp/Bloc/ProductItemBloc.dart';
import 'package:customerapp/Bloc/bloc_provider.dart';
import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/DataLayer/CartGroup.dart';
import 'package:customerapp/DataLayer/CartName.dart';
import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/DataLayer/Product.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/product_detail_screen.dart';
import 'package:customerapp/UI/wigets/custom_tab.dart';
import 'package:customerapp/DataLayer/tab.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'package:customerapp/models/UserCarts.dart';
import 'package:customerapp/models/homeBlocks/CategoryHomeBlocks.dart';
import 'package:customerapp/models/mainCategoriesModel/Category.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:mutex/mutex.dart';


class ProductsScreen extends StatefulWidget {
  String offerId;

  ProductsScreen({this.offerId});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return TabsController(
      offerId: widget.offerId,
    );
  }
}

class TabsController extends StatelessWidget {
  int tabsSize=0;
  String offerId;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TabsController({this.offerId});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          bottom: ColoredTabBar(

            tabBar: TabBar(
              indicatorColor: Colors.orange,
              tabs: buildtabs(),
               isScrollable: tabsSize<=3?false:true,
            ),
            color: Colors.white,
          ),
          title: Text(
            "عروض بطريق",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: TabBarView(
          children: pages(),
        ),
      ),
    );
  }
  List<Tab> buildtabs() {
    List<Tab> tabsList = [];
    for (int i = 0; i < tabs.length; i++) {
      tabsList.add(Tab(
        child: Container(
         width: 90,
          color: Colors.white,
          child: SafeArea(
            top: true,
            bottom: true,
            left: true,
            right: true,
            child: Text(
              tabs[i].name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,

                  fontSize: 12,
                  fontFamily: "default",
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ));
    }
    tabsSize=tabsList.length;
    return tabsList;
  }

  List<Products> pages() {
    List<Products> tabsList = [];
    for (int i = 0; i < tabs.length; i++) {
      tabsList.add(Products(
          offerId: offerId,
          categoryId: tabs[i].id.toString(),
          keyy: scaffoldKey,
        indexTab: i));
    }
    return tabsList;
  }
}

class Products extends StatefulWidget {
  String offerId, categoryId;

  int indexTab;
  GlobalKey<ScaffoldState> keyy;
  Products({this.offerId, this.categoryId, this.keyy,this.indexTab});
  void showSnackBar(message) {
    keyy?.currentState?.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(color: Colors.black, fontFamily: 'default'),
        textAlign: TextAlign.center,
      ),
      backgroundColor: sharedData.mainColor,
    ));
  }

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isloading = true;

  //bool firstTime = true ;

  //Mutex m = Mutex();


  @override
  Widget build(BuildContext context) {
   // firstTime = true ;
    //print (firstTime .toString());
    return Stack(
      children: <Widget>[
        buildProductList(context),
        isloading
            ? Center(
                child: Container(
                  child: SpinKitPulse(
                      duration: Duration(milliseconds: 1000),
                      color: sharedData.mainColor,
                      size: 70
                      ),
                  width: 100,
                  height: 100,
                ),
              )
            : Container(),
      ],
    );
  }

  void NavigatorPage(Product product) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProductDetailsScreen(
              product: product,
            )));
  }




  Widget buildProductList(context) {
    Map<int, String> counts = new Map();
    final bloc = ProductItemBloc();
    return ListView.builder(
        itemCount: productss.length,
        itemBuilder: (context, i) {
          return BlocProvider<ProductItemBloc>(
            bloc: bloc,
            child: StreamBuilder<List<String>>(
                stream: bloc.countStream,
                builder: (context, snapshot) {
                  List<String> data = snapshot.data;
                  int count = data == null ? 0 : int.parse(data[0]);
                  double totalCost = data != null
                      ? double.parse(data[1])
                      : double.parse(productss[i].price);
                  if (data == null) {
                    count = 0;
                    totalCost = double.parse(productss[i].price);
                  } else if (data[2] == i.toString()) {
                    count = int.parse(data[0]);
                    totalCost = double.parse(data[1]);
                  } else {
                    if (counts[i] != null) {
                      count = int.parse(counts[i]);
                      if(count!=0 )
                      totalCost = double.parse(productss[i].price) * count;
                      else
                        totalCost = double.parse(productss[i].price);
                    } else {
                      count = 0;
                      totalCost = double.parse(productss[i].price);
                    }
                  }
                  return InkWell(
                    onTap: () {
                      NavigatorPage(productss[i]);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, i == 0 ? 20 : 5, 5, 0),
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(
                                color: Colors.blue.withOpacity(0.3),
                                width: 0.5),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ///product image
                              Container(
                                height: double.infinity,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Image.network(
                                          productss[i].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Expanded(
                                      flex: 1,
                                        child: getPointsNumber(productss[i].points)==0?
                                        Container():
                                        Text("${productss[i].points} "+sharedData.point,style: TextStyle(fontSize: 14),),
                                      )
                                    ],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ///title
                                          Text(
                                            productss[i].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),

                                          ///size
                                          Text(
                                            productss[i].size + "",
                                            style: TextStyle(
                                                color: sharedData.mainColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ///total price
                                          Text(
                                            totalCost.toString() + "  JD",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),

                                          ///price
                                          Text(
                                            productss[i].price + "  JD",
                                            style: TextStyle(
                                                color: sharedData.mainColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                      ),

                                      ///plus minus
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                height: 40,
                                                width: 30,
                                                child: ConstrainedBox(
                                                    constraints:
                                                    BoxConstraints
                                                        .expand(),
                                                    child: FlatButton(
                                                        onPressed: () async {

                                                          /*            List<Map> map= await DBHelper.addedBefore("user_cart",productss[i].id.toString());
                                                              if(map!=null &&map.isNotEmpty){*//*i have to edit count of product *//*

                                                              int count=0;
                                                              map.forEach((row){
                                                              if(row.containsKey("count"))
                                                              count= int.parse(row["count"]);
                                                              });
                                                              debugPrint("hassan count $count");}*/
                                                          count++;
//                                                          Future.delayed(Duration(milliseconds : 1500)).then((v) async {
//                                                            await m.acquire();
                                                            try{
//                                                              if (firstTime){
//                                                                firstTime = false ;
                                                                getCartsDialog(count , i);
                                                             // }
                                                             // print ('is first time = ' + firstTime.toString());
                                                            }
                                                            finally{
                                                            //  m.release();
                                                              //firstTime= true;
                                                              final double totalCost = double.parse(productss[i].price) * count;
                                                              bloc.setCount(<String>[count.toString(), totalCost.toString(), i.toString()]);
                                                              counts[i] = count.toString();
                                                            }
                                                            //  count = 0;
                                                            final double totalCost = double.parse(productss[i].price) * count;
                                                            bloc.setCount(<String>[count.toString(), totalCost.toString(), i.toString()]);
                                                            counts[i] = count.toString();
                                                      //    });
                                                        },
                                                        padding:
                                                        EdgeInsets
                                                            .all(0.0),
                                                        child: Image.asset(
                                                            'assets/images/plus.png',
                                                            fit: BoxFit
                                                                .fill)))),
                                            SizedBox(width: 4,),
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
                                                        child: Text(count
                                                            .toString()))
                                                  ],
                                                )),

                                            ///minus
                                              SizedBox(width: 4,),
                                            Container(
                                                height: 40,
                                                width: 30,
                                                child: ConstrainedBox(
                                                    constraints:
                                                    BoxConstraints
                                                        .expand(),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          if (count > 1) {
                                                            count--;
                                                            final double
                                                            totalCost =
                                                                double.parse(
                                                                    productss[i].price) *
                                                                    count;
                                                            bloc.setCount(<
                                                                String>[
                                                              count
                                                                  .toString(),
                                                              totalCost
                                                                  .toString(),
                                                              i.toString()
                                                            ]);
                                                            counts[i] = count
                                                                .toString();
                                                          }
                                                        },
                                                        padding:
                                                        EdgeInsets
                                                            .all(0.0),
                                                        child:
                                                        Image.asset(
                                                          'assets/images/minus.png',
                                                          fit:
                                                          BoxFit.fill,
                                                        )))),
                                            SizedBox(width: 10,),

                                            productss[i].is_offer!=null?productss[i].is_offer
                                                ? Expanded(child: Card(color: Colors.red,
                                            child: Text("عرض",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white,fontSize: 14),),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10))
                                            ),))
                                                :Container():Container(),

                                            SizedBox(width: 10,),

                                            ///add to cart
                                           /* IconButton(
                                              icon: Icon(
                                                Icons.add_shopping_cart,
                                                size: 30,
                                              ),
                                              color: sharedData.mainColor,
                                              onPressed: () {
                                                if (token != null &&
                                                    token.length > 10) {
                                                  getCartNames(Cart(
                                                      price: productss[i].price,
                                                      cartTitle: "",
                                                      quantity: count,
                                                      productId: productss[i].id));
                                                } else {
                                                  addProductToCart(
                                                      productss[i].title,
                                                      productss[i].id,
                                                      productss[i].price,
                                                      productss[i].size,
                                                      count.toString(),
                                                      productss[i].image);
                                                }
                                              },
                                            )*/
                                          ],
                                        ),
                                      ),

                                      productss[i].is_package!=null?  productss[i].is_package?Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: sharedData.mainColor,
                                        ),
                                        child: Text('باكيج',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
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
                }),
          );
        });
  }

  getCartsDialog (int count , int i ) {
   /* setState(() {
      sharedData.writeToStorage(key: 'isCartNotEmpty' , value: 'true');
    });*/

    if (token != null && token.length > 10) {
      getCartNames(Cart(
          price: productss[i].price,
          cartTitle: "",
          quantity: 1,
          productId: productss[i].id));
    } else {
      addProductToCart(
          productss[i].title,
          productss[i].id,
          productss[i].price,
          productss[i].size,
          1.toString(),
          productss[i].image);
      //firstTime = false;
    }
 //   print(firstTime.toString());

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
    debugPrint(url);
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      setState(() {
        isloading = false;
      });
      return;
    }
    extractedData['carts'].forEach((cartname) {
      CartName cartName = CartName(
          CartNum: cartname['cart_num'], cartTitle: cartname['cart_title']);
      carts.add(cartName);
    });


    print("carts Leanght"+carts.length.toString());

    if(carts!=null&&carts.length<=1) {
      List<Cart> carts = [];
      carts.add(cart);
      UserCarts groups = UserCarts(groupId: "1", userCart: carts, name : "السلة الرئيسية");
      addToCartWithToken(cartGroupToJson(groups),state: false);


    }else
    showDialog(context: context, child: showAlert(carts, cart),barrierDismissible: false);
    setState(() {
      isloading = false;
    });

    addCartSize();
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

  List<Product> productss = [];
  getProducts() async {
    List<Product> products = [];
    var url="";
   // url="https://jaraapp.com/api/allMainCategories?category_id=${tabs[widget.indexTab].id}&offer_id=${widget.offerId}";

    if(widget.indexTab==0)
      url="https://jaraapp.com/api/allMainCategories?offer_id=${widget.offerId}";
      else
    url ="https://jaraapp.com/index.php/api/productCategory?category_id=${widget.categoryId}&offer_id=${widget.offerId}";
    if(isRegistered())
      url+="&api_token=$token";
    print(
        "$url");
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    if(widget.indexTab==0){
      extractedData['allProducts'].forEach((p) {
        print("ssd${p}");
        ProductTab category = tabs.firstWhere(
                (cat) => cat.id.toString() == p['category_id'].toString());

        Product product = Product(
            catigory: category,
            price: p['price'],
            image: p['image'],
            title: p['name'],
            id: p['id'].toString(),
            size: p['size'],
            is_offer: p['is_offer'],
        is_package: p['is_package'],
            points:p['points'] );
        products.add(product);
      });
    }else
    extractedData['products'].forEach((p) {
      print("ssd${p}");
      ProductTab category = tabs.firstWhere(
          (cat) => cat.id.toString() == p['category_id'].toString());

      Product product = Product(
          catigory: category,
          price: p['price'],
          image: p['image'],
          title: p['name'],
          id: p['id'].toString(),
          size: p['size'],
      is_offer: p['is_offer'],
      is_package: p['is_package'],
      points: p['points']);
      products.add(product);
    });
    if (mounted)
      setState(() {
        if (isloading) {
          productss = products;
          isloading = false;
        }
      });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
   // firstTime = true ;
  }

  Future<void> addProductToCart(name, id, price, size, count, image) async {

    /* check if i have to  add product or edit counter inside  product */
    List<Map> map= await DBHelper.addedBefore("user_cart",id.toString());
    if(map!=null &&map.isNotEmpty){
      /*i have to edit count inside product */

      int countInDataBase=0;
     map.forEach((row){
        if(row.containsKey("count"))
          countInDataBase= int.parse(row["count"]);
      });
      countInDataBase+=int.parse(count);
     DBHelper.update("user_cart", id.toString(),countInDataBase.toString());
      widget.showSnackBar("تمت الإضافة إلي سلة المشتريات");
    }
    else/*i have to add this on database because i don't have this id in database */
    DBHelper.insert('user_cart', {
      'id': int.parse(id),
      'name': name,
      'price': price.toString(),
      'count': int.parse(count),
      'size': size.toString(),
      'image': image,
    }).then((v){
      widget.showSnackBar("تمت الإضافة إلي سلة المشتريات");
    });

    addCartSize();
  }

  showAlert(List<CartName> cartNames, Cart cart) {
    List<Cart> carts = [];
    carts.add(cart);
   // CartGroup groups = CartGroup(groupId: "1", groupItems: carts, groupName: "السلة الرئيسية");
    UserCarts groups = UserCarts(groupId: "1", userCart: carts, name : "السلة الرئيسية");
    List<bool> inputs = new List<bool>();
    CartName mainCart = CartName(CartNum: "1", cartTitle: "السلة الرئيسية");
    if(cartNames!=null && cartNames.isEmpty){
      cartNames.add(CartName(cartTitle: "السلة الرئيسية", CartNum: "1"));
    }

    if (cartNames != null )
      if (cartNames[0].CartNum != "1") {
        cartNames.add(CartName(cartTitle: "السلة الرئيسية", CartNum: "1"));
      }
    if ( cartNames != null )
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
                                      groups.groupId = cartNames[index].CartNum;
                                    });
                                  })
                            ],
                          ),
                        ),
                      )
                    : buildButton(
                        context,
                        groups,
                        (int.parse(cartNames[cartNames.length - 1].CartNum) + 1)
                            .toString()
                );
              }),
        ),

      ),
    );
  }

  addToCartWithToken(data,{bool state}) async {
    final jsonData = {'"data"': data};
    final Map<String, dynamic> formData = {'data': jsonData.toString()};
    if(state)
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
    widget.showSnackBar("تمت الإضافة إلي سلة المشتريات");
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
         /* Expanded(
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
}
