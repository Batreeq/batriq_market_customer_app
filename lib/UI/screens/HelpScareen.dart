import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:customerapp/shared_data.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpScreen();
  }
}

class _HelpScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: sharedData.appBar(context, 'المساعدة', null, () {}),
        body: SingleChildScrollView(
            child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sharedData.helpTitle,
                textAlign: TextAlign.center,
                style: sharedData.appBarTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GFAvatar(
                  size: 70,
                  backgroundImage: NetworkImage(
                    sharedData.helpImage,
                  ),
                ),
              ),
            ),
            Text(
              sharedData.helpText,
              textAlign: TextAlign.center,
              style: sharedData.optionStyle,
            ),
          ],
        )),
      ),
    );
  }
}
