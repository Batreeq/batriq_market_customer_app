import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripsCounter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TripsCounter();
  }
}

class _TripsCounter extends State {
  String dateText = ' : التاريخ',
      tripNoText = ' : رقم الجولة',
      tripTimeText = ' : وقت الجولة',
      tripCounterText = ' : عداد الجولة',
      tripCountryText = ' : دولة الجولة',
      distanceText = ' : المسافة المقطوعة';

  String dateData = '  ',
      tripNoData = ' ',
      tripTimeData = ' ',
      tripCounterData = ' ',
      tripCountryData = ' ',
      distanceData = '';
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return
      Scaffold(
        appBar: sharedData.appBar(context, 'عداد الجولات', null, () {}),
        body: getBody(),
      );
  }

  getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: <Widget>[
        SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(dateText, style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(dateData, style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripNoText, style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripNoData, style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripTimeText, style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripTimeData, style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripCounterText, style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripCounterData, style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripCountryText, style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripCountryData, style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(distanceText, style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(distanceData, style: sharedData.optionStyle,),
            ],
          ),
        ),
        SizedBox(height: 100,),
        getButtons()
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
                      Image.asset('assets/images/icons/forward.png'),
                      Text('السابق')
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width - 200,),
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