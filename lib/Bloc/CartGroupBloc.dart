import 'dart:async';
import 'dart:convert';
import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/DataLayer/CartGroup.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'package:customerapp/models/UserCarts.dart';
import 'package:customerapp/shared_data.dart';
import 'package:requests/requests.dart';
import 'bloc.dart';
import 'package:http/http.dart' as http;

class CartGroupBloc implements Bloc {
  final _controller = StreamController<UserCarts>();
  Stream<UserCarts> get cartDataStream => _controller.stream;

  UserCarts userCarts = new UserCarts();
  Future<void> getCartData(token) async {
    print("token_cart$token");
    final response = await Requests.get(sharedData.getUserCartsUrl + token);

    if (response != null) {
      print(response.json());
      print(response.statusCode);
    } else
      print('response is null');

    if (response.statusCode == 200 ){
      response.raiseForStatus();
      dynamic json = response.json();
      userCarts = UserCarts.fromJson(json);
    }


 /*    extractedData['user_cart'].forEach((group) {
      List<Cart> groupData = [];
      group.forEach((cart) {
        Cart cartitem = Cart(
            title: cart['product_details']['name'],
            id: cart['id'].toString(),
            quantity: cart['quantity'],
            price: cart['price'],
            image: cart['product_details']['image'],
            size: cart['product_details']['size']
        );
        groupData.add(cartitem);
      });
      CartGroup cartGroup = CartGroup(
          groupId: group[0]['cart_num'],
          groupName: group[0]['cart_title'],
          groupItems: groupData);
      userCarts.add(cartGroup);
    });*/
    print(token);
    _controller.sink.add(userCarts);
  }

  Future<void> fetchCartData() async {
/*    List<UserCarts> carts = [];
    final dataList = await DBHelper.getData('user_cart');
    List<Cart> items = dataList.map((item) {
      print("object${item['count']}");
      return Cart(
          title: item['name'],
          image: item['image'],
          price: item['pric+e'],
          id: item['id'],
          quantity: item['count'],
          size: item['size']);
    }).toList();

    CartGroup cartGroup =
        CartGroup(groupName: "السلة الرئيسية", groupItems: items, groupId: "1");
    carts.add(cartGroup);
    _controller.sink.add(carts);*/
  }

  @override
  void dispose() {
    _controller.close();
  }
}
