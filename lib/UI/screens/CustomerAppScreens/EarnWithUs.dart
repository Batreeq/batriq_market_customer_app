import 'package:customerapp/UI/screens/CustomerAppScreens/ReplacePointsUI.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/profile_screen.dart';
import 'package:customerapp/models/IncreasePointsListClass.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:requests/requests.dart';

class EarnWithUsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EarnWithUsScreen();
  }

}
class _EarnWithUsScreen extends State {

  bool checkBoxValue1 = false,
      checkBoxValue2 = false;
  IncreasePointsListClass increasePointsList = sharedData.increasePointsList;
  String profileButton = '';
  String sharedAppButton = 'شارك التطبيق';
  String profilePoints = '200';
  String sharedAppPoints = '50';
  BuildContext context;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    profileButton = increasePointsList.increasePoints
        .elementAt(0)
        .type;
    sharedAppButton = increasePointsList.increasePoints
        .elementAt(1)
        .type;
    profilePoints = increasePointsList.increasePoints
        .elementAt(0)
        .points;
    sharedAppPoints = increasePointsList.increasePoints
        .elementAt(1)
        .points;
    this.context = context;
    return Scaffold(
      appBar: sharedData.appBar(context, 'اكسب معنا', null, () {}),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 50,
        height: MediaQuery
            .of(context)
            .size
            .height - 250,

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xffA22447).withOpacity(.05),
                offset: Offset(0, 0),
                blurRadius: 20,
                spreadRadius: 3
            )
          ],
          border: Border.all(color: sharedData.grayColor12),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('نقاطك', style: sharedData.tableFieldsTextStyle,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'لديك نقاط مكافأة', style: sharedData.tableFieldsTextStyle,),
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
                                    child: Image.asset(
                                        "assets/images/reward.png"),
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
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 22.0, right: 12, left: 12),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('أستبدل نقاطك',
                    style: sharedData.textInProfileTextStyle,),
                  onPressed: () {
                    if (sharedData.userInfo.points == null ||
                        sharedData.userInfo.points == '')
                      sharedData.flutterToast('Sorry, You don\'t have points');
                    // else
                    // replacementDialogUI();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext c) => ReplacePoints()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: sharedData.yellow,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 22.0, right: 12, left: 12),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('اكسب نقاطك',
                    style: sharedData.textInProfileTextStyle,),
                  onPressed: () {
                    replacementDialogUI();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: sharedData.yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> replacementDialogUI() {
    String title = 'اكسب نقاطك ب';
    return showDialog<void>(
        context: context,
        builder: (BuildContext c) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  // height: size.height -20 ,
                  //   width: size.width,
                    child: SingleChildScrollView(
                        child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            title,
                                            textAlign: TextAlign.right,
                                            style: sharedData
                                                .textInProfileTextStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: RaisedButton(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  profileButton,
                                                  style: sharedData
                                                      .size16Style,
                                                ),
                                                Text('  ' + profilePoints +
                                                    ' نقطة',
                                                  style: sharedData
                                                      .pointsStyle,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (
                                                      BuildContext c) =>
                                                      ProfileScreen()));
                                            },
                                            color: sharedData.yellow,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: RaisedButton(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  sharedAppButton,
                                                  style: sharedData
                                                      .size16Style,
                                                ),
                                                Text('  ' + sharedAppPoints +
                                                    ' نقطة',
                                                  style: sharedData
                                                      .pointsStyle,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              sharedApp();
                                            },
                                            color: sharedData.yellow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ]
                        )
                    )
                )
            );
          });
        });
  }

  sharedApp() async {
    await FlutterShare.share(
        title: 'Share link app',
        text:
        'You have a document shipped to you. Click on link to download TrussT Community app and start tracking your document',
        linkUrl:
        'bmt.lh/2IzBaG0',
        chooserTitle:
        'Share the link of Trust app');
  }
}