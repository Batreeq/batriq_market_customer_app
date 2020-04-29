import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:customerapp/shared_data.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyScreen();
  }
}

class _PrivacyPolicyScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: sharedData.appBar(context, 'Privacy ', null, () {}),
        body: SingleChildScrollView(child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(sharedData.privacyTitle,
              textAlign: TextAlign.center,style: sharedData.appBarTextStyle,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GFAvatar(
                  size: 70,
                  backgroundImage: NetworkImage(
                    sharedData.privacyImage,
                  ),
                ),
              ),
            ),
            Text(sharedData.privacyText,
              textAlign: TextAlign.center,style: sharedData.optionStyle,),
          ],
        )),
      ),
    );
  }
}
