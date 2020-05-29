class MyMultiCardModel{
  String product_id;
  String quantity;
  String price;
  String total_price;

  MyMultiCardModel(
      this.product_id, this.quantity, this.price, this.total_price);

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.total_price;


    return data;
  }

}
