import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AgreedTrips.dart';
import 'BalanceDetails.dart';
import 'PlacesAndTimes.dart';
import 'TripsCounter.dart';
import 'TripsNotConfirmedYet.dart';

class DriverPlaces extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _DriverPlaces();
  }
}

class _DriverPlaces extends State {
  Size size ;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size ;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: sharedData.appBar(context, 'الأماكن المفضلة', null, () {}),
      body: getBody(),
    );
  }

  Widget getBody() {
    // this list for the home buttons
    List<String> users = new List<String>();
    users.add('مواقع التواجد الدائم');
    users.add('موقع مفضل للعمل 1');
    users.add('موقع مفضل للعمل 2');

    // this method to get the buttons in the home page after the driver login
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Center(
            child: InkWell(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: sharedData.yellow)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right : 8.0 , left: 20),
                      child: sharedData.locationIcon,
                    ),
                    SizedBox(width: size.width-290,),
                    Text(users.elementAt(0), style: sharedData.appBarTextStyle,),
                  ],
                ),
              ),
              onTap: () {
                print('hi ' + users.elementAt(0));
                onTap(0);
              },
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Center(
            child: InkWell(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: sharedData.yellow)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right : 8.0 , left: 20),
                      child: sharedData.locationIcon,
                    ),
                    SizedBox(width: size.width-290,),
                    Text(users.elementAt(1), style: sharedData.appBarTextStyle,),
                  ],
                ),
              ),
              onTap: () {
                print('hi ' + users.elementAt(1));
                onTap(1);
              },
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          Center(
            child: InkWell(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: sharedData.yellow)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right : 8.0 , left: 20),
                      child: sharedData.locationIcon,
                    ),
                    SizedBox(width: size.width-290,),
                    Text(users.elementAt(2), style: sharedData.appBarTextStyle,),
                  ],
                ),
              ),
              onTap: () {
                print('hi ' + users.elementAt(2));
                onTap(2);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getButtons() {
    return Column(
      children: <Widget>[
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Column(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text('السابق')
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width-200,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Column(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text('التالي')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  onTap(int element) {
    switch (element) {
      case 0 :
        {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext c) => TripsCounter()));
          break;
        }
      case 1 :
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext c) => TripsNotConfirmedYet()));
          break;
        }
      case 2 :
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext c) => BalanceDetailsDriver()));
          break;
        }
    }
  }
}