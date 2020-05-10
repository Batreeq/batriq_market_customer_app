import 'package:customerapp/Bloc/side_menu_bloc.dart';
import 'package:customerapp/UI/screens/balance_screen.dart';
import 'package:customerapp/UI/screens/language_screen.dart';
import 'package:customerapp/UI/screens/my_orders_screen.dart';
import 'package:customerapp/UI/screens/ping/Home.dart';
import 'package:customerapp/UI/screens/ping/profile_screen.dart';
import 'package:customerapp/UI/screens/privacy_policy_screen.dart';
import 'package:customerapp/UI/screens/terms_screen.dart';
import 'package:customerapp/UI/screens/EarnWithUs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared_data.dart';
import '../HelpScareen.dart';
import '../cart_screen.dart';
import '../messageing_screen.dart';
import '../work_with_us_screen.dart';
import 'SearchBar.dart';

class HomePagee extends StatefulWidget {
  HomePagee({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagee> {
  int _selectedIndex = 0;
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
      Home(),
      WorkWithUsScreen(),
      CartScreen(),
      MessagingScreen(),
      //ProfilePage(),
    ];
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          CustomAppBar(
            scaffoldKey: _scaffoldKey,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

//        // unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: sharedData.homeIcon,
            title: Text(
              homeTextPage,
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
            icon: sharedData.cardIcon,
            title: Text(
              cardText,
              style: sharedData.navBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: sharedData.chatIcon,
            title: Text(
              chatText,
              style: sharedData.navBarTextStyle,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: sharedData.mainColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      drawer: buildDrawer(bloc), // assign key to Scaffoldq
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
              rowSide(1, context, bloc, titles[0]),
              rowSide(2, context, bloc, titles[1]),
              rowSide(3, context, bloc, titles[2]),
              rowSide(4, context, bloc, titles[3]),
              rowSide(5, context, bloc, titles[4]),
              rowSide(6, context, bloc, titles[5]),
              rowSide(7, context, bloc, titles[5]),
              rowSide(8, context, bloc, titles[5]),
              token != null && token.length > 10
                  ? rowSide(9, context, bloc, titles[5])
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  ///menu pages
  List<Widget> sidMenuPages = [
    ProfileScreen(),
    MyOrdersScreen(),
    BalanceScreen(),
    EarnWithUsScreen(),
    HelpScreen(),
    PrivacyPolicyScreen(),
    TermsScreen(),
    LanguageScreen()
  ];
  void navigateTo(int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => sidMenuPages[index - 1]));
  }

  Widget rowSide(int index, context, SideMenuBloc bloc, String title) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (index <= 7) {
          navigateTo(index);
        } else {
          if (index == 8) {
            sharedData.flutterToast("language api not integrated yet");
          } else if (index == 9) {
            sharedData.logout();
            setState(() {
              token = "";
            });
          }
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                width: 25,
                height: 25,
                child: Image.asset(
                  icons[index - 1],
                  height: 25,
                  width: 25,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              titles[index - 1],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'default',
              ),
              textAlign: TextAlign.end,
            ),
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
      color: sharedData.mainColor,
    );
  }

  @override
  void initState() {
    super.initState();
    readToken();
  }
}
