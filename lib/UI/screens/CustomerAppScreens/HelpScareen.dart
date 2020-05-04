import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:customerapp/shared_data.dart';

import 'HomePage.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpScreen();
  }
}

class _HelpScreen extends State {
  Size size ;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size ;
    return Center(
      child: Scaffold(
        appBar: sharedData.appBar(
            context, 'Help', null, () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
              (BuildContext context) => HomePagee()));
        }),
        body: SingleChildScrollView(
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sharedData.helpTitle,
                    textAlign: TextAlign.center,style:  sharedData.appBarTextStyle,),
                ),
                Container(
                  width: size.width,
                  height: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(sharedData.helpImage)
                      )
                  ),
                ),
                Text(sharedData.helpText,
                  textAlign: TextAlign.center, style: sharedData.optionStyle,),
              ],
            )),
      ),
    );
  }
}