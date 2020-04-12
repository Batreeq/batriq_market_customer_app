import 'package:customerapp/UI/screens/cart_screen.dart';
import 'package:customerapp/UI/screens/chat_screen.dart';
import 'package:customerapp/UI/screens/home_screen.dart';
import 'package:customerapp/UI/screens/work_with_us_screen.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class bottomNavigationBar extends StatefulWidget {
  static const routeName = '/bottom_nav';
  bottomNavigationBar() {}
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int currentIndex = 1;

  ///  selcted nav page
  Widget callPage(int current) {
    switch (current) {
      case 3:
        return new HomeScreen();
      case 2:
        return new WorkWithUsScreen();
      case 1:
        return new CartScreen();
        break;
      case 0:
        return new ChatScreen();
        break;
      default:
        return HomeScreen();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      const Color(0xFFf6b93b),
//      const Color(0xFFe55039),
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Color(0xFF676767)))),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.6, 0.9],
                    colors: [Colors.red, Colors.blue])),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    title: Text(
                      "المراسلة",
                      style: bottomNavigationBartextStyle,
                    )),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text(
                    "سلة المشتريات",
                    style: bottomNavigationBartextStyle,
                  ),
                ),
                BottomNavigationBarItem(
                    backgroundColor: Colors.green,
                    icon: Icon(Icons.work),
                    title:
                        Text("اعمل معتا", style: bottomNavigationBartextStyle)),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 24.0,
                    ),
                    title: Text(
                      "الرئيسية",
                      style: bottomNavigationBartextStyle,
                    )),
              ],
              fixedColor: Color(0xFFffa801),
            ),
          )),
    );
  }
}
//Flutter
