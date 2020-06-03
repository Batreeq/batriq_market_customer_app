class SearchData {
  List<Products> products;

  SearchData({this.products});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String categoryId;
  String name;
  String size;
  String price;
  String image;
  String quantity;
  String detailsText;
  String detailsTitle;
  String detailsImage;
  String notice;
  var createdAt;
  var updatedAt;
  bool is_offer;

  Products(
      {this.id,
      this.categoryId,
      this.name,
      this.size,
      this.price,
      this.image,
      this.quantity,
      this.detailsText,
      this.detailsTitle,
      this.detailsImage,
      this.notice,
      this.createdAt,
      this.updatedAt,this.is_offer});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    size = json['size'];
    price = json['price'];
    image = json['image'];
    quantity = json['quantity'];
    detailsText = json['details_text'];
    detailsTitle = json['details_title'];
    detailsImage = json['details_image'];
    notice = json['notice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    is_offer = json['is_offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['size'] = this.size;
    data['price'] = this.price;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['details_text'] = this.detailsText;
    data['details_title'] = this.detailsTitle;
    data['details_image'] = this.detailsImage;
    data['notice'] = this.notice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_offer'] = this.is_offer;
    return data;
  }
}
