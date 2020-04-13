import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomPadding: true ,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top :30.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GFAvatar(
                    size: 70,
                    backgroundImage: NetworkImage(
                      sharedData.profileImage,
                    ),
                  ),
                ), // profile picture
                Text(
                  sharedData.name,
                  style: sharedData.textInProfileTextStyle,
                ), // name
                Container(
                  child: Column(
                    children: <Widget>[
                      Form(
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
//                                    controller: _firstnameController,
//                                    focusNode: _firstnameFocus,
                                            validator: (value) {
//                                      if (value.isEmpty)
//                                        return "Please Enter Your Name";
//                                      else if (!isValidFirstName())
//                                        return "Please Enter Your Full Name.";
//                                      return null;
                                            },
                                            onSaved: (value) {
//                                      setState(() {
//                                        FamilyName = value;
//                                      });
                                            },
                                            onFieldSubmitted: (term) {
//                                      _fieldFocusChange(
//                                          context, _firstnameFocus,
//                                          _firstnameFocus);
                                            },
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: sharedData.phoneHintTextField,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30.0,
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5),
                                        margin: const EdgeInsets.only(
                                            left: 00.0, right: 10.0),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        child: sharedData.phoneIcon,
                                      ),
                                    ],
                                  ),
                                ), // name
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
//                                    controller: _firstnameController,
//                                    focusNode: _firstnameFocus,
                                            validator: (value) {
//                                      if (value.isEmpty)
//                                        return "Please Enter Your Name";
//                                      else if (!isValidFirstName())
//                                        return "Please Enter Your Full Name.";
//                                      return null;
                                            },
                                            onSaved: (value) {
//                                      setState(() {
//                                        FamilyName = value;
//                                      });
                                            },
                                            onFieldSubmitted: (term) {
//                                      _fieldFocusChange(
//                                          context, _firstnameFocus,
//                                          _firstnameFocus);
                                            },
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: sharedData
                                                  .locationHintTextField,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30.0,
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5),
                                        margin: const EdgeInsets.only(
                                            left: 00.0, right: 10.0),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        child: sharedData.locationIcon,
                                      ),
                                    ],
                                  ),
                                ), // name
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
//                                    controller: _firstnameController,
//                                    focusNode: _firstnameFocus,
                                            validator: (value) {
//                                      if (value.isEmpty)
//                                        return "Please Enter Your Name";
//                                      else if (!isValidFirstName())
//                                        return "Please Enter Your Full Name.";
//                                      return null;
                                            },
                                            onSaved: (value) {
//                                      setState(() {
//                                        FamilyName = value;
//                                      });
                                            },
                                            onFieldSubmitted: (term) {
//                                      _fieldFocusChange(
//                                          context, _firstnameFocus,
//                                          _firstnameFocus);
                                            },
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: sharedData.emailHintTextField,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30.0,
                                        width: 1.0,
                                        color: Colors.grey.withOpacity(0.5),
                                        margin: const EdgeInsets.only(
                                            left: 00.0, right: 10.0),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        child: sharedData.emailIcon,
                                      ),
                                    ],
                                  ),
                                ), // email
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width-50,
                          height: 50,
                          child: RaisedButton(
                            color: sharedData.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {},
                            child: Text(sharedData.updateProfileTextField , style: sharedData.textInProfileTextStyle,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),// name, location, location fields and  button update
               SizedBox(height: 20,),
                Text(
                  sharedData.textInProfileTextField,
                  style: TextStyle(fontSize: 18),
                ), // name
              ],
            ),
          ),
        ),
      ),
    );
  }
}