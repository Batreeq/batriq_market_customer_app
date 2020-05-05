import 'package:customerapp/UI/screens/ping/HomePage.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUserLocation();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale('ar', 'AE'),
      title: 'بطريق ماركت',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primary_color,
        accentColor: primary_color,
        fontFamily: 'default',
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
