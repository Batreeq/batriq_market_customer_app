import 'dart:async';
import 'dart:convert';
import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/DataLayer/CartGroup.dart';
import 'package:customerapp/helpers/DBHelper.dart';
import 'bloc.dart';
import 'package:http/http.dart' as http;

class CartGroupBloc implements Bloc {
  final _controller = StreamController<List<CartGroup>>();
  Stream<List<CartGroup>> get cartDataStream => _controller.stream;
  Future<void> getCartData(token) async {
    final url =
        "https://jaraapp.com/index.php/api/getUserCart?api_token=$token";
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    List<CartGroup> userCarts = [];
    extractedData['user_cart'].forEach((group) {
      List<Cart> groupData = [];
      group.forEach((cart) {
        Cart cartitem = Cart(
            title: cart['product_details']['name'],
            id: cart['id'].toString(),
            quantity: cart['quantity'],
            price: cart['price'],
            image: cart['product_details']['image'],
            size: cart['product_details']['size']);
        groupData.add(cartitem);
      });
      CartGroup cartGroup = CartGroup(
          groupId: group[0]['cart_num'],
          groupName: group[0]['cart_title'],
          groupItems: groupData);
      userCarts.add(cartGroup);
    });
    print(token);
    _controller.sink.add(userCarts);
  }

  Future<void> fetchCartData() async {
    List<CartGroup> carts = [];
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
    _controller.sink.add(carts);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
