import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverTimes extends StatefulWidget{
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

  // those flags to check if the user click the day button to color it with yellow or no color
  bool isSat = false,
      isSun = false,
      isMon = false,
      isTues = false,
      isWend = false,
      isTheres = false,
      isFri = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedData.appBar(context, 'الأوقات', null, () {}),
      body: getBody(),
    );
  }

  getBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('الأوقات ', style: sharedData.optionStyle,),
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
                      color: isSat ? sharedData.yellow : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
                      border: Border.all(color: sharedData.grayColor12)
                  ),
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
}