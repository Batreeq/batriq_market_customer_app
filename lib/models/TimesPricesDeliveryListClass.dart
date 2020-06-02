class TimesPricesListClass {
  List<TimesPrices> timesPrices;
  List<Barcode> barcode;

  TimesPricesListClass({this.timesPrices, this.barcode});

  TimesPricesListClass.fromJson(Map<String, dynamic> json) {
    if (json['times_prices'] != null) {
      timesPrices = new List<TimesPrices>();
      json['times_prices'].forEach((v) {
        timesPrices.add(new TimesPrices.fromJson(v));
      });
    }
    if (json['barcode'] != null) {
      barcode = new List<Barcode>();
      json['barcode'].forEach((v) {
        barcode.add(new Barcode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timesPrices != null) {
      data['times_prices'] = this.timesPrices.map((v) => v.toJson()).toList();
    }
    if (this.barcode != null) {
      data['barcode'] = this.barcode.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesPrices {
  List<Category> category;

  TimesPrices({this.category});

  TimesPrices.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String locationId;
  String time;
  String price;
  String createdAt;
  String updatedAt;
  String type;
  String lang;
  String categoryId;
  String categoryName;

  Category(
      {this.id,
        this.locationId,
        this.time,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.lang,
        this.categoryId,
        this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    time = json['time'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    lang = json['lang'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['time'] = this.time;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['lang'] = this.lang;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Barcode {
  int id;
  String code;
  String type;
  String productId;
  double value;
  String numUsage;
  String createdAt;
  String updatedAt;
  String lang;

  Barcode(
      {this.id,
        this.code,
        this.type,
        this.productId,
        this.value,
        this.numUsage,
        this.createdAt,
        this.updatedAt,
        this.lang});

  Barcode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    productId = json['product_id'];
    value = json['value'];
    numUsage = json['num_usage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['product_id'] = this.productId;
    data['value'] = this.value;
    data['num_usage'] = this.numUsage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['lang'] = this.lang;
    return data;
  }
}