
import 'package:customerapp/models/ListOfMyOrders.dart';
import 'package:customerapp/models/ProductDetailsModel.dart';

class PostsModel {
    String created_at;
    int id;
    String image;
    ProductDetailsModel product_details;
    String product_id;
    String product_name;
    String updated_at;

    PostsModel({this.created_at, this.id, this.image, this.product_details, this.product_id, this.product_name, this.updated_at});

    factory PostsModel.fromJson(Map<String, dynamic> json) {
        return PostsModel(
            created_at: json['created_at'], 
            id: json['id'], 
            image: json['image'], 
            product_details: json['product_details'] != null ? ProductDetailsModel.fromJson(json['product_details']) : null,
            product_id: json['product_id'], 
            product_name: json['product_name'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['image'] = this.image;
        data['product_id'] = this.product_id;
        data['product_name'] = this.product_name;
        data['updated_at'] = this.updated_at;
        if (this.product_details != null) {
            data['product_details'] = this.product_details.toJson();
        }
        return data;
    }
}