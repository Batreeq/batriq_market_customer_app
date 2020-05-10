import 'dart:async';
import 'dart:convert';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { lafayette, jefferson }

class ConfiremOrderScreen extends StatefulWidget {
  bool isCash = true;
  String cartNum;
  ConfiremOrderScreen({this.cartNum});
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locationData.latitude, locationData.longitude),
    zoom: 19.151926040649414,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(locationData.latitude, locationData.longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  _ConfiremOrderScreenState createState() => _ConfiremOrderScreenState();
}

class _ConfiremOrderScreenState extends State<ConfiremOrderScreen> {
  LatLng cameraLocation;
  bool isFullScreen = false;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'تأكيد الطلب',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: sharedData.mainColor,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: isFullScreen ? MediaQuery.of(context).size.height : 200,
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildNameField(),
                    _buildPhonField(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: _buildregionField(),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: _buildCityField(),
                          ),
                        ],
                      ),
                    ),
                    _buildAddress(),
                    _buildNotesField(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 30, 10),
                      alignment: Alignment.topRight,
                      child: Text(
                        'طريقة الدفع',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.isCash = false;
                                });
                              },
                              child: Container(
                                height: 50,
                                child: Card(
                                  color: !widget.isCash
                                      ? sharedData.mainColor
                                      : Colors.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.blue.withOpacity(0.3),
                                          width: 0.5),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      'فيزا',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.isCash = true;
                                });
                              },
                              child: Container(
                                height: 50,
                                child: Card(
                                  color: widget.isCash
                                      ? sharedData.mainColor
                                      : Colors.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.blue.withOpacity(0.3),
                                          width: 0.5),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      'كاش',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildSubmitButton(context),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
          //google map
          Positioned(
            child: Stack(
              children: <Widget>[
                _showGoogleMaps ? googleMap() : Container(),
                Center(
                  child: Icon(
                    Icons.place,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 20,
                  child: Container(
                    height: 35,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF1B0B0A0A)),
                    child: MaterialButton(
                      child: Text(
                        'تحديد هنا',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        mapLocation = cameraLocation;
                        print("maaaaap $cameraLocation");
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xFF520B0A0A),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: _goToTheLake,
                          child: Icon(
                            Icons.my_location,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        height: 35,
                        margin: EdgeInsets.all(10),
                        width: 35,
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.all(10),
                        color: Color(0xFF520B0A0A),
                        width: 35,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              isFullScreen = !isFullScreen;
                            });
                          },
                          child: Icon(
                            Icons.zoom_out_map,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            left: 0,
            top: 0,
            right: 0,
            height:
                isFullScreen ? MediaQuery.of(context).size.height - 100 : 200,
          ),
          isloading
              ? Center(
                  child: Container(
                    child: SpinKitPulse(
                        duration: Duration(milliseconds: 1000),
                        color: sharedData.mainColor,
                        size: 70
//                    lineWidth: 2,
                        ),
                    width: 100,
                    height: 100,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(ConfiremOrderScreen._kLake));
  }

  void _modalBottomSheetMenu() {
    SingingCharacter _character = SingingCharacter.lafayette;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            width: 260.0,
            height: 230.0,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
          );
        });
  }

  bool _showGoogleMaps = false;

  Widget googleMap() => GoogleMap(
        onCameraMove: (pos) {
          cameraLocation = pos.target;
        },
        onCameraIdle: () {
          cameraLocation != null ? print(cameraLocation.longitude) : print("");
        },
        mapType: MapType.normal,
        initialCameraPosition: ConfiremOrderScreen._kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );

  void showMap() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showGoogleMaps = true;
      });
    });
  }

  final Map<String, dynamic> formData = {'user_name': null, 'phone': null};
  final _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: ' الاسم بالكامل', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'الرجاء كتابة إسمك';
        }
      },
      onSaved: (String value) {
        formData['user_name'] = value;
      },
    );
  }

  Widget _buildregionField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'المنطقة', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اكتب المنطقة';
        }
      },
      onSaved: (String value) {
        formData['region'] = value;
      },
    );
  }

  Widget _buildCityField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'المدينة', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اكتب المدينة';
        }
      },
      onSaved: (String value) {
        formData['city'] = value;
      },
    );
  }

  Widget _buildSubmitButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        color: sharedData.mainColor,
        onPressed: () {
          _submitForm();
        },
        child: Text(
          'اطلب الان',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'العنوان بالتفصيل', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اكتب تفاصيل العنوان';
        }
      },
      onSaved: (String value) {
        formData['location'] = value;
      },
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'ملاحظات', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اكتب ملاحظاتك';
        }
      },
      onSaved: (String value) {
        formData['notice'] = value;
      },
    );
  }

  Widget _buildPhonField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: ' رقم الموبايل', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'الرجاء كتابة رقم الموبايل';
        }
      },
      onSaved: (String value) {
        formData['phone'] = value;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //onSaved is called!
      confirmOrder(formData);
    }
  }

  bool isloading = false;
  Future<void> confirmOrder(Map<String, dynamic> params) async {
    params['delivery_type'] = "???";
    params['payment_type'] = widget.isCash ? "كاش" : "فيزا";
    params['delivery_type'] = "???";
    params['api_token'] = token;
    params['cart_num'] = widget.cartNum;
    params['total_price'] = "120";
    params['delivery_time'] = "12 pm";
    setState(() {
      isloading = true;
    });
    final Uri url = Uri.parse('https://jaraapp.com/index.php/api/confirmOrder');
    await http.post(url, body: params);
    setState(() {
      isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    showMap();
  }
}
