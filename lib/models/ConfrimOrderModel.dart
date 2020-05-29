class ConfrimOrderModel {
  String user_name;
  String delivery_type;
  String phone;
  String location;
  String notice;
  String payment_type;
  String api_token;
  String cart_num;
  String city;
  String region;
  String delivery_time;

  ConfrimOrderModel(
      this.user_name,
      this.delivery_type,
      this.phone,
      this.location,
      this.notice,
      this.payment_type,
      this.api_token,
      this.cart_num,
      this.city,
      this.region,
      this.delivery_time);




  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.user_name;
    data['delivery_type'] = this.delivery_type;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['notice'] = this.notice;
    data['payment_type'] = this.payment_type;
    data['api_token'] = this.api_token;
    data['cart_num'] = this.cart_num;
    data['city'] = this.city;
    data['region'] = this.region;
    data['delivery_time'] = this.delivery_time;
    return data;
  }
}