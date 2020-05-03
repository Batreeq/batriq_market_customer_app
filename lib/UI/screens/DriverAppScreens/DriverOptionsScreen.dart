import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PlacesAndTimes.dart';
import 'TripsCounter.dart';
import 'TripsNotConfirmedYet.dart';

class DriverOptionsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DriverOptionsScreen();
  }
}

class _DriverOptionsScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: sharedData.appBar(context, 'السائق', null, () {}),
      body: getBody(),
    );
  }

  Widget getBody() {
    // this list for the home buttons
    List<String> users = new List<String>();
    users.add('عداد الجولات');
    users.add('جولات قيد التأكيد');
    users.add('كشف حساب اجمالي');
    users.add('الجولات المتفق عليها');
    users.add('جهز للموظف');
    users.add('أوقات و أماكن مفضلة');

    // this method to get the buttons in the home page after the driver login
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sharedData.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.only (right : 8.0 , left : 8 , top :1 , bottom: 1),
                        child: Center(
                          child: Text(
                            users.elementAt(0),
                            style: sharedData.optionStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('hi ' + users.elementAt(0));
                     onTap(0);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sharedData.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          users.elementAt(1),
                          style: sharedData.optionStyle,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('hi ' + users.elementAt(1));
                     onTap(1);
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sharedData.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          users.elementAt(2),
                          style: sharedData.optionStyle,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('hi ' + users.elementAt(2));
                    onTap(2);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sharedData.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          users.elementAt(3),
                          style: sharedData.optionStyle,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('hi ' + users.elementAt(3));
                   onTap(3);
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sharedData.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          users.elementAt(4),
                          style: sharedData.optionStyle,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('hi ' + users.elementAt(4));
                    onTap(4);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sharedData.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          users.elementAt(5),
                          style: sharedData.optionStyle,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('hi ' + users.elementAt(5));
                    onTap(5);
                  },
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
          Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext c) => TripsCounter()));
          break;
        }
      case 1 :
        {
          Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext c) => TripsNotConfirmedYet()));
          break;
        }
      case 2 :
        {
          break;
        }
      case 3 :
        {
          break;
        }
      case 4 :
        {
          break;
        }
      case 5 :
        {
          Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext c) => PlacesAndTimes()));
          break;
        }
    }
  }
}