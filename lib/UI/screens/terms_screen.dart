import 'package:flutter/material.dart';

import 'package:customerapp/shared_data.dart';

class TermsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TermsScreen();
  }
}

class _TermsScreen extends State {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Center(
      child: Scaffold(
        appBar:
            sharedData.appBar(context, 'Terms and Conditions ', null, () {}),
        body: SingleChildScrollView(
            child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sharedData.termsTitle,
                textAlign: TextAlign.center,
                style: sharedData.appBarTextStyle,
              ),
            ),
            Container(
              width: size.width,
              height: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(sharedData.termsImage))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sharedData.termsText,
                textAlign: TextAlign.center,
                style: sharedData.optionStyle,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
