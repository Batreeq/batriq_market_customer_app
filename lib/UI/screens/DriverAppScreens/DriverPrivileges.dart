import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginDriver.dart';

class DriverPrivileges extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DriverPrivileges();
  }
}

class _DriverPrivileges extends State {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;

    return
      Scaffold(
        appBar: sharedData.appBar(context, 'اعمل معنا', null, () {}),
        body: getBody(),
      );
  }

  getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width,
          height: 170,
          decoration: BoxDecoration(
              color: Colors.grey
          ),
          child: Center(child: Text('Vedio ')),
        ),
        SizedBox(height: 70,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c )=> LoginDriver()));},
              color: sharedData.yellow,
              child: Text('تسجيل الدخول' , style:  sharedData.appBarTextStyle,),
            ),
          ),
        ),
        SizedBox(height: 70,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              onPressed: () {},
              color: sharedData.yellow,
              child: Text(' طلب صلاحية سائق' , style:  sharedData.appBarTextStyle,),
            ),
          ),
        ),
      ],
    );
  }
}