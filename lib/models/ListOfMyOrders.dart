class ListOfMyOrders {
  List<Orders> orders;

  ListOfMyOrders({this.orders});

  ListOfMyOrders.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int id;
  String userName;
  String userId;
  String phone;
  String city;
  String region;
  String location;
  String notice;
  String deliveryType;
  String paymentType;
  String totalPrice;
  String deliveryTime;
  List<OrderDetails> orderDetails;
  String status;
  String createdAt;
  String updatedAt;
  String createdDate;
  String createdTime;

  Orders(
      {this.id,
        this.userName,
        this.userId,
        this.phone,
        this.city,
        this.region,
        this.location,
        this.notice,
        this.deliveryType,
        this.paymentType,
        this.totalPrice,
        this.deliveryTime,
        this.orderDetails,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdDate,
        this.createdTime});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userId = json['user_id'];
    phone = json['phone'];
    city = json['city'];
    region = json['region'];
    location = json['location'];
    notice = json['notice'];
    deliveryType = json['delivery_type'];
    paymentType = json['payment_type'];
    totalPrice = json['total_price'];
    deliveryTime = json['delivery_time'];
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['region'] = this.region;
    data['location'] = this.location;
    data['notice'] = this.notice;
    data['delivery_type'] = this.deliveryType;
    data['payment_type'] = this.paymentType;
    data['total_price'] = this.totalPrice;
    data['delivery_time'] = this.deliveryTime;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_date'] = this.createdDate;
    data['created_time'] = this.createdTime;
    return data;
  }
}

class OrderDetails {
  String quantity;
  String price;
  String totalPrice;
  ProductDetails productDetails;
  String categoryName;

  OrderDetails(
      {this.quantity,
        this.price,
        this.totalPrice,
        this.productDetails,
        this.categoryName});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    categoryName = json['catrgory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails.toJson();
    }
    data['catrgory_name'] = this.categoryName;
    return data;
  }
}

class ProductDetails {
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
  String createdAt;
  String updatedAt;
  String productSource;
  String specialPrice;
  String specialPriceFor;
  String offersIds;

  ProductDetails(
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
        this.specialPrice,
        this.specialPriceFor,
        this.offersIds});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
    productSource = json['product_source'];
    specialPrice = json['special_price'];
    specialPriceFor = json['special_price_for'];
    offersIds = json['offers_ids'];
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
    data['special_price'] = this.specialPrice;
    data['special_price_for'] = this.specialPriceFor;
    data['offers_ids'] = this.offersIds;
    return data;
  }
}