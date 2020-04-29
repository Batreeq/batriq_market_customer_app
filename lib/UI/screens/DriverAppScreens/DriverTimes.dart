import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverTimes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    /*  decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sharedData.yellow)
    ),*/

    return _DriverTimes();
  }
}

class _DriverTimes extends State {
  String sat = 'السبت',
      sun = 'الأحد',
      mon = 'الأثنين',
      tues = 'الثلاثاء',
      wend = 'الأربعاء',
      theres = 'الخميس',
      fri = 'الجمعة';

  bool checkBoxValue1 = false, checkBoxValue2 = false;
  bool checkBoxValue3 = false, checkBoxValue4 = false;
  bool checkBoxValue5 = false, checkBoxValue6 = false;
  bool checkBoxValue7 = false;

  // those flags to check if the user click the day button to color it with yellow or no color
  bool isSat = false,
      isSun = false,
      isMon = false,
      isTues = false,
      isWend = false,
      isTheres = false,
      isFri = false;

  String from10To12PM = 'من الساعة 10 - 12 ص';
  String from8To10Pm = 'من الساعة 8 - 10 ص';
  String from12To2AM = 'من الساعة 12 - 2 م';
  String from2To4AM = 'من الساعة 2 - 4 م';
  String from4To6AM = 'من الساعة  4 - 6 م';
  String from6To8AM = 'من الساعة  6 - 8 م';
  String from8To10AM = 'من الساعة 8 - 10 م';

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: sharedData.appBar(context, 'الأوقات', null, () {}),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('الأوقات ', style: sharedData.optionStyle,),
          ),*/
          getDaysUI(),
          getTimesUI(),
          getButtons()
        ],
      ),
    );
  }

  Widget getDaysUI() {
    return Column(
      children: <Widget>[
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isSat ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        sat,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isSat)
                    setState(() {
                      isSat = false;
                    });
                  else
                    setState(() {
                      isSat = true;
                    });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isSun ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        sun,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isSun)
                    setState(() {
                      isSun = false;
                    });
                  else
                    setState(() {
                      isSun = true;
                    });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isMon ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        mon,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isMon)
                    setState(() {
                      isMon = false;
                    });
                  else
                    setState(() {
                      isMon = true;
                    });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isTues ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        tues,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isTues)
                    setState(() {
                      isTues = false;
                    });
                  else
                    setState(() {
                      isTues = true;
                    });
                },
              ),
            ),
          ],
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isWend ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        wend,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isWend)
                    setState(() {
                      isWend = false;
                    });
                  else
                    setState(() {
                      isWend = true;
                    });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isTheres ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        theres,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isTheres)
                    setState(() {
                      isTheres = false;
                    });
                  else
                    setState(() {
                      isTheres = true;
                    });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: isFri ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        fri,
                        style: sharedData.optionStyle,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (isFri)
                    setState(() {
                      isFri = false;
                    });
                  else
                    setState(() {
                      isFri = true;
                    });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getTimesUI() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Checkbox(
                    value: checkBoxValue1,
                    onChanged: (bool newValue) {
                      print(checkBoxValue1.toString());
                      if (newValue)
                        setState(() {
                          checkBoxValue1 = true;
                        });
                      else
                        setState(() {
                          checkBoxValue1 = false;
                        });

                      print(checkBoxValue1.toString() +
                          ' ' +
                          newValue.toString());
                    }),
                Text(
                  from10To12PM,
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
                  from8To10Pm,
                  textAlign: TextAlign.right,
                  style: sharedData.optionStyle,
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Checkbox(
                    autofocus: true,
                    value: checkBoxValue3,
                    //   activeColor: Colors.green,
                    onChanged: (bool newValue) {
                      print(checkBoxValue3.toString());

                      setState(() {
                        checkBoxValue3 = newValue;
                      });
                      print(checkBoxValue3.toString());
                    }),
                Text(
                  from12To2AM,
                  textAlign: TextAlign.right,
                  style: sharedData.optionStyle,
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Checkbox(
                    value: checkBoxValue4,
                    //   activeColor: Colors.green,
                    onChanged: (bool newValue) {
                      print(checkBoxValue4.toString());
                      setState(() {
                        checkBoxValue4 = newValue;
                      });
                      print(checkBoxValue4.toString() + newValue.toString());
                    }),
                Text(
                  from2To4AM,
                  textAlign: TextAlign.right,
                  style: sharedData.optionStyle,
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Checkbox(
                    value: checkBoxValue5,
                    //   activeColor: Colors.green,
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxValue5 = newValue;
                      });
                      print(checkBoxValue5.toString() + newValue.toString());
                    }),
                Text(
                  from4To6AM,
                  textAlign: TextAlign.right,
                  style: sharedData.optionStyle,
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Checkbox(
                    value: checkBoxValue6,
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxValue6 = newValue;
                      });
                    }),
                Text(
                  from6To8AM,
                  textAlign: TextAlign.right,
                  style: sharedData.optionStyle,
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Checkbox(
                    value: checkBoxValue7,
                    //   activeColor: Colors.green,
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxValue7 = newValue;
                      });
                      print(checkBoxValue3.toString() + newValue.toString());
                    }),
                Text(
                  from8To10AM,
                  textAlign: TextAlign.right,
                  style: sharedData.optionStyle,
                ),
              ],
            ),
          ],
        ));
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
                        Image.asset('assets/images/icons/forward.png'),
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
                            Image.asset('assets/images/icons/reword.png'),
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
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                'حفظ',
                style: sharedData.textInProfileTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: sharedData.yellow,
            ),
          ),
        ),
      ],
    );
  }
}
