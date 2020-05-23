import 'dart:convert';

import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/models/UserCarts.dart';

class CartGroup {
  String groupId;
  String groupName;
  List<Cart> groupItems;

  CartGroup({this.groupId, this.groupName, this.groupItems});
}