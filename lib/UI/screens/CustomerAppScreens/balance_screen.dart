import 'package:customerapp/helpers/AppApi.dart';
import 'package:customerapp/models/UserBalance.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'BalanceDetails.dart';

class BalanceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BalanceScreen();
  }
}

class _BalanceScreen extends State<BalanceScreen> {

  bool checkBoxValue1 = false,
      checkBoxValue2 = false;
  bool checkBoxValue3 = false,
      checkBoxValue4 = false;
  BuildContext context;

  Size size;
  UserBalance userBalance;


  var _formTransferMoney = GlobalKey<FormState>();
  TextEditingController toUserController=TextEditingController();
  TextEditingController ammountController=TextEditingController();

  bool isLoading=false;
  Future showTransferMoneyDialog() async {

    bool isLodaing=false;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.only(top: 10.0, left: 16, right: 16),
            content:isLodaing?Center(): Form(
              key: _formTransferMoney,
              child: SingleChildScrollView(
                child: Container(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /*Titile*/
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              sharedData.transferMoney,
                              style: sharedData.optionStyle
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14.0,
                      ),

                      /*one*/
                      TextFormField(
                        controller: toUserController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            errorMaxLines: 2,

                            labelText: sharedData.transferMoneyToUser, labelStyle: TextStyle(fontSize: 14)),
                        validator: (String value) {
                          if (toUserController.text.isEmpty) {
                            return  sharedData.enterNumberUser;
                          }
                          else return null;
                        },


                      ),

                      /*tow*/
                      TextFormField(
                        controller: ammountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: sharedData.transferMoneyAmmount, labelStyle: TextStyle(fontSize: 14)),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return sharedData.enterAmount;
                          }
                          else return null;
                        },


                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          /*Confirm*/
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                            child: new MaterialButton(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                splashColor: sharedData.mainColor,
                                color: Colors.black,
                                textColor: Colors.white,
                                child: new Text(
                                  sharedData.Continue,
                                  style: TextStyle(
                                    fontFamily: 'Heading',
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (sharedData.validationForm(_formTransferMoney)) {

                                    Navigator.of(context).pop({"info":true});

                                  }
                                }),
                          ),

                          /*Cancel*/
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                            child: new MaterialButton(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                splashColor: sharedData.mainColor,
                                color: Colors.black,
                                textColor: Colors.white,
                                child: new Text(
                                  sharedData.cancel,
                                  style: TextStyle(
                                    fontFamily: 'Heading',
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }



  @override
  void initState() {
    super.initState();
    userBalance = new UserBalance();

    sharedData.readFromStorage(key: 'token').then((val) {
      //  getUserBalance(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;

    userBalance = sharedData.userBalance;
    if (userBalance == null || userBalance.totalBalance == null ||
        userBalance.activeBalance == null) {
      userBalance = new UserBalance();
      setState(() {
        userBalance.activeBalance = ' 0';
        userBalance.inactiveBalance = ' 0';
        userBalance.totalBalance = ' 0';
      });
    }
    this.context = context;

    return Scaffold(
      appBar: sharedData.appBar(context, 'الرصيد', null, () {}),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //  to add border to the container  ,
              decoration: BoxDecoration(
                border: Border.all(
                  color: sharedData.grayColor12,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: size.width - 12,
              height: size.height - 150,

              child: GFAvatar(
                backgroundColor: Colors.white30,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  sharedData.activeBalanceTextField,
                                  style: sharedData.textInProfileTextStyle,
                                ),
                              ),
                              // the size box to make each row far from the above
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  sharedData.notActiveBalanceTextField,
                                  style: sharedData.textInProfileTextStyle,
                                ),
                              ),
                              // the size box to make each row far from the above
                              SizedBox(
                                height: 20,
                              ), // the size box to make each row far from the above
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  sharedData.totalBalanceTextField,
                                  style: sharedData.textInProfileTextStyle,
                                ),
                              ),
                              // empty space between 2 fields
                              // active balance data space
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userBalance.activeBalance + 'JD',
                                    style: sharedData.textInProfileTextStyle,
                                  ),
                                ),
                                // the size box to make each row far from the above
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userBalance.inactiveBalance + 'JD',
                                    style: sharedData.textInProfileTextStyle,
                                  ),
                                ),
                                // the size box to make each row far from the above
                                SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userBalance.totalBalance + 'JD',
                                    style: sharedData.textInProfileTextStyle,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 50,
                          child: RaisedButton(
                            color: sharedData.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {
                              replacementDialogUI();
                            },
                            child: Text(
                              sharedData.rechargeBalanceTextField,
                              style: sharedData.textInProfileTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: sharedData.grayColor12)),
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                onPressed: () {
                                  sharedData.listOfUserPayment != null &&
                                      sharedData.listOfUserPayment.length > 0
                                      ? Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext c) =>
                                          BalanceDetails()))
                                      : sharedData
                                      .flutterToast("لاتوجد لديك تحويلات سابقة");
                                },
                                child: Text(
                                  sharedData.accountStatementTextField,
                                  style: sharedData.textInProfileTextStyle,
                                ),
                              ),
                            )),
                      ),
                      isRegistered()?Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: sharedData.grayColor12)),
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                onPressed: () async {
                                  Map result = await  showTransferMoneyDialog();
                                  if(result!=null && result.containsKey('info')){


                                    setState(() {
                                      isLoading=true;
                                    });

                                    var response=await transferMoney(ammountController.text.toString(),
                                        toUserController.text.toString(),token);
                                    setState(() {
                                      isLoading=false;
                                    });


                                    sharedData.flutterToast(response.object.toString());

                                  }

                                },
                                child: Text(
                                  sharedData.transferMoney,
                                  style: sharedData.textInProfileTextStyle,
                                ),
                              ),
                            )),
                      ):Container()
                    ],
                  ),
                ),
                shape: GFAvatarShape.standard,
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> replacementDialogUI() {
    String title = 'اشحن رصيد من خلال';
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
                              'شحن من خلال فواتير في المستقبل',
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
                              'شحن من خلال الفيزا',
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
                                  if (newValue)
                                    setState(() {
                                      checkBoxValue3 = true;
                                    });
                                  else
                                    checkBoxValue3 = false;
                                  print(checkBoxValue3.toString() +
                                      " " +
                                      checkBoxValue4.toString() +
                                      ' ' +
                                      newValue.toString());
                                }),
                            Text(
                              'اشحن من ماستر كارد',
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
                                'تأكيد',
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