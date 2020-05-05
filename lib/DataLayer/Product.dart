import 'package:customerapp/DataLayer/Catigory.dart';

class Product {
  String title;
  String id;
  String image;
  String price;
  String size;
  Catigory catigory;
  Product({this.title, this.image, this.price, this.size, this.catigory,this.id});
}
