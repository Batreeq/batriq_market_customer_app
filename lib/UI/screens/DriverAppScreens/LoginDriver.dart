import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:customerapp/UI/screens/DriverAppScreens/DriverOptionsScreen.dart';
import 'package:customerapp/helpers/AppApi.dart';
import 'package:customerapp/models/DriverModel/DriverModel.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'SignupDriver.dart';

class LoginDriver extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginDriver();
  }
}

class _LoginDriver extends State {
  final formKey = GlobalKey<FormState>();
  FocusNode passwordFocus, phoneFocus;
  TextEditingController passwordCon, phoneCon;
  String password = '', phone = '';


  Country _selectedDialogCountry;

  bool obsucre=true;
  bool loading=false;

  void _openCountryPickerDialog() => showDialog(
      context: context,
      builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
          child: CountryPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: Colors.black,
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Select your country code',),
              onValuePicked: (Country country) {
                setState(() => _selectedDialogCountry = country);
                print(country.name);
              },
              itemBuilder: (Country country) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      CountryPickerUtils.getDefaultFlagImage(country),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text("+${country.phoneCode}(${country.isoCode})"),
                    ],
                  ),
                );
              })));

  @override
  void initState() {
    super.initState();
    passwordCon = new TextEditingController();
    phoneCon = new TextEditingController(text: phone);
    passwordFocus = new FocusNode();
    phoneFocus = new FocusNode();

    _selectedDialogCountry = new Country(
      phoneCode: CountryPickerUtils
          .getCountryByPhoneCode('962')
          .phoneCode,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: sharedData.appBar(context, "تسجيل دخول", null, null),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text(
                    sharedData.welcomeTextInLoginDriver,
                    style: sharedData.optionStyle,
                  )),
              SizedBox(
                height: 50,
              ),
              formFields(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      sharedData.dontHaveAccount,
                      style: sharedData.optionStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        focusColor: sharedData.yellow,
                        child: Text(
                          sharedData.createAccount,
                          style: sharedData.yellowStyle,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext c) => SignUpDriver()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(
                    sharedData.loginUsingText,
                    style: sharedData.optionStyle,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Image.asset('assets/images/facebook.png'),
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Image.asset('assets/images/googleplus.png'),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  // Form will fields (phone number, name, location and email ) to fill them by user
  Widget formFields() {
    return Form(
      key: formKey,
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
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phoneCon,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: phoneFocus,
                      onSaved: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      validator: (String value) {
                        if (value.isEmpty)  {
                          return sharedData.emptyValidation;
                        }else return null;

                      },
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, phoneFocus, passwordFocus);
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: sharedData.phoneHintTextField,
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
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      //  _openCountryPickerDialog();
                    },
                    child: Container(

                      child: Row(
                        children: <Widget>[
                          Text(
                            "+${_selectedDialogCountry.phoneCode}",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          CountryPickerUtils.getDefaultFlagImage(
                              CountryPickerUtils
                                  .getCountryByPhoneCode(
                                  _selectedDialogCountry
                                      .phoneCode)),
                          SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ), // phone
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
                      obscureText: obsucre,
                      controller: passwordCon,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      focusNode: passwordFocus,
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (String val) {
                        if (val.isEmpty)  {
                          return sharedData.emptyValidation;
                        }else return null;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: sharedData.passwordTextField,
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
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  child:  obsucre?IconButton(icon: Icon(Icons.remove_red_eye),color: sharedData.yellow,
                    onPressed: (){setState(() {
                      obsucre=!obsucre;
                    });},):IconButton(icon: Icon(Icons.remove_red_eye),color: Colors.red,
                    onPressed: (){setState(() {
                      obsucre=!obsucre;
                    });},),
                ),
              ],
            ),
          ), // password
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                color: sharedData.yellow,
                onPressed: () {
                    _validateAndSubmit();
                  print(phone + '  ' + password);
                 /* Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext c) => DriverOptionsScreen()));*/
                },
                child: Text(
                  'تسجيل دخول',
                  style: sharedData.appBarTextStyle,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  // to check if the phone valid like Jordan phone pattern (10 characters start with 079, 078 or 077)
  bool isValidPhone() {
    phoneCon.text.trim();
    RegExp regExp = new RegExp('((079)|(078)|(077)){1}[0-9]{7}');
    if (phoneCon.text.length == 0) {
      return false;
    } else if (!regExp.hasMatch(phoneCon.text)) {
      return false;
    }
    return true;
  }

  // change the pointer focus to the next filed after
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //this method to check in the inputs are valid, to save and submit to do the update  user info request
  Future<void> _validateAndSubmit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        loading=!loading;
      });

      var response=await loginDriver(initMap());

      if(response.statusCode==200){
        DriverModel driverModel=response.object;
        await sharedData.writeToStorageDriver(key: sharedData.driverTokenTxt,value: driverModel.driver_token);
        sharedData.driverInfo=driverModel;
         Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext c) => DriverOptionsScreen()));
      }



      setState(() {
        loading=!loading;
      });
    } else
      sharedData.flutterToast(sharedData.emptyValidation);
  }

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "phone":getFullPhoneNumber(phoneCon, _selectedDialogCountry),
      "password":passwordCon.text.toString().trim()
    };

    return data;
  }
}
