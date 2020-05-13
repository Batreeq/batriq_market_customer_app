class PointsProducts {
  List<ProductsFromPoints> pointsProducts;

  PointsProducts({this.pointsProducts});

  PointsProducts.fromJson(Map<String, dynamic> json) {
    if (json['points_products'] != null) {
      pointsProducts = new List<ProductsFromPoints>();
      json['points_products'].forEach((v) {
        pointsProducts.add(new ProductsFromPoints.fromJson(v));
      });
    }
  }
}

class ProductsFromPoints {
  int id;
  String productName;
  String productImage;
  String points;
  Null createdAt;
  Null updatedAt;

  ProductsFromPoints(
      {this.id,
      this.productName,
      this.productImage,
      this.points,
      this.createdAt,
      this.updatedAt});

  ProductsFromPoints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
