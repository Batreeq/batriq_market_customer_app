import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:customerapp/helpers/AppApi.dart';
import 'package:customerapp/models/DriverModel/DriverModel.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpDriver extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpDriver();
  }
}

class _SignUpDriver extends State {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameCon, lastNameCon, phoneCon, addressCon, modelCon,
      altPhoneCon, typeCon,passwordCon,rePasswordCon;

  FocusNode nameFocus, phoneFocus, addressFocus, lastNameFocus, modelFocus,
      typeFocus, altPhoneFocus,passFocus,rePassFocus;

  String name, phone, altPhone, address, model, type, lastName,password,rePassword;

  bool obsecurePassword=true;
  bool obsecureRePassword=true;
  bool loading=false;

  Country _selectedDialogCountry;

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
    nameCon = new TextEditingController();
    passwordCon = new TextEditingController();
    rePasswordCon = new TextEditingController();
    phoneCon = new TextEditingController();
    lastNameCon = new TextEditingController();
    addressCon = new TextEditingController();
    modelCon = new TextEditingController();
    altPhoneCon = new TextEditingController();
    typeCon = new TextEditingController();

    nameFocus = new FocusNode();
    passFocus = new FocusNode();
    rePassFocus = new FocusNode();
    phoneFocus = new FocusNode();
    addressFocus = new FocusNode();
    lastNameFocus = new FocusNode();
    modelFocus = new FocusNode();
    typeFocus = new FocusNode();
    altPhoneFocus = new FocusNode();


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
      appBar: sharedData.appBar(context, "تسجيل حساب لسائق ", null, () {}),
      body: ModalProgressHUD(
        inAsyncCall:loading ,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset('assets/images/batreeq.png')
              ),
              formFields(),
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
                const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: nameFocus,
                          onSaved: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else return null;

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
                      margin: const EdgeInsets.only(
                          left: 00.0, right: 10.0),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
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
                const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: lastNameCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: lastNameFocus,
                          onSaved: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(
                                context, altPhoneFocus, phoneFocus);
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.lastNameTextField,
                            hintStyle: TextStyle(color: Colors.grey),
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
                      padding:
                      EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: sharedData.nameIcon,
                    ),
                  ],
                ),
              ), // last name
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
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, phoneFocus, nameFocus);
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
                          controller: altPhoneCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: altPhoneFocus,
                          onSaved: (value) {
                            setState(() {
                              altPhone = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                              else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, altPhoneFocus,
                                addressFocus);
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.secondPhoneHintTextField,
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
                        )
                    ),
                  ],
                ),
              ),

              /*password*/
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
                          obscureText: obsecurePassword,
                          controller: passwordCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: passFocus,
                          onSaved: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else if(passwordCon.text.toString()!=rePasswordCon.text.toString()) return sharedData.passwordValidation;
                              else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, passFocus,
                                rePassFocus);
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
                        child: obsecurePassword?IconButton(icon: Icon(Icons.remove_red_eye),color: sharedData.yellow,
                        onPressed: (){setState(() {
                          obsecurePassword=!obsecurePassword;
                        });},):IconButton(icon: Icon(Icons.remove_red_eye),color: Colors.red,
                          onPressed: (){setState(() {
                            obsecurePassword=!obsecurePassword;
                          });},)
                    ),
                  ],
                ),
              ),

              /*rePassword*/
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
                          obscureText: obsecureRePassword,
                          controller: rePasswordCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: rePassFocus,
                          onSaved: (value) {
                            setState(() {
                              rePassword = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else if(passwordCon.text.toString()!=rePasswordCon.text.toString()) return sharedData.passwordValidation;
                            else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, rePassFocus,
                                addressFocus);
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.rePasswordTextField,
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
                        child:obsecureRePassword?IconButton(icon: Icon(Icons.remove_red_eye),color: sharedData.yellow,
                          onPressed: (){setState(() {
                            obsecureRePassword=!obsecureRePassword;
                          });},):IconButton(icon: Icon(Icons.remove_red_eye),color: Colors.red,
                          onPressed: (){setState(() {
                            obsecureRePassword=!obsecureRePassword;
                          });},)
                    ),
                  ],
                ),
              ),



              // alternative phone
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
                          controller: addressCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: addressFocus,
                          onSaved: (value) {
                            setState(() {
                              address = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, addressFocus,
                                modelFocus);
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.addressHintTextField,
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
                      child: sharedData.locationIcon,
                    ),
                  ],
                ),
              ), // address
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
                          controller: modelCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: modelFocus,
                          onSaved: (value) {
                            setState(() {
                              model = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else return null;

                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, modelFocus, typeFocus);
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.modelHintTextField,
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
                      child: sharedData.carIcon,

                    ),
                  ],
                ),
              ), // vehicle model
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
                          controller: typeCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: typeFocus,
                          onSaved: (value) {
                            setState(() {
                              type = value;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty) return sharedData.emptyValidation;
                            else return null;

                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.typeHintTextField,
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
                      child: sharedData.carIcon,

                    ),
                  ],
                ),
              ), // vehicle type
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,

                  child: RaisedButton(
                    color: sharedData.yellow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      _validateAndSubmit();
                    },
                    child: Text(
                      'تسجيل حساب', style: sharedData.appBarTextStyle,),
                  ),
                ),
              ),
              SizedBox(height: 12,)
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
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //this method to check in the inputs are valid, to save and submit to do the update  user info request
  Future<void> _validateAndSubmit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      print("$name + $phone + $address + $lastName + $altPhone + $model + $type");
      form.save();

      setState(() {
        loading=!loading;
      });
      var response =await createAccountDriver(initMap());
      setState(() {
        loading=!loading;
      });
      if(response.statusCode==200){
        DriverModel driverModel=response.object;
        sharedData.driverInfo=driverModel;
        sharedData.writeToStorageDriver(key: sharedData.driverTokenTxt,value: driverModel.driver_token);
        Navigator.of(context).pop();
      }

    } else
      sharedData.flutterToast(sharedData.emptyValidation);
  }

  Map<String,dynamic>  initMap(){
    Map<String, dynamic> data={
      "first_name":name,
      "last_name":lastName,
      "phone":getFullPhoneNumber(phoneCon,_selectedDialogCountry),
      "password":password,
      "second_phone":getFullPhoneNumber(altPhoneCon,_selectedDialogCountry),
      "location":address,
      "car":type,
      "car_model":model };
    return data;
  }
}