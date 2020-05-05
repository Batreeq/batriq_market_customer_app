import 'dart:convert';

import 'package:customerapp/DataLayer/Cart.dart';

class CartGroup {
  String groupId;
  String groupName;
  List<Cart> groupItems;

  CartGroup({this.groupId, this.groupName, this.groupItems});
}
