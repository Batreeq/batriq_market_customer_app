import 'dart:async';
import 'package:customerapp/models/ConfrimOrderModel.dart';
import 'package:customerapp/models/TimesPricesDeliveryListClass.dart';
import 'package:customerapp/shared_data.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import '../cites.dart';

enum SingingCharacter { lafayette, jefferson }

class ConfiremOrderScreen extends StatefulWidget {
  bool isCash = true;
  String cartNum;
  String totalCartPrice ;
  var selectedTime;
  ConfiremOrderScreen({this.cartNum , this.totalCartPrice});

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
  _ConfiremOrderScreenState createState() => _ConfiremOrderScreenState(totalCartPrice , cartNum);
}

class _ConfiremOrderScreenState extends State<ConfiremOrderScreen> {
  String totalCartPrice ;
  TimesPricesListClass deliveryTimes;
  String selectedCity = 'Amman';
  String selectedRegion;
  LatLng cameraLocation;
  bool isLoading = false;
  bool isFullScreen = false;
  String cartNum ;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController noticeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List filteredRegions = regions.where((region) => region['city'].toString() == 'Amman').toList();
  Completer<GoogleMapController> _controller = Completer();
  final keyy = new GlobalKey<ScaffoldState>();
  bool _showGoogleMaps = false;
  int totalDeliveryPrice = 0;
  int checkedDeliveryIndex = 0;
  List< TimesPrices > timesPricesWhichSelected = new List<TimesPrices> ();
  List< Category > categoriesWhichSelected = new List<Category> ();

  _ConfiremOrderScreenState(this.totalCartPrice, this.cartNum);

  Widget buildCityWidget() {
    return Container(
      height: 90,
      child: DropDownFormField(
        titleText: 'اختر المدينة',
        hintText: '',
        value: selectedCity,
        onSaved: (value) {
//          setState(() {
//            selectedRegion = value;
//          });
        },
        onChanged: (value) {
          setState(() {
            selectedCity = value;
            getRegionsByCityName(selectedCity);
          });
        },
        dataSource: cites,
        textField: 'display',
        valueField: 'value',
      ),
    );
  }

  getDeliveryTimes(String regionName) async {
    String token = await sharedData.readFromStorage(key: 'token');
    print ('get dev to add '+token );
    final region = (regions.firstWhere(
            (regionData) => regionData['location'].toString() == regionName));
    int cityId = region['id'];
    print('city id ' + cityId.toString());
    String url = sharedData.getDeliveryPriceUrl + '228' +'&&api_token=$token'+ '&&cart_num=$cartNum' ;
    print ('url is' +url );
   var response = await Requests.get(url );
    print( response.json());
   print(response.statusCode.toString());
      if (response.statusCode == 200) {
      response.raiseForStatus();
      dynamic json = response.json();
         deliveryTimes = TimesPricesListClass.fromJson(json);

      print ('@@');
      if (deliveryTimes.timesPrices.length > 0)
      print(deliveryTimes.timesPrices
          .elementAt(0)
          .category
          .elementAt(0)
          .categoryName);
      else print ('list empty ');
    }
  }

  TimesPrices chosenTimeObject ;
  buildDeliveryTimes(TimesPrices obj) {

    Category category = new Category();
    List<bool> inputs = new List<bool>();
    for (int i = 0; i < obj.category.length; i++) {
      inputs.add(false);
    }
    //the widget
    Widget ui =  StatefulBuilder(
      builder: (context, setState) =>
      new Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 30,
        child: new ListView.builder(
            itemCount: inputs.length,
            itemBuilder: (BuildContext context, int index) {
               Widget card =  new Card(
                child: new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new Column(
                    children: <Widget>[
                      new CheckboxListTile(
                          value: inputs[index],
                          title: new Text(
                            obj.category.elementAt(index).time +
                                "         " +
                                obj.category.elementAt(index).price +
                                "  JD  ",
                            style: TextStyle(fontSize: 13),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool val) {
                            setState(() {
                              inputs = List.filled(inputs.length, false);
                              inputs[index] = val;
                              widget.selectedTime = obj.category.elementAt(index).time;
                            });
                            print ( widget.selectedTime.toString());
                            category = obj.category.elementAt(index) ;
                            print ('Chosen Category Price' + category.price.toString());
                          })
                    ],
                  ),
                ),
              );
              return card ;
            }),
      ),
    );
    categoriesWhichSelected.add(category);
    for( Category c in categoriesWhichSelected){
      print ('c price ');
      print (c.price);
    }
    chosenTimeObject= new TimesPrices();
    chosenTimeObject.category = categoriesWhichSelected;
    timesPricesWhichSelected.add(chosenTimeObject);
    for( TimesPrices c in timesPricesWhichSelected){
      print ('list length ');
      print (c.category.length.toString());
    }
    return ui ;
  }

  Widget buildRegionWidget() {
    return Container(
      height: 90,
      child: DropDownFormField(
        titleText: 'اختر المنطقة',
        hintText: '',
        value: selectedRegion,
        onSaved: (value) {},
        onChanged: (value) {
          setState(() {
            selectedRegion = value.toString();
            getDeliveryTimes(selectedRegion.toString());
          });
        },
        dataSource: filteredRegions,
        textField: 'location',
        valueField: 'location',
      ),
    );
  }

  getRegionsByCityName(String city) {
    filteredRegions =
        regions.where((region) => region['city'].toString() == city).toList();
    selectedRegion = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: keyy,
      backgroundColor: Colors.white,
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
            top: isFullScreen ? MediaQuery
                .of(context)
                .size
                .height : 200,
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildNameField(),
                    _buildPhoneField(),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: buildCityWidget(),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: buildRegionWidget(),
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                                      sharedData.visa,
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
                                      sharedData.cash,
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
            isFullScreen ? MediaQuery
                .of(context)
                .size
                .height - 100 : 200,
          ),
          isLoading
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

  void _modalBottomSheetMenu(TimesPrices object) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: new Text(
                  'اختر فترة التوصيل',
                  style: TextStyle(fontSize: 16, color: Colors.orange),
                ),
              ),
              Flexible(
                child: object != null
                    ? buildDeliveryTimes(object)
                    : Container(),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: 40,
                width: double.infinity,
                child: Container(
                  color: sharedData.mainColor,
                  child: MaterialButton(
                    child: Text(
                      'إرسال الطلب',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (widget.selectedTime != null) {
                        confirmOrder();
                        Navigator.of(context).pop();
                      } else {
                        sharedData.flutterToast('اختر فترة  التوصيل');
                      }
                      print ('last index = ' + lastIndex.toString() +'  '+ deliveryTimes.timesPrices.length.toString());

                      if (lastIndex == deliveryTimes.timesPrices.length )
                        barCodeDialog(deliveryTimes.barcode , /*devliveryPrice*/ '200' , totalCartPrice);
                    },
                  ),
                ),
              )
            ],
          );
        });
   // barCodeDialog(deliveryTimes.barcode , /*devliveryPrice*/ '200' , totalCartPrice);
  }

  int lastIndex = 0 ;
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

  Widget _buildNameField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          labelText: ' الاسم بالكامل', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'الرجاء كتابة إسمك';
        }
        else
          return null;
      },


    );
  }

  Widget _buildSubmitButton(context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 40,
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        color: sharedData.mainColor,
        onPressed: () {
        //  totalDeliveryPrice += int.parse(obj.category.elementAt(index).price) ;
          print ('total ' + totalDeliveryPrice.toString());
          TimesPrices timesPrices ;
          if (deliveryTimes != null) {
            if (deliveryTimes.timesPrices != null) {
              if ( deliveryTimes.timesPrices.length > 0)
                 for( timesPrices in deliveryTimes.timesPrices){
                 //  lastIndex +=1 ;
                   _modalBottomSheetMenu(timesPrices);
                   lastIndex ++ ;
                   //  qwe
                 }
              //
            }
            else
            print('times list is empty');
          }
          else {
            showSnackBar('اختر المدينة ثم المنطقة');
            print('delivery class list is empty');
          }
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
      controller: locationController,
      decoration: InputDecoration(
          labelText: 'العنوان بالتفصيل', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اكتب تفاصيل العنوان';
        } else
          return null;
      },
      onSaved: (String value) {
        //  formData['location'] = value;
      },
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: noticeController,
      decoration: InputDecoration(
          labelText: 'ملاحظات', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اكتب ملاحظاتك';
        }
        else
          return null;
      },
      onSaved: (String value) {

      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: phoneController,
      decoration: InputDecoration(
          labelText: ' رقم الموبايل', labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'الرجاء كتابة رقم الموبايل';
        } else
          return null;
      },
      onSaved: (String value) {

      },
    );
  }

  Future<void> confirmOrder() async {
    print ('in confirm order ');
    if (nameController.text
        .toString()
        .isEmpty) {
      sharedData.flutterToast("الرجاء ادخال الاسم");
return;
    }
    if (phoneController.text
        .toString()
        .isEmpty) {
      sharedData.flutterToast("الرجاء ادخال رقم الموبايل");
      return;
    }
    if (locationController.text
        .toString()
        .isEmpty) {
      sharedData.flutterToast("الرجاء ادخال العنوان بالتفصيل");
      return;
    }
    if (noticeController.text
        .toString()
        .isEmpty) {
      sharedData.flutterToast("الرجاء ادخال الملاحظة");
      return;
    }

    setState(() {
      isLoading = true;
    });
    Map<String, String> params1 = new Map();

    ConfrimOrderModel model = ConfrimOrderModel(
        nameController.text.toString()
        ,
        "free"
        ,
        phoneController.text.toString()
        ,
        locationController.text.toString()
        ,
        noticeController.text.toString()
        ,
        widget.isCash ? "cash" : "visa"
        ,
        token
        ,
        widget.cartNum.toString(),
        selectedCity.toString(),
        selectedRegion.toString(),
        widget.selectedTime.toString(),
        "111");
    params1['user_name'] = nameController.text.toString();
    //params1['user_name'] = 'ffffffff';
    params1['delivery_type'] = " ";
    params1['phone'] = phoneController.text.toString().trim();
    params1['notice'] = noticeController.text.toString().trim();
    params1['payment_type'] = widget.isCash ? "كاش" : "فيزا";
//    params['delivery_type'] = "???";
    params1['api_token'] = isRegistered() ? token : "";
    params1['cart_num'] = widget.cartNum.toString();
    params1['city'] = selectedCity.toString();
    params1['region'] = selectedRegion.toString();
//    params1['total_price'] = "120";
    params1['delivery_time'] = widget.selectedTime.toString();
    print("time : ${widget.selectedTime}");
    debugPrint("param" + model.toJson().toString());


    final url = Uri.parse('https://jaraapp.com/index.php/api/confirmOrder');
    debugPrint(url.toString());
    final response = await http.post(url, body: model.toJson());
    debugPrint("res " + response.body.toString());
    setState(() {
      isLoading = false;
    });

    showSnackBar("تمت العملية بنجاح");

//    Navigator.of(context).pop();
    print("resss :  ${response.statusCode}");
  }

  @override
  void initState() {
    showMap();
    if (sharedData.userInfo.name != null)
      nameController.text = sharedData.userInfo.name.toString();
    if (sharedData.userInfo.phone != null)
      phoneController.text = sharedData.userInfo.phone.toString();
  }

  void showSnackBar(message) {
    keyy?.currentState?.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(color: Colors.black, fontFamily: 'default'),
        textAlign: TextAlign.center,
      ),
      backgroundColor: sharedData.mainColor,
    ));
  }

  Color color= Colors.green;

  String helpText ='';
  double totalWithDel = 0 ;
  void barCodeDialog(List<Barcode> barCodes , String deliveryPrice , String totalCartPrice ) {

    TextEditingController codeCon = new TextEditingController();
    totalWithDel = (double.parse(totalCartPrice) + double .parse(deliveryPrice));
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: StatefulBuilder(
                  builder: (context , setState){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children:getBarCodesUI(barCodes),
                        ) ,
                        Text('سعر التوصيل : ' + deliveryPrice),
                        Text('سعر الكلي للسلة : ' + totalCartPrice),
                        Text('سعر الكلي شامل التوصيل : ' + totalWithDel.toString() ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: codeCon,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: color)
                                  ),
                                  labelText: 'رمز الكوبون',
                                  hintText: 'ادخل رمز الكوبون',
                                  helperText: helpText,
                                  helperStyle: TextStyle(
                                    color: color
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey),
                                  labelStyle: TextStyle(
                                      color: color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*   Flexible(
                    child: object != null
                        ? buildDeliveryTimes(object)
                        : Container(),
                  ),*/
                        Container(
                          margin: EdgeInsets.all(15),
                          height: 40,
                          width: double.infinity,
                          child: Container(
                            color: sharedData.mainColor,
                            child: MaterialButton(
                              child: Text(
                                'إرسال الطلب',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {

                                Barcode code = new Barcode();
                                bool isFound = false ;
                                for (code in barCodes) {
                                  if (codeCon.text == code.code){
                                    isFound = true ;
                                    break ;
                                  }
                                }

                                print (isFound.toString());
                                if (isFound){
                                  if (code.type == "cart_val"){
                                    double c =( double.parse(totalCartPrice) )* code.value;
                                    setState(() {
                                      totalCartPrice = (( double.parse(totalCartPrice) ) - c) .toString();
                                    });
                                  }
                                  else if (code.type == "delviery_val"){
                                    double c =( double.parse(deliveryPrice) )* code.value;
                                    setState(() {
                                      deliveryPrice = (( double.parse(deliveryPrice) ) - c) .toString();
                                    });
                                  }

                                  setState(() {
                                    totalWithDel = (double.parse(totalCartPrice) + double .parse(deliveryPrice));
                                    color = Colors.green ;
                                    helpText = '';
                                  });

                                }
                                else
                                  setState(() {
                                    color = Colors.red ;
                                    helpText = 'رمز الكوبون ليس صحيح' ;
                                  });
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
          );
        });
  }

  List<Widget> getBarCodesUI(List<Barcode> codes){
    List<Widget > codesList = new List();
    Widget column ;
    for (Barcode b in codes){
     column = Container(
            margin: EdgeInsets.all(10),
            child: new Text(
              'كود : ' + b.code,
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
          );
     codesList.add(column);
    }
    return codesList ;
  }
}