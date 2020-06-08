import 'package:customerapp/models/allCartForUser/UserCart.dart';

class AllCartModel {
    List<UserCart> user_cart;

    AllCartModel({this.user_cart});

    factory AllCartModel.fromJson(Map<String, dynamic> json) {
        return AllCartModel(
            user_cart: json['user_cart'] != null ? (json['user_cart'] as List).map((i) => UserCart.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.user_cart != null) {
            data['user_cart'] = this.user_cart.map((v) => v.toJson()).toList();
        }
        return data;
    }
}