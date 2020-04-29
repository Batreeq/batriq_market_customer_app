import 'package:customerapp/models/UserBalanceModel.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';

class BalanceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BalanceScreen();
  }
}


class _BalanceScreen extends State {

  UserBalance userBalance ;
  @override
  void initState() {
    super.initState();
    userBalance = sharedData.userBalance ;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        //  to add border to the container  ,
        decoration: BoxDecoration(
          border: Border.all(
            color: sharedData.grayColor12,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: size.width - 30,
        height: size.height - 250,

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
                          height: 20,
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
                              sharedData.userBalance.activeBalance + 'JD',
                              style: sharedData.textInProfileTextStyle,
                            ),
                          ),
                          // the size box to make each row far from the above
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              sharedData.userBalance.inactiveBalance + 'JD',
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
                              sharedData.userBalance.totalBalance + 'JD',
                              style: sharedData.textInProfileTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 50,
                    height: 50,
                    child: RaisedButton(
                      color: sharedData.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {},
                      child: Text(sharedData.rechargeBalanceTextField,
                        style: sharedData.textInProfileTextStyle,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 50,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: sharedData.grayColor12
                        )
                      ),
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        onPressed: () {},
                        child: Text(sharedData.accountStatementTextField,
                          style: sharedData.textInProfileTextStyle,),
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
          shape: GFAvatarShape.standard,
        ),
      ),
    );
  }
}
