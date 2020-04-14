 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///this file for shared data between pages

String appBarTitle = "الصفحة الرئيسية";

const primary_color = Color(0xFFFBBF00);
const socondary_color = Color(0xFFFBBF00);

const bottomNavigationBartextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black38);

class sharedData {
  static const ImageIcon homeIcon = ImageIcon(
    AssetImage("assets/images/icons/home.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const ImageIcon teamIcon = ImageIcon(
    AssetImage("assets/images/icons/team.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const ImageIcon cardIcon = ImageIcon(
    AssetImage("assets/images/icons/card.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const ImageIcon chatIcon = ImageIcon(
    AssetImage("assets/images/icons/chat.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const Icon searchIcon = Icon(Icons.search);
  static const Icon menuIcon = Icon(Icons.menu);
  static const Icon phoneIcon = Icon(Icons.phone , color: sharedData.yellow,);
  static const Icon locationIcon = Icon(Icons.location_on , color: sharedData.yellow,);
  static const Icon emailIcon = Icon(Icons.email , color: sharedData.yellow,);

  static const TextStyle navBarTextStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle textInProfileTextStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black , fontSize: 25);
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  static  Color grayColor12 =  new Color (0x1F000000);
  static const Color yellow =  const Color (0xFFFFEB3B);

  static const String searchHintText = 'البحث';
  static const String phoneHintTextField  ='رقم الهاتف';
  static const String  locationHintTextField ='الموقع';
  static const String  emailHintTextField ='البريد الالكتروني';
  static const String  updateProfileTextField ='تعديل الملف الشخصي';
  static const String  textInProfileTextField ='اكمل الملف الشخصي للحصول على جوائز';

  // this list of images urls to put them in the boxes in home screen, should be filled in splash screen from api
  static const List<String> boxesImages = [
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
  ];

  // this list of strings to put them in the boxes in home screen, should be filled in splash screen from api
  static const List<String> boxesTexts = [
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
  ];


  // this list of images urls to put them in the slider in home screen, should be filled in splash screen from api
  static const  List<String> sliderHomeImages = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  static ThemeData appTheme = ThemeData(
    primarySwatch: Colors.yellow,
  );

  //user profile image for the user this is the default image until the user upload another one
  static const String profileImage = 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80';

  //user name
  static const String name = 'محمد محمد';
}
