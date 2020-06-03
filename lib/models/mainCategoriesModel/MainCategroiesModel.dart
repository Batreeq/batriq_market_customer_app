import 'package:customerapp/models/mainCategoriesModel/Category.dart';

class MainCategroiesModel {
    List<Category> categories;

    MainCategroiesModel({this.categories});

    factory MainCategroiesModel.fromJson(Map<String, dynamic> json) {
        return MainCategroiesModel(
            categories: json['categories'] != null ? (json['categories'] as List).map((i) => Category.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.categories != null) {
            data['categories'] = this.categories.map((v) => v.toJson()).toList();
        }
        return data;
    }
}