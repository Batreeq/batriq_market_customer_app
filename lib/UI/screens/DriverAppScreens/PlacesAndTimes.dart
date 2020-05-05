import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DriverTimes.dart';

class PlacesAndTimes  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PlacesAndTimes();
  }
}

class _PlacesAndTimes  extends State {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;

    return
      Scaffold(
        appBar: sharedData.appBar(context, 'السائق', null, () {}),
        body: getBody(),
      );
  }

  getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 150,),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext c) => DriverTimes()));
              },
              color: sharedData.yellow,
              child: Text('أدخل الأوقات المفضلة لديك للعمل',
                style: sharedData.appBarTextStyle,),
            ),
          ),
        ),
        SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext c) => DriverPlaces()));
              },
              color: sharedData.yellow,
              child: Text('أدخل مكان منطقة العمل المفضلة لديك',
                style: sharedData.appBarTextStyle,),
            ),
          ),
        ),
      ],
    );
  }
}