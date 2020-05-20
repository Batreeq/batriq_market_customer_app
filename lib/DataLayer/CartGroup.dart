import 'dart:convert';

import 'package:customerapp/DataLayer/Cart.dart';

class CartGroup {
  String groupId;
  String groupName;
  List<CartToAdd> groupItems;

  CartGroup({this.groupId, this.groupName, this.groupItems});
}
