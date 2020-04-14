import 'package:customerapp/UI/screens/profile_screen.dart';
import 'package:customerapp/UI/screens/ping/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared_data.dart';
import '../cart_screen.dart';
import '../chat_screen.dart';
import '../work_with_us_screen.dart';

class HomePagee extends StatefulWidget {
  HomePagee({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagee> {
  String token;
  int _selectedIndex = 3;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  _HomePageState();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PageController pageController;
  int currentTab = 0;
  _changeCurrentTab(int tab) {
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(tab);
    });
  }

  @override
  Widget build(BuildContext context) {
    const String homeTextPage = 'الصفحة الرئيسية';
    const String workWithusText = 'اعمل معنا';
    const String cardText = 'سلة المشتريات';
    const String chatText = 'المراسلة';
    pageController = new PageController();
    List<Widget> _widgetOptions = <Widget>[
      //ChatScreen(),
      ProfileScreen(),
      CartScreen(),
      WorkWithUsScreen(),
      Home() //ProfilePage(),
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        //  backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
//        // unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: sharedData.chatIcon,
            title: Text(
              chatText,
              style: sharedData.navBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: sharedData.cardIcon,
            title: Text(
              cardText,
              style: sharedData.navBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: sharedData.teamIcon,
            title: Text(
              workWithusText,
              style: sharedData.navBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: sharedData.homeIcon,
            title: Text(
              homeTextPage,
              style: sharedData.navBarTextStyle,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[200],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
