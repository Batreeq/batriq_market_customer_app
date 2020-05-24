class UserCarts {
  List<Cart> userCart;
  String name ,groupId;

  UserCarts({this.userCart , this.name , this.groupId});

  UserCarts.fromJson(Map<String ,  dynamic> json) {
    if (json ['user_cart'] != null) {
      userCart = new List<Cart>();
      json ['user_cart'].forEach((v) { userCart.add(new Cart.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCart != null) {
      data['user_cart'] = this.userCart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int id;
  String productId;
  String userId;
  int quantity;
  String price;
  String totalPrice;
  String status;
  String createdAt;
  String updatedAt;
  String cartNum;
  String cartTitle;
  String sharedBy;
  List<ProductDetailsFromCart> productDetails;

  Cart(
      {this.id,
        this.productId,
        this.userId,
        this.quantity,
        this.price,
        this.totalPrice,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.cartNum,
        this.cartTitle,
        this.sharedBy,
        this.productDetails});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cartNum = json['cart_num'];
    cartTitle = json['cart_title'];
    sharedBy = json['shared_by'];
    if (json['product_details'] != null) {
      productDetails = new List<ProductDetailsFromCart>();
      json['product_details'].forEach((v) {
        productDetails.add(new ProductDetailsFromCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cart_num'] = this.cartNum;
    data['cart_title'] = this.cartTitle;
    data['shared_by'] = this.sharedBy;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetailsFromCart {
  int id;
  String categoryId;
  String name;
  String size;
  String price;
  String image;
  int quantity;
  String detailsText;
  String detailsTitle;
  String detailsImage;
  String notice;
  String createdAt;
  String updatedAt;
  String productSource;
  String specialPriceFor;
  String offersIds;
  String wholesalePrice;
  String points;
  String barcode;

  ProductDetailsFromCart(
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
        this.updatedAt,
        this.productSource,
        this.specialPriceFor,
        this.offersIds,
        this.wholesalePrice,
        this.points,
        this.barcode});

  ProductDetailsFromCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    size = json['size'];
    price = json['price'].toString();
    image = json['image'];
    quantity = json['quantity'];
    detailsText = json['details_text'];
    detailsTitle = json['details_title'];
    detailsImage = json['details_image'];
    notice = json['notice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productSource = json['product_source'];
    specialPriceFor = json['special_price_for'];
    offersIds = json['offers_ids'];
    wholesalePrice = json['wholesale_price'];
    points = json['points'];
    barcode = json['barcode'];
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
    data['product_source'] = this.productSource;
    data['special_price_for'] = this.specialPriceFor;
    data['offers_ids'] = this.offersIds;
    data['wholesale_price'] = this.wholesalePrice;
    data['points'] = this.points;
    data['barcode'] = this.barcode;
    return data;
  }
}