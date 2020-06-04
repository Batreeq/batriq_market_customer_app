import 'package:flutter/cupertino.dart';

class ConfrimOrderModel {
  String user_name;
  String phone;
  String location;
  String notice;
  String payment_type;
  String api_token;
  String cart_num;
  String city;
  String region;
  String delivery_times;
  String total_price;
  String cart_price;
  String copon_id;

  ConfrimOrderModel({
    @required this.api_token,
    @required this.user_name,
    @required this.phone,
    @required this.city,
    @required this.region,
    @required this.location,
    @required this.notice,
    @required this.payment_type,
    @required this.delivery_times,
    @required this.cart_price,
    @required this.total_price,
    @required this.cart_num,
    @required this.copon_id
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.user_name;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['notice'] = this.notice;
    data['payment_type'] = this.payment_type;
    data['api_token'] = this.api_token;
    data['cart_num'] = this.cart_num;
    data['city'] = this.city;
    data['region'] = this.region;
    data['total_price'] = this.total_price;
    data['copoun_id'] = this.copon_id;
    data['cart_price'] = this.cart_price;
    data['delivery'] = this.delivery_times;
    return data;
  }
}