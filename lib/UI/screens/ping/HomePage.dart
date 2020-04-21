import 'package:customerapp/DataLayer/Menu.dart';
import 'package:customerapp/UI/Bloc/side_menu_bloc.dart';
import 'package:customerapp/UI/screens/account_screen.dart';
import 'package:customerapp/UI/screens/ping/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared_data.dart';
import '../cart_screen.dart';
import '../work_with_us_screen.dart';
import 'AppBar.dart';

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
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final bloc = SideMenuBloc();
    const String homeTextPage = 'الصفحة الرئيسية';
    const String workWithusText = 'اعمل معنا';
    const String cardText = 'سلة المشتريات';
    const String chatText = 'المراسلة';
    pageController = new PageController();
    List<Widget> _widgetOptions = <Widget>[
      //ChatScreen(),
      AccountScreen(),
      CartScreen(),
      WorkWithUsScreen(),
      Home() //ProfilePage(),
    ];
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          CustomAppBar(
            scaffoldKey: _scaffoldKey,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 140,
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
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
      endDrawer: buildDrawer(bloc), // assign key to Scaffoldq
    );
  }

  Widget buildDrawer(bloc) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(0, 50, 0, 5),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
                height: 100,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'بطريق ماركت',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'default',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              rowSide(Menu(1), context, bloc, titles[0]),
              rowSide(Menu(2), context, bloc, titles[1]),
              rowSide(Menu(3), context, bloc, titles[2]),
              rowSide(Menu(4), context, bloc, titles[3]),
              rowSide(Menu(5), context, bloc, titles[4]),
              rowSide(Menu(6), context, bloc, titles[5]),
              rowSide(Menu(7), context, bloc, titles[5]),
              rowSide(Menu(8), context, bloc, titles[5]),
              rowSide(Menu(9), context, bloc, titles[5]),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowSide(Menu menu, context, SideMenuBloc bloc, String title) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        appBarTitle = title;
        bloc.selectMenu(menu);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              titles[menu.index - 1],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'default',
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                width: 25,
                height: 25,
                child: Image.asset(
                  icons[menu.index - 1],
                  height: 25,
                  width: 25,
                )),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      indent: 20,
      endIndent: 20,
      height: 1,
      color: Colors.orange,
    );
  }
}
