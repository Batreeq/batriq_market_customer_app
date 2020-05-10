import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/DataLayer/tab.dart';

class Product {
  String title;
  String id;
  String image;
  String price;
  String size;
  ProductTab catigory;
  Product(
      {this.title, this.image, this.price, this.size, this.catigory, this.id});
}
