class MyProductModel{

  String id;
  String name;
  String size;
  String price;
  String count;
  String image;

  MyProductModel(
      this.id, this.name, this.size, this.price, this.count, this.image);


  MyProductModel.formJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    size = json['size'];
    price = json['price'];
    image = json['image'];
  }




  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['price'] = this.price;
    data['image'] = this.image;

    return data;
  }

}