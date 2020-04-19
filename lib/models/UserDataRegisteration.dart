import 'package:customerapp/models/UserInfo.dart';

class UserDataWithToken {
  UserInfo success;

  UserDataWithToken({this.success});

  UserDataWithToken.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new UserInfo.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson(true);
    }
    return data;
  }
}