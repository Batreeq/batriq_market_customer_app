import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:customerapp/shared_data.dart';

import 'HomePage.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyScreen();
  }
}

class _PrivacyPolicyScreen extends State {

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return Center(
      child: Scaffold(
        appBar: sharedData.appBar(context, 'Privacy ', Icon (Icons.arrow_forward), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
              (BuildContext context) => HomePagee()));
        }),
        body: SingleChildScrollView(child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(sharedData.privacyTitle,
              textAlign: TextAlign.center, style: sharedData.appBarTextStyle,),
            Container(
              width: size.width,
              height: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(sharedData.privacyImage)
                  )
              ),
            ),
            Text(sharedData.privacyText,
              textAlign: TextAlign.center, style: sharedData.optionStyle,),
          ],
        )),
      ),
    );
  }
}