class CartToAdd {
  String id;
  String productId;
  String title;
  String date;
  String quantity;
  String price;
  String size;
  String image;

  CartToAdd(
      {this.id,
      this.title,
      this.quantity,
      this.price,
      this.size,
      this.image,
      this.date,
      this.productId});

  Map<String, dynamic> toJson() {
    return {
      "product_id": this.productId,
      "quantity": this.quantity,
      "price": this.price,
    };
  }
}
