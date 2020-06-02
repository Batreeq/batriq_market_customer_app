import 'dart:async';
import 'dart:convert';

import 'package:customerapp/models/mainCategoriesModel/MainCategroiesModel.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;




final baseUrl = 'https://trusstcommunity.com/admin';


class Response {
  int _statusCode;
  dynamic _object;


  Response(this._statusCode, this._object);

  dynamic get object => this._object;

  set object(dynamic value) {
    this._object = value;
  }

  int get statusCode => this._statusCode;

  set statusCode(int value) {
    this._statusCode = value;
  }
}

Future<Response> getAllMainCategories(String offerID,String token) async {



  try {
    var url=sharedData.mainCategoriesURL+"offer_id=$offerID&api_token=$token";
    print(url);
    var response =await http.get(sharedData.mainCategoriesURL+"offer_id=$offerID&api_token=$token");



    print('code  = ${response.statusCode}');
    print('body of user ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);


        var   userData = MainCategroiesModel.fromJson(data);
        return new Response(200, userData);
    } else {
      return new Response(response.statusCode, response);
    }
  }
  on TimeoutException catch (_) {
    sharedData.flutterToast('Please check your internet connection!');
    return Response(-1000, '');
  }

  catch (e) {
    print(e);
    return new Response(-1, "error");
  }

}


///////////////////////////////////////// DO LOGIN /////////////////////////////////////////
/*Future<Response> doLogin(String type, String email, String password) async {
  Map<String, dynamic> data = {type: email,"password": password,};
  try {
    var response = await http.post('$baseUrl/api/auth/login/$type',
        headers: {'content-type': 'application/json'},
        body: json.encode(data))
        .timeout(Duration(seconds: 15));
    var res = json.decode(response.body);
    print('$baseUrl/api/auth/login/$type');
    print(json.encode(data));
    print('login status code  = ${response.statusCode}');
    if (response.statusCode == 200) {
      if (res['status']) {
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        sharedPreferences.setString('token', res['token'].toString());
        sharedPreferences.setString('loginToken', res['token'].toString());
        sharedPreferences.setString('username', email);
        sharedPreferences.setString('password', password);
        sharedPreferences.setString('typeLogin', type);


        return new Response(200, res['token'].toString());
      } else {
        return new Response(-2, "Login Failed");
      }
    } else if (response.statusCode == 401) {
      return new Response(response.statusCode, res['Messages'].toString());
    } else {
      return new Response(response.statusCode, res);
    }
  }
  on TimeoutException catch (_) {
    showToast('Please check your internet connection!');
    return Response(-3, '');
  }

  catch (e) {
    print(e);
    return new Response(-1, "error");
  }
}*/




////////////////////////////////GET User Info //////////////////////////////////////
/*Future<Response> getUserInfo(String token) async {
  try {
    String _url = '$baseUrl/api/user';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.get(_url, headers: {
      'Authorization': 'Bearer ' + token,
    }).timeout(Duration(seconds: 15));

    print('status code get user info ${response.statusCode}');
    print('body of user ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      bool success = data['status'];
      if (success) {
      var   user = User.fromJson(data['data']);
        user.commission =
        data.containsKey('commission') && data['commission'] != null
            ? double.parse(data['commission'].toString())
            : 1;
        print(user.commission);
        return new Response(200, user);
      } else {
      //  user = null;
        return new Response(1000, null);
      }
    } else {
   //   user = null;
      return new Response(response.statusCode, null);
    }
  }
  on TimeoutException catch (_) {
    showToast('Please check your internet connection!');
    return Response(-3, '');
  }
  catch (exception) {
   // user = null;
    return new Response(-1, null);
  }
}*/


