import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgreedTrips extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AgreedTrips();
  }
}

class _AgreedTrips extends State {
  String orderNoText = ' : رقم الطلبية',
      expectedTimeText = ' :  الوقت المتوقع',
      startTimeText = ' : وقت البداية',
      startingPointText = ' : نقطة الانطلاق',
      cancelText = ' : الغاء اضطراري ';

  String orderNoData = ' ',
      expectedTimeData = '',
      startTimeData = '',
      startingPointData = '',
      cancelData = '  ';

  bool isChecked = false ;
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

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(orderNoText, style: sharedData.size19Style,),
                  SizedBox(width: 30,),
                  Text(orderNoData, style: sharedData.optionStyle,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(expectedTimeText, style: sharedData.size19Style,),
                  SizedBox(width: 30,),
                  Text(expectedTimeData, style: sharedData.optionStyle,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(startTimeText, style: sharedData.size19Style,),
                  SizedBox(width: 30,),
                  Text(startTimeData, style: sharedData.optionStyle,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(startingPointText, style: sharedData.size19Style,),
                  SizedBox(width: 30,),
                  Text(startingPointData, style: sharedData.optionStyle,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(cancelText, style: sharedData.size19Style,),
                  SizedBox(width: 15,),
                  Checkbox(
                    onChanged: (val) {
                      setState(() {
                        isChecked = val ;
                      });
                    },
                    value: isChecked,
                  )
                ],
              ),
            ),
            getOptions(),
            SizedBox(height: 30,),

            getButtons()
          ],
        ),
      ),
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
      ],
    );
  }

  Widget getOptions(){
    // this list for the home buttons
    List<String> users = new List<String>();
    users.add('جهز للموظف');
    users.add('تم الوصول');
    users.add('انجزت الجولة');
    users.add('بدء الجولة');

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

      ],
    );
  }


  onTap(int element) {
    switch (element) {
      case 0 :
        {
          break;
        }
      case 1 :
        {
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
          break;
        }
    }
  }
}