import 'package:customerapp/UI/screens/DriverAppScreens/DriverPrivileges.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/shape/gf_avatar_shape.dart';

class WorkWithUsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WorkWithUsScreen();
  }
}

class _WorkWithUsScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    List<String> users = new List<String>();
    users.add('موظف معنا ');
    users.add(' شريك سوبر ');
    users.add('سائق');
    users.add('تاجر');
    // this method to get the sequers in the home page (include image and text filled form the api)
    return GridView.count(
        shrinkWrap: true,
        // Create a grid with 2 columns.
        crossAxisCount: 2,
        // Generate 4 widgets that display their index in the List.
        children: List.generate(users.length, (index) {
          return Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            users.elementAt(index),
                            style: sharedData.textInProfileTextStyle,
                          ),
                          index == 1
                              ?
                              //
                              Text(
                                  'ماركت',
                                  style: sharedData.textInProfileTextStyle,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  print('hi ' + index.toString() + users.elementAt(index));
                  onTap(users.elementAt(index));
                },
              ));
        }));
  }

  onTap(String element) {
    switch (element) {
      case 'موظف معنا ':
        {
          break;
        }
      case ' شريك سوبر ماركت ':
        {
          break;
        }
      case 'سائق':
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext c) => DriverPrivileges()));
          break;
        }
      case 'تاجر':
        {
          break;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    appbarBloc.setTitle("اعمل معنا");
  }
}
