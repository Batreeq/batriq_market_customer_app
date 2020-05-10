import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class EarnWithUsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EarnWithUsScreen();
  }
}

class _EarnWithUsScreen extends State {
  bool checkBoxValue1 = false, checkBoxValue2 = false;
  BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: sharedData.appBar(context, 'اكسب معنا', null, () {}),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height - 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xffA22447).withOpacity(.05),
                offset: Offset(0, 0),
                blurRadius: 20,
                spreadRadius: 3)
          ],
          border: Border.all(color: sharedData.grayColor12),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'نقاطك',
                style: sharedData.tableFieldsTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'لديك نقاط مكافأة',
                style: sharedData.tableFieldsTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 80,
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(color: sharedData.yellow),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Center(
                                child: Image.asset("assets/images/reward.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                sharedData.userInfo.points != null
                                    ? sharedData.userInfo.points
                                    : ' 0 ' + 'نقطة ',
                                style: sharedData.navBarTextStyle,
                              ),
                            ),
                          ],
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22.0, right: 12, left: 12),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text(
                    'أستبدل نقاطك',
                    style: sharedData.textInProfileTextStyle,
                  ),
                  onPressed: () {
                    replacementDialogUI();
                    // Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: sharedData.yellow,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> replacementDialogUI() {
    String title = 'استبدل نقاطك ب';
    return showDialog<void>(
        context: context,
        builder: (BuildContext c) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              //elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              //   backgroundColor: Colors.red,
              child: SingleChildScrollView(
                  child: Container(
                      // height: size.height -20 ,
                      //   width: size.width,
                      child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              title,
                              textAlign: TextAlign.right,
                              style: sharedData.textInProfileTextStyle,
                            ),
                          ),
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Checkbox(
                                autofocus: true,
                                value: checkBoxValue1,
                                //   activeColor: Colors.green,
                                onChanged: (bool newValue) {
                                  print(checkBoxValue1.toString());
                                  if (newValue)
                                    setState(() {
                                      checkBoxValue1 = true;
                                    });
                                  else
                                    checkBoxValue1 = false;
                                  print(checkBoxValue1.toString() +
                                      " " +
                                      checkBoxValue2.toString() +
                                      ' ' +
                                      newValue.toString());
                                }),
                            Text(
                              'رصيد نقود',
                              textAlign: TextAlign.right,
                              style: sharedData.optionStyle,
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Checkbox(
                                value: checkBoxValue2,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkBoxValue2 = newValue;
                                  });
                                }),
                            Text(
                              'جوائز أخرى',
                              textAlign: TextAlign.right,
                              style: sharedData.optionStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text(
                                'استبدال',
                                style: sharedData.textInProfileTextStyle,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: sharedData.yellow,
                            ),
                          ),
                        )
                      ],
                    )),
              ))),
            );
          });
        });
  }
}
