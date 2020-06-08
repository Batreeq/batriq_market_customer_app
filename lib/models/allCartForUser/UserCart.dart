
import 'package:customerapp/models/allCartForUser/ProductDetail.dart';

class UserCart {
    String cart_num;
    String cart_title;
    String created_at;
    int id;
    String price;
    List<ProductDetail> product_details;
    String product_id;
    int quantity;
    String shared_by;
    String status;
    String total_price;
    String updated_at;
    String user_id;

    UserCart({this.cart_num, this.cart_title, this.created_at, this.id, this.price, this.product_details, this.product_id, this.quantity, this.shared_by, this.status, this.total_price, this.updated_at, this.user_id});

    factory UserCart.fromJson(Map<String, dynamic> json) {
        return UserCart(
            cart_num: json['cart_num'], 
            cart_title: json['cart_title'], 
            created_at: json['created_at'], 
            id: json['id'], 
            price: json['price'], 
            product_details: json['product_details'] != null ? (json['product_details'] as List).map((i) => ProductDetail.fromJson(i)).toList() : null, 
            product_id: json['product_id'], 
            quantity: json['quantity'], 
            shared_by: json['shared_by'], 
            status: json['status'], 
            total_price: json['total_price'], 
            updated_at: json['updated_at'], 
            user_id: json['user_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cart_num'] = this.cart_num;
        data['cart_title'] = this.cart_title;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['price'] = this.price;
        data['product_id'] = this.product_id;
        data['quantity'] = this.quantity;
        data['shared_by'] = this.shared_by;
        data['status'] = this.status;
        data['total_price'] = this.total_price;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        if (this.product_details != null) {
            data['product_details'] = this.product_details.map((v) => v.toJson()).toList();
        }
        return data;
    }
}