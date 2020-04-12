import 'package:customerapp/UI/screens/home_screen.dart';
import 'package:customerapp/UI/screens/ping/HomePage.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customerapp/UI/bottom_navigation.dart';

import 'UI/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    return new MaterialApp(
      title: 'بطريق ماركت',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primary_color,
        accentColor: primary_color,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

      /// Routes
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomeScreen(),
        bottomNavigationBar.routeName: (context) => HomePagee(),
      },
    );
  }
}
