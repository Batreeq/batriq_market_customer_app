import 'package:customerapp/UI/bottom_navigation.dart';
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
  static const String searchHintText = 'البحث';
  static const TextStyle navBarTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

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
  static ThemeData appTheme = ThemeData(
    primarySwatch: Colors.yellow,
  );
}
