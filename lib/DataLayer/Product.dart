import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/DataLayer/tab.dart';

class Product {
  String title;
  String id;
  String image;
  String price;
  String size;
  ProductTab catigory;
  bool is_offer;
  bool is_package;
  Product(
      {this.title, this.image, this.price, this.size, this.catigory,
        this.id,this.is_offer,this.is_package});
}
