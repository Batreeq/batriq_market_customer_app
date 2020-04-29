import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpDriver extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpDriver();
  }
}

class _SignUpDriver extends State {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameCon, lastNameCon, phoneCon, addressCon, modelCon,
      altPhoneCon, typeCon;

  FocusNode nameFocus, phoneFocus, addressFocus, lastNameFocus, modelFocus,
      typeFocus, altPhoneFocus;

  String name, phone, altPhone, address, model, type, lastName;

  @override
  void initState() {
    super.initState();
    nameCon = new TextEditingController(text: name);
    phoneCon = new TextEditingController(text: phone);
    lastNameCon = new TextEditingController(text: phone);
    addressCon = new TextEditingController(text: phone);
    modelCon = new TextEditingController(text: phone);
    altPhoneCon = new TextEditingController(text: phone);
    typeCon = new TextEditingController(text: phone);

    nameFocus = new FocusNode();
    phoneFocus = new FocusNode();
    addressFocus = new FocusNode();
    lastNameFocus = new FocusNode();
    modelFocus = new FocusNode();
    typeFocus = new FocusNode();
    altPhoneFocus = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: sharedData.appBar(context, "تسجيل حساب لسائق ", null, () {}),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Image.asset('assets/images/batreeq.png')
          ),
          formFields(),
        ],
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
                          validator: (value) {
                            return null;
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
                          validator: (value) {
                            if (value.isNotEmpty) if (!isValidPhone()) {
                              return 'Invalid Phone Format';
                            }
                            return null;
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
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      child: sharedData.phoneIcon,
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
                          validator: (value) {
                            if (value.isNotEmpty) if (!isValidPhone()) {
                              return 'Invalid Phone Format';
                            }
                            return null;
                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, altPhoneFocus,
                                addressFocus);
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
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      child: sharedData.phoneIcon,
                    ),
                  ],
                ),
              ), // alternative phone
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
                          validator: (value) {
                            return null;
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
                          validator: (value) {
                            return null;
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
                          validator: (value) {
                            return null;
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

                    ),
                  ],
                ),
              ), // vehicle type
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    color: sharedData.yellow,
                    onPressed: () {
                      _validateAndSubmit();
                    },
                    child: Text(
                      'تسجيل حساب', style: sharedData.appBarTextStyle,),
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
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //this method to check in the inputs are valid, to save and submit to do the update  user info request
  void _validateAndSubmit() {
    final form = formKey.currentState;
    if (form.validate()) {
      print(name + phone + address + lastName + altPhone + model + type);
      form.save();
    } else
      sharedData.flutterToast('Invalid Input');
  }
}