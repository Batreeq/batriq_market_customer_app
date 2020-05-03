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
  String dateText = ' : التاريخ' , tripNoText = ' : رقم الجولة' , tripTimeText  = ' : وقت الجولة', tripCounterText  = ' : عداد الجولة', tripCountryText  = ' : دولة الجولة', destanceText  = ' : المسافة المقطوعة' ;
  String dateData = ' dfd' , tripNoData = ' ' , tripTimeData  = ' ', tripCounterData = ' ' , tripCountryData  = ' ', destanceData   = '';

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: sharedData.appBar(context, 'عداد الجولات', null, (){}),
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
              Text(dateText , style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(dateData , style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripNoText , style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripNoData , style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripTimeText , style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripTimeData , style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripCounterText , style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripCounterData , style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(tripCountryText , style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(tripCountryData , style: sharedData.optionStyle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(destanceText , style: sharedData.size19Style,),
              SizedBox(width: 30,),
              Text(destanceData , style: sharedData.optionStyle,),
            ],
          ),
        ),
      ],
    );
  }
}