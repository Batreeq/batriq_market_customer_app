import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrivacyScreen();
  }
}

class _PrivacyScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: sharedData.appBar(context, 'Privacy ', null, () {}),
        body: SingleChildScrollView(child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GFAvatar(
                  size: 70,
                  backgroundImage: NetworkImage(
                    sharedData.profileImage,
                  ),
                ),
              ),
            ),
            Text(sharedData.termsText,
              textAlign: TextAlign.center,),
          ],
        )),
      ),
    );
  }
}