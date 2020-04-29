import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UI/screens/CustomerAppScreens/HomePage.dart';
import 'UI/screens/CustomerAppScreens/splash_screen.dart';

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
        '/home': (context) => HomePagee(),
      },
    );
  }
}