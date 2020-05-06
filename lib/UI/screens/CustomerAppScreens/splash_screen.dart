import 'dart:async';
import 'dart:convert';
import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/DataLayer/tab.dart';
 import 'package:customerapp/models/UserBalance.dart';
import 'package:customerapp/models/UserInfo.dart';
import 'package:customerapp/models/UserPayments.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void NavigatorPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePagee(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startHome();
  }

  startHome() async {
    token = await sharedData.readFromStorage(key: 'token');
    print("splash : $token");
    isRegistered() ? getSplashData(token) : getSplashData("");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        "assets/images/logo.png",
        width: 150,
        height: 150,
        fit: BoxFit.fill,
      )),
    );
  }

  Future<void> getSplashData(api_token) async {
    print("tokken $api_token");
    final url = 'https://jaraapp.com/index.php/api/splash?api_token=$api_token';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData['homeBlocks'].forEach((catigoryData) {
      print("ssd${catigoryData['image']}");
      Catigory catigory = Catigory(
          id: catigoryData['order'],
          image: catigoryData['image'],
          name: catigoryData['name']);
      sharedData.catigoriesData.add(catigory);
    });
    extractedData['categories'].forEach((tabdata) {
      ProductTab tab =
          ProductTab(id: tabdata['id'].toString(), name: tabdata['name']);
      tabs.add(tab);
    });
    extractedData['homeSliders'].forEach((image) {
      sharedData.sliderHomeImages.add(image['image']);
    });

    final balance = extractedData['user_balance'];

    if (isRegistered()) {
      balance != "0"
          ? sharedData.userBalance = UserBalance(
              activeBalance: balance['active_balance'].toString(),
              inactiveBalance: balance['inactive_balance'].toString(),
              totalBalance: balance['total_balance'].toString())
          : null;
      extractedData['user_payments'].forEach((payment) {
        sharedData.listOfUserPayment.add(UserPayments(
            id: payment['id'],
            details: payment['details'],
            amount: payment['id'].toString(),
            totalBalance: payment['total_balance'],
            inactiveBalance: payment['inactive_balance'],
            activeBalance: payment['active_balance'],
            createdAt: payment['created_at'],
            createdDate: payment['created_date'],
            creditDebt: payment['Credit_debt'],
            updatedAt: payment['updated_at'],
            userId: payment['user_id']));
      });

      extractedData['family_members'].forEach((family) {
        sharedData.familyMembers.add(FamilyMembers(
            updatedAt: family['updated_at'],
            createdAt: family['created_at'],
            id: family['id'],
            name: family['name'],
            age: family['age'],
            gender: family['gender'],
            userId: family['user_id']));
      });
      final userInfo = extractedData['user_info'];
      sharedData.userInfo = UserInfo(
        updatedAt: userInfo['updated_at'],
        id: userInfo['id'],
        image: userInfo['image'],
        activeAvg: userInfo['active_avg'],
        activeBalance: userInfo['active_balance'],
        apiToken: userInfo['api_token'],
        createdAt: userInfo['created_at'],
        email: userInfo['email'],
        emailVerifiedAt: userInfo['email_verified_at'],
        inactiveBalance: userInfo['inactive_balance'],
        location: userInfo['location'],
        name: userInfo['name'],
        phone: userInfo['phone'],
        pinCode: userInfo['pin_code'],
        pinDate: userInfo['pin_date'],
        points: userInfo['points'],
        role: userInfo['role'],
        salary: userInfo['salary'],
      );
    }
    sharedData.helpText = extractedData['HelpScreen'][0]['text'];
    sharedData.helpTitle = extractedData['HelpScreen'][0]['title'];
    sharedData.privacyText = extractedData['PrivacyPolicy'][0]['text'];
    sharedData.privacyTitle = extractedData['PrivacyPolicy'][0]['title'];
    sharedData.termsText = extractedData['termsAndConditions'][0]['text'];
    sharedData.termsTitle = extractedData['termsAndConditions'][0]['title'];
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new HomePagee()),
    );
  }
}
