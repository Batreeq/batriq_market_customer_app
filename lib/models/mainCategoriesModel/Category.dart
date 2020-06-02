import 'package:customerapp/models/mainCategoriesModel/AllProduct.dart';
import 'package:customerapp/models/mainCategoriesModel/SubCategory.dart';

class Category {
    List<AllProduct> all_products;
    String category_id;
    String created_at;
    int id;
    String lang;
    String name;
    List<SubCategory> sub_categories;
    String updated_at;

    Category({this.all_products, this.category_id, this.created_at, this.id, this.lang, this.name, this.sub_categories, this.updated_at});

    factory Category.fromJson(Map<String, dynamic> json) {
        return Category(
            all_products: json['all_products'] != null ? (json['all_products'] as List).map((i) => AllProduct.fromJson(i)).toList() : null, 
            category_id: json['category_id'], 
            created_at: json['created_at'], 
            id: json['id'], 
            lang: json['lang'], 
            name: json['name'], 
            sub_categories: json['sub_categories'] != null ? (json['sub_categories'] as List).map((i) => SubCategory.fromJson(i)).toList() : null, 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.category_id;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['lang'] = this.lang;
        data['name'] = this.name;
        data['updated_at'] = this.updated_at;
        if (this.all_products != null) {
            data['all_products'] = this.all_products.map((v) => v.toJson()).toList();
        }
        if (this.sub_categories != null) {
            data['sub_categories'] = this.sub_categories.map((v) => v.toJson()).toList();
        }
        return data;
    }
}