
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  int currentPage = 1;
  final scaffoldKey;
  CustomAppBar({this.currentPage, this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/app_bar_background.png',
            height: 75,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            right: 5,
            bottom: 10,
            child: FlatButton(
              onPressed: () {
                scaffoldKey.currentState.openEndDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  'assets/images/menu.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
