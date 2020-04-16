import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State {
  Future<File> file;
  String base64Image = '';
  File tempFile;
  final formKey = GlobalKey<FormState>();

  Widget defaultImageWidget;
  String name, phone, location, email;
  TextEditingController nameCon, phoneCon, locationCon, emailCon;
  FocusNode nameFocus, phoneFocus, locationFocus, emailFocus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameCon = new TextEditingController();
    phoneCon = new TextEditingController();
    locationCon = new TextEditingController();
    emailCon = new TextEditingController();
    nameFocus = new FocusNode();
    phoneFocus = new FocusNode();
    locationFocus = new FocusNode();
    emailFocus = new FocusNode();

    // check if the user registered before if token is null so default image will put , else , will put the user image
    if (sharedData.token == null || sharedData.token == '') {
      // user not registered
      defaultImageWidget = GFAvatar(
        size: 70,
        backgroundImage: NetworkImage(
          sharedData.profileImage,
        ),
      );
    } else {
      // token not null so user registered before so his info will get from api and put them in the fields
      defaultImageWidget = GFAvatar(
        size: 70,
        backgroundImage: NetworkImage(
          sharedData.profileImage,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.add),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                          onTap: () {
                            chooseImageFromGallery();
                          },
                          child: defaultImageWidget),
                    ),
                  ],
                ), // profile picture
                Text(
                  sharedData.name,
                  style: sharedData.textInProfileTextStyle,
                ), // name
                Container(
                  child: Column(
                    children: <Widget>[
                      formFields(),
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
                            onPressed: () {
                              _validateAndSubmit();
                            },
                            child: Text(
                              sharedData.updateProfileTextField,
                              style: sharedData.textInProfileTextStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ), // name, location, location fields and  button update
                SizedBox(
                  height: 20,
                ),
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
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, nameFocus,
                                locationFocus);
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
                          controller: locationCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, locationFocus,
                                emailFocus);
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: sharedData.locationHintTextField,
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
              ), // location
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
                          controller: emailCon,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: emailFocus,
                          validator: (value) {
                            if (!(isValidEmail()))
                              return "Please Enter Valid Email.";
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              email = value;
                            });
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
                      child: sharedData.emailIcon,
                    ),
                  ],
                ),
              ), // email
            ],
          )),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  uploadImage() {}

  chooseImageFromGallery() {
    setState(() {
      // open gallery to pick image
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    defaultImageWidget = FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          tempFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());

          return GFAvatar(
            child: Image.file(snapshot.data),
          );
        } else if (snapshot.hasError) {
          sharedData.flutterToast('Error In Uploading Image ');
          return GFAvatar(
            size: 70,
            backgroundImage: NetworkImage(
              sharedData.profileImage,
            ),
          );
        } else {
          sharedData.flutterToast('No Image Selected');
          return GFAvatar(
            size: 70,
            backgroundImage: NetworkImage(
              sharedData.profileImage,
            ),
          );
        }
      },
    );
  }

  void getUserDataFromAPI(String id, String token) async {
//    UserData userData = new UserData();
//    if (token != ''  ) {
//      final response = await Requests.get(Utility.GET_USER_BY_ID_API + id,
//          headers: {'Authorization': 'bearer ' + token},
//          bodyEncoding: RequestBodyEncoding.FormURLEncoded);
//      print(response.json());
//      print(response.statusCode);
//      print(id);
//      print(token);
//
//      Utility.showLoadingDialog(context); //invoking login
//      await Future.delayed(Duration(seconds: 3));
//
//      if (response.statusCode == 200) {
//        response.raiseForStatus();
//        dynamic json = response.json();
//        UserInfo info = new UserInfo();
//        info = info.fromJson(json['Data']);
//        print('pasge index = ' + info.phone.toString());
//        fillFeilds(info);
//      }
//      Navigator.of(context).pop(); //close the dialog
//    } else
//      print('token is null ');
  }

  bool isValidEmail() {
    if (emailCon.text.trim().toString() == null ||
        emailCon.text.trim().toString() == '') return true;
    return EmailValidator.validate(emailCon.text.trim());
  }

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

  isInputValidate() {
    // if (isValidEmail() && isValidPhone())
    {
      print(emailCon.text + phoneCon.text + nameCon.text + locationCon.text);
      // here should do the request
    }
  }

  void _validateAndSubmit() {
    final form = formKey.currentState;
    if (form.validate()) {
      //form.save();
      isInputValidate();
    } else
      sharedData.flutterToast('Invalid Input');
  }
}
