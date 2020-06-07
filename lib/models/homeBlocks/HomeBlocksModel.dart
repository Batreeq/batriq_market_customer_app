
import 'package:customerapp/models/homeBlocks/CategoryHomeBlocks.dart';

class HomeBlocksModel {
    List<CategoryHomeBlocks> categories;
    String created_at;
    int id;
    String image;
    String lang;
    String name;
    String order;
    String updated_at;

    HomeBlocksModel({this.categories, this.created_at, this.id, this.image, this.lang, this.name, this.order, this.updated_at});

    factory HomeBlocksModel.fromJson(Map<String, dynamic> json) {
        return HomeBlocksModel(
            categories: json['categories'] != null ? (json['categories'] as List).map((i) => CategoryHomeBlocks.fromJson(i)).toList() : null,
            created_at: json['created_at'], 
            id: json['id'], 
            image: json['image'], 
            lang: json['lang'], 
            name: json['name'], 
            order: json['order'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['image'] = this.image;
        data['lang'] = this.lang;
        data['name'] = this.name;
        data['order'] = this.order;
        data['updated_at'] = this.updated_at;
        if (this.categories != null) {
            data['categories'] = this.categories.map((v) => v.toJson()).toList();
        }
        return data;
    }
}