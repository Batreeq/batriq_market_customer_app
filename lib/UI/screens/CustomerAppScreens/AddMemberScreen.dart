import 'package:customerapp/models/UserInfo.dart';
import 'package:customerapp/models/addFamilyMember.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/shared_data.dart';
import 'package:requests/requests.dart';

class AddMemberScreen extends StatefulWidget {
  String salary;

  AddMemberScreen(this.salary);

  @override
  State<StatefulWidget> createState() {
    return _AddMemberScreen(salary);
  }
}

class _AddMemberScreen extends State {

  FamilyMembers familyMembers ;

  TextEditingController memberNameCon, memberAgeCon;

  String salary;

  FocusNode memberNameNode, memberAgeNode;

  String name, age, gender;

  FamilyMembers addFamilyMember;

  final formKey = GlobalKey<FormState>();

  String token = '';

  _AddMemberScreen(this.salary);

  @override
  void initState() {
    super.initState();
    addFamilyMember = new FamilyMembers();
    readToken();

    memberNameCon = new TextEditingController(text: '');
    memberAgeCon = new TextEditingController(text: '');
    memberAgeNode = new FocusNode();
    memberNameNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: sharedData
          .appBar(context, 'اضافة فرد', null /*Icon(Icons.arrow_forward)*/, () {
        /*Navigator.pop(context);*/
      }),
      body: addMember(),
    );
  }

  void getUserDataFromAPI() async {
    //  token = '03ec18b8f8c4252e2794aa316dba652147f4b559871e8061bf6d420a9e9d4807';
    if (token != '' && token != null) {
      addFamilyMember.gender = _result;
      addFamilyMember.token = token;
      addFamilyMember.name = memberNameCon.text;
      addFamilyMember.age = memberAgeCon.text;
      if (salary != null)
        addFamilyMember.salary = salary;
      else
        addFamilyMember.salary = '';
      final response = await Requests.post(
        sharedData.addMemberUrl,
        body: addFamilyMember.toJson()
        //  bodyEncoding: RequestBodyEncoding.FormURLEncoded
      );

      sharedData.showLoadingDialog(context); //invoking login
      await Future.delayed(Duration(seconds: 2));
      print(token);
      if (response != null) {
        print(response.json().toString());
        print(response.statusCode);
      } else
        print('response = null ');

      if (response.statusCode == 200) {
        setState(() {
            sharedData.familyMembers.add(addFamilyMember);
        });

        sharedData.flutterToast('Added Successfully');
        Navigator.of(context).pop();
      }
      Navigator.of(context).pop(); //close the dialog

    } else {
      sharedData.flutterToast(' You are not Registered');
      print('not added  $token');
    }
  }

  // state variable
  String _result = 'ذكر'; // this is the default gender value
  int _radioValue = 0; // this value mean the value which user selected

  //this method will call when the user change the radio button
  void _handleRadioValueChange(int value) {
    setState(() {
      memberNameCon.text = name ;
      memberAgeCon.text = age ;
      _radioValue = value;
      switch (value) {
        case 0:
          _result = 'ذكر';
          break;
        case 1:
          _result = 'أنثى';
          break;
      }
    });
    print(_result);
  }

  Widget addMember() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: memberNameCon,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: memberNameNode,
//                      onChanged: (val){
//                        setState(() {
//                          name = val ;
//                        });
//                        },
                      onSaved: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value == '')
                          return 'Please Fill The Name';
                        return null;
                      },
                      onEditingComplete: (){setState(() {
                        name = memberNameCon.text;
                      });},
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, memberNameNode, memberAgeNode);
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: sharedData.nameHintTextField,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: sharedData.nameIcon,
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
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: memberAgeCon,
                      onEditingComplete: (){age = memberAgeCon.text ;},
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: memberAgeNode,
                      onSaved: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value == '')
                          return 'Please Fill The Age';
                        return null;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: sharedData.ageHintTextField,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: sharedData.nameIcon,
                ),
              ],
            ),
          ), // age
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  ': الجنس',
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 25,
                ),
                new Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                new Text(
                  'ذكر',
                  style: new TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  width: 17,
                ),
                new Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                new Text(
                  'انثى',
                  style: new TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 15, left: 15),
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                color: sharedData.yellow,
                onPressed: () {
                  _validateAndSubmit();
                },
                child: Text(
                  'اضافة',
                  style: sharedData.textInProfileTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // read tokn value from shared data class and save it in the local vairable
  void readToken() async {
    token = await  sharedData.readFromStorage( key : 'token');
  }

  // change the pointer focus to the next filed after
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //this method to check in the inputs are valid, to save and submit to do the update  user info request
  void _validateAndSubmit() {
    final form = formKey.currentState;
    if (form.validate()) {
      //form.save();
      print(memberNameCon.text + " " + memberAgeCon.text + ' ' + _result);
      getUserDataFromAPI();
    } else
      sharedData.flutterToast('Invalid Input');
    // submitUserData('');
  }
}
