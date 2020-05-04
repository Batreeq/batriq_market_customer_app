import 'dart:convert';
import 'dart:io';
import 'package:customerapp/models/UserInfo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:requests/requests.dart';
import 'AddMemberScreen.dart';
import 'HomePage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State {
  Future <File> file;
  String base64Image = '';
  File tempFile;
  final formKey = GlobalKey<FormState>();

  Widget defaultImageWidget;
  String name, phone, location, email, image;
  TextEditingController nameCon, phoneCon, locationCon, emailCon;

  FocusNode nameFocus, phoneFocus, locationFocus, emailFocus;
  bool phoneChanged;
  UserInfo info ;
  List<FamilyMembers> familyMembers;
  Size size;

  String token;

  TextEditingController salaryCon = new TextEditingController();

  Widget getTable(List<FamilyMembers> familyMembers) {
    return DataTable(
      columnSpacing: 20,
      columns: [
        DataColumn(
          label: Row(
            children: <Widget>[
              Icon(Icons.keyboard_arrow_down),
              Text(
                'العمر',
                style: sharedData.tableFieldsTextStyle,
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            children: <Widget>[
              Icon(Icons.keyboard_arrow_down),
              Text(
                'الجنس',
                style: sharedData.tableFieldsTextStyle,
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            children: <Widget>[
              Icon(Icons.keyboard_arrow_down),
              Text(
                'الاسم',
                style: sharedData.tableFieldsTextStyle,
              ),
            ],
          ),
        ),
      ],
      rows: familyMembers
          // Loops through dataColumnText, each iteration assigning the value to element
          .map(
            ((element) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      element.age.toString(),
                      style: sharedData.tableFieldsTextStyle,
                    )),
                    //Extracting from Map element the value
                    DataCell(Text(
                      element.gender,
                      style: sharedData.tableFieldsTextStyle,
                    )),
                    DataCell(Text(
                      element.name,
                      style: sharedData.tableFieldsTextStyle,
                    )),
                  ],
                )),
          )
          .toList(),
    );
  }

  Future<void> familyDialogUI() {
    String title = ' : عرف أفراد اسرتك ';
    TextEditingController familyNumberCon = new TextEditingController();

    if (familyMembers != null)
      familyNumberCon.text = familyMembers.length.toString();

    return showDialog<void>(
        context: context,
        builder: (BuildContext c) {
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
                      Text(
                        title,
                        textAlign: TextAlign.right,
                        style: sharedData.textInProfileTextStyle,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(
                            'عدد أفراد الاسرة',
                            style: sharedData.tableFieldsTextStyle,
                          ),
                          Container(
                            width: 100,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextFormField(
                                  controller: familyNumberCon,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          InkWell(
                            onTap: addMember,
                            child: Text(' اضافة ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: sharedData.yellow,
                                    fontSize: 18)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: getTable (familyMembers),
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(
                            'الدخل الشهري',
                            style: sharedData.tableFieldsTextStyle,
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  controller: salaryCon,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: 'J.D',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('حفظ'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: sharedData.yellow,
                        ),
                      )
                    ],
                  )),
            ))),
          );
        });
  }

  Future<String> getToken() async {
    //token = await sharedData.getToken();
    token = await sharedData.readFromStorage(key: 'token');
    if (token == null) {
      token = '';
      print('after get token from write, its empty ');
    } else
      print('token from profile get token method $token');

    return token;
  }

  @override
  void initState() {
    super.initState();
    // token = '03ec18b8f8c4252e2794aa316dba652147f4b559871e8061bf6d420a9e9d4807'; // with family members
    familyMembers = sharedData.familyMembers;
    info = sharedData.userInfo ;
    image = sharedData.profileImage;

    nameCon = new TextEditingController(text: name);
    phoneCon = new TextEditingController(text: phone);
    locationCon = new TextEditingController(text: location);
    emailCon = new TextEditingController(text: email);
    nameFocus = new FocusNode();
    phoneFocus = new FocusNode();
    locationFocus = new FocusNode();
    emailFocus = new FocusNode();
    getToken().then((tokn) {
     // getUserDataFromAPI(tokn);
      token = tokn ;
    });
    defaultImageWidget = GFAvatar(
      size: 70,
      backgroundImage: NetworkImage(image),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2));
    //  print('token from init ' + token);

    size = MediaQuery.of(context).size;
    // token not null so user registered before so his info will get from api and put them in the fields


    return Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: sharedData.appBar(context, 'الملف الشخصي', Icon(Icons.arrow_forward), (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
              (BuildContext context) => HomePagee()));
        }),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                          child: InkWell(
                            child: Icon(Icons.add),
                          )),
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
                            width: MediaQuery.of(context).size.width - 50,
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
                  InkWell(
                    child: Text(
                      sharedData.textInProfileTextField,
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      familyDialogUI();
                    },
                  )
                  // name
                ],
              ),
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
                      validator: (value) {
                        if (value.isNotEmpty) if (!isValidPhone()) {
                          return 'Invalid Phone Format';
                        }
                        phoneChanged = true;
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
                        _fieldFocusChange(context, nameFocus, locationFocus);
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
                        _fieldFocusChange(context, locationFocus, emailFocus);
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

  //this method to get the user info when he open profile screen will call this method to fill the fields
  //if the user want to open profile without registration, the token will be null so sent the token as null to api to create anew account
  void getUserDataFromAPI(String token) async {
    //  token = '03ec18b8f8c4252e2794aa316dba652147f4b559871e8061bf6d420a9e9d4807';
    if (token != '' && token != null) {
      final response = await Requests.get(
        sharedData.getUserInfoUrl + token,
        //  bodyEncoding: RequestBodyEncoding.FormURLEncoded
      );
      print(token);
      if (response != null) {
        print(response.json().toString());
        print(response.statusCode);
      } else
        print('response = null ');

      sharedData.showLoadingDialog(context); //invoking login
      await Future.delayed(Duration(seconds: 4));

      if (response.statusCode == 200) {
        response.raiseForStatus();
        dynamic json = response.json();
        info = UserInfo.fromJson(json['user_info']);
        setState(() {
        //  userProfile = UserProfile.fromJson(json);
        });

        if (null != info && null != familyMembers) {
          print(' user phone number = ' + info.phone.toString());
          print(' family member list = ' +
              familyMembers.length.toString());
          print("token in get user info " + info.apiToken);
          sharedData.writeToStorage(key: 'token', value: info.apiToken);
          sharedData.setToken(info.apiToken);
        } else
          print('info object which get from json = null');
        fillFields(info);
      }
      Navigator.of(context).pop(); //close the dialog
    } else {
      print('token is null $token');
//      emailCon.text = '';
//      nameCon.text = '';
      image = sharedData.profileImage;
//      phoneCon.text = '';
//      locationCon.text = '';
    }
  }

  submitUserData(String token) async {
    //  token = '2d0ff96767efed695b53b04e36941b5f8df3ce30d2bdcc4b98db0a29388e299a';

    if (token != null && token != '') info.apiToken = token;

    if (token == null ||
        token == '' && phoneCon.text == null ||
        phoneCon.text == '')
      sharedData
          .flutterToast('Fill Your Phone Number to Update Your Profile 😍 ');
    else {
      // if (token != '') {
      info.name = nameCon.text == null || nameCon.text == '' ? '' : nameCon.text;
      info.location = locationCon.text == null || location == '' ? '' : locationCon.text;
      info.email = emailCon.text == null || email == '' ? '' : emailCon.text;
      info.image = image == null || image == '' ? '' : image;
      info.phone = phoneCon.text == null || phone == '' ? '' : phoneCon.text;
      info.salary = salaryCon.text == null || salaryCon.text == '' ? '' : salaryCon.text;

      print('will add name =' + nameCon.text);
      print('will add phone =' + phoneCon.text);
      print('will add email =' + emailCon.text);
      print('will add loc =' + locationCon.text);
      print('will add salary =' + salaryCon.text);

      var response;
      if (token == null || token == '')
        response = await Requests.post(
          sharedData.registerUrl,
          body: info.toJson(false),
        );
      else
        response = await Requests.post(
          sharedData.registerUrl,
          body: info.toJson(true),
        );
      if (response != null) {
        print(response.json());
        print(response.statusCode);
      } else
        print('response is null');
      print(token);

      sharedData.showLoadingDialog(context); //invoking login
      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        response.raiseForStatus();
        dynamic json = response.json();
        info = UserInfo.fromJson(json['user']);
        if (null != info) {
          print(' user phone number = ' + info.phone.toString());
          print(' token in submit method = ' + info.apiToken.toString());
          sharedData.writeToStorage(key: 'token', value: info.apiToken);
        } else
          print('user object which get from json = null');
        sharedData.flutterToast('You registered Sucsessfully 😍 ');
      }
      Navigator.of(context).pop(); //close the dialog
    }
  }

  addMember() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            AddMemberScreen(salaryCon.text.toString())));
  }

  // to open the gallery to select an image
  chooseImageFromGallery() async  {

      // open gallery to pick image
      file =  ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      defaultImageWidget = FutureBuilder<File>(
        future: file,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            // to transfer the image to base64 to upload it it the database
            print (' file data from snapshot' + snapshot.data.toString());
           base64Image =  base64Encode( snapshot.data.readAsBytesSync() ) ;

            print (' image 64 = ' + base64Image);
            return  Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(49.0)),
                color: sharedData.grayColor12,
              ),
              child: Image.file(
                snapshot.data ,fit: BoxFit.cover,
                height: 100.0,
                width: 100.0,
              ),
            );


            /*GFAvatar(
            shape: GFAvatarShape.standard,
            size: 70,
             child : Image.file(snapshot.data ,fit: BoxFit.fitHeight,)
          );*/

          } else if (snapshot.hasError) {
            sharedData.flutterToast('Error In Uploading Image ');
            return GFAvatar(
              shape: GFAvatarShape.circle,
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
    });
  }

  //this method will fill the fields with data came from the api after do GET request to get user data to fill them once the user open profile screen
  void fillFields(UserInfo info) {
    setState(() {
      name = info.name;
      email = info.email;
      location = info.location;
      phone = info.phone;
      if (info.image != null && info.image != '')
        image = info.image;
      else
        image = sharedData.profileImage;

      if (info.name != null) sharedData.name = info.name;

      nameCon.text = info.name;
      emailCon.text = info.email;
      locationCon.text = info.location;
      phoneCon.text = info.phone;
    });
  }

  // to check if the email valid like email pattern (name@domain.com)
  bool isValidEmail() {
    if (emailCon.text.trim().toString() == null ||
        emailCon.text.trim().toString() == '') return true;
    return EmailValidator.validate(emailCon.text.trim());
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

  isInputValidate() {
    // if (isValidEmail() && isValidPhone())
    {
      print(emailCon.text + phoneCon.text + nameCon.text + locationCon.text);
      // here should do the request
    }
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
      print(phoneChanged.toString());
      isInputValidate();
      submitUserData('');
    } else
      sharedData.flutterToast('Invalid Input');
  }
}
