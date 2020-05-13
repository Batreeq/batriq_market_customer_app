import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bloc/appBarTitleBloc.dart';
import 'DataLayer/Catigory.dart';
import 'DataLayer/tab.dart';
import 'models/Employee.dart';
import 'models/UserInfo.dart';
import 'models/orderInfo.dart';
import 'package:customerapp/models/UserBalance.dart';
import 'models/UserInfo.dart';
import 'models/UserBalance.dart';
import 'models/orderInfo.dart';

///this file for shared data between pages
///
///
List<ProductTab> tabs = [];
LocationData locationData;
String token = "";
appBarBloc appbarBloc;
bool isRegistered() {
  if (token != null && token.length > 10) {
    return true;
  } else {
    return false;
  }
}

readToken() async {
  token = await sharedData.readFromStorage(key: 'token');
}

Future<void> getUserLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
}

String appBarTitle = "";
List<String> icons = [
  "assets/images/user.png",
  "assets/images/order.png",
  "assets/images/payment.png",
  "assets/images/win.png",
  "assets/images/question.png",
  "assets/images/privacy.png",
  "assets/images/privacy.png",
  "",
  "assets/images/logout.png",
];
final String homeTextPage = 'الصفحة الرئيسية';
final String workWithusText = 'اعمل معنا';
final String cardText = 'سلة المشتريات';
final String chatText = 'المراسلة';

List categoriesList = [];

List<String> titles = [
  "الملف الشخصي",
  "طلبياتي السابقة",
  "الرصيد",
  "اكسب معنا",
  "المساعدة",
  "سياسة الخصوصية",
  "شروط الإستخدام",
  "تغيير اللغة",
  "تسجيل الخروج",
];
LatLng mapLocation;
const primary_color = Color(0xFFFBBF00);
const socondary_color = Color(0xFFFBBF00);
const bottomNavigationBartextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black38);

class sharedData {
  static const TextStyle appBarTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 21,
      fontFamily: 'Cairo-Black');
  static const mainColor = Color(0xFFFBBF00);
  static List<Catigory> catigoriesData = [];
  static const ImageIcon homeIcon = ImageIcon(
    AssetImage("assets/images/icons/home.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const ImageIcon teamIcon = ImageIcon(
    AssetImage("assets/images/icons/team.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const ImageIcon cardIcon = ImageIcon(
    AssetImage("assets/images/icons/card.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const ImageIcon chatIcon = ImageIcon(
    AssetImage("assets/images/icons/chat.png"), /*color: Color(0xFF3A5A98)*/
  );
  static const Icon searchIcon = Icon(Icons.search);
  static const Icon menuIcon = Icon(Icons.menu);
  static const Icon phoneIcon = Icon(
    Icons.phone,
    color: sharedData.yellow,
  );
  static const Icon locationIcon = Icon(
    Icons.location_on,
    color: sharedData.yellow,
  );
  static const Icon emailIcon = Icon(
    Icons.email,
    color: sharedData.yellow,
  );
  static const Icon nameIcon = Icon(Icons.person, color: sharedData.yellow,);
  static const Icon passwordIcon = Icon(
    Icons.lock_outline, color: sharedData.yellow,);

  static const TextStyle navBarTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12);
  static const TextStyle textInProfileTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black);
  static Color grayColor12 = new Color(0x1F000000);
  static const Color yellow = const Color(0xFFFFEB3B);
   static const TextStyle yellowStyle = TextStyle(fontSize: 19, color: yellow, fontWeight: FontWeight.bold,fontFamily: 'Cairo-Black');
  static const TextStyle size19Style = TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Cairo-Black');


  static const String searchHintText = 'البحث';
  static const String phoneHintTextField = 'رقم الهاتف';
  static const String ageHintTextField = 'العمر';
  static const String nameHintTextField = 'الاسم';
  static const String passwordTextField = 'كلمة المرور';
  static const String locationHintTextField = 'الموقع';
  static const String emailHintTextField = 'البريد الالكتروني';
  static const String updateProfileTextField = 'تعديل الملف الشخصي';
  static const String textInProfileTextField = 'اكمل الملف الشخصي للحصول على جوائز * ';
  static const String activeBalanceTextField = 'رصيد فعال';
  static const String notActiveBalanceTextField = 'رصيد غير فعال';
  static const String totalBalanceTextField = 'مجموع الرصيد';
  static const String rechargeBalanceTextField = 'اعادة شحن رصيد';
  static const String accountStatementTextField = 'كشف حساب';

  static const String altPhoneHintTextField = 'رقم الهاتف البديل ';
  static const String addressHintTextField = 'العنوان ';
  static const String modelHintTextField = 'موديل المركبة';
  static const String typeHintTextField = ' نوع المركبة';
  static const String lastNameTextField = 'اسم العائلة';

  static const TextStyle tableFieldsTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 11,
      fontFamily: 'default');


  // this list of orders which the user will order , filled from the api in myOrders Screen
  static List<OrderInfo> listOfColumns = new List<OrderInfo>();
  static const String totalBalanceData = '0.220';
  static const String activeBalanceData = '0.200';
  static const String notActiveBalanceData = '0.20';

  static Widget appBar(
      BuildContext context, String title, Icon icon, void fun()) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.black),
      ),
      centerTitle: true,
      // automaticallyImplyLeading: true,
      actions: <Widget>[
        icon != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: icon,
                  onTap: fun,
                ),
              )
            : Container()
      ],
    );
  }

  // this list of the images which will be used in the boxes in home screen, and filled in splash screen from api
  static const List<String> boxesImages = [
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
    'https://www.pngkit.com/png/detail/14-147273_imagenes-png-tumblr-hipster-cute-cartoon-girl-png.png',
  ];

  // this list of the texts which will be used in the boxes  in home screen,and filled in splash screen from api
  static const List<String> boxesTexts = [
    'سميد',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
    'رز ',
  ];

  // this list of the images which will be used in the slider in home screen,and filled in splash screen from api
  static List<String> sliderHomeImages = [];

  // this method takes a message as parameter to show a toast
  static flutterToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: mainColor,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static String token;


  static Future<void> ackAlert(BuildContext context, String title,
      String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          //backgroundColor: dialogBackgroundColor,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: TextStyle(fontSize: 18),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //to get token locally from sharedPreferences and save the value to the static "token"  variable
  static Future <String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.get('token',);
    token =
    '03ec18b8f8c4252e2794aa316dba652147f4b559871e8061bf6d420a9e9d4807'; // with family members
    token =
    '71b57bad20073f55373c27cb681c6a84d6ec2d1ddd7f4d2b8d5164e98728f88c'; // without

    if (token != null)
      print('token when init ' + token);
    else
      print('no old token ');

    return token;
  }

  static FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<bool> writeToStorage({String key, String value}) async {
    print (token) ;
    await storage
        .write(
          key: key,
          value: value,
        )
        .then((val) {});
    token = value;
  }

  static Future<String> readFromStorage({String key}) async {
    //storage.write(key: key, value: '0efa83ba127ea5118042c63bdcf4005063b375cbd9e103af137165a3e067352c' , );
    String s = await storage.read(
      key: key,
    );
    return storage.read(
      key: key,
    );
  }

  static logout() async {
    await storage.delete(key: "token");
    token = "";
    sharedData.token = "";
    flutterToast("تم تسجيل الخروج ");
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      token,
      'token',
    );
  }

  // to show the loader
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: null,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                        ),
                      ]),
                    )
                  ]));
        });
  }

  static const String searchUrl = 'https://jaraapp.com/index.php/api/search?';
  static const String getUserInfoUrl =
      'https://jaraapp.com/index.php/api/userInfo?api_token=';
  static const String registerUrl =
      'https://jaraapp.com/index.php/api/register?';
  static const String addMemberUrl =
      'https://jaraapp.com/index.php/api/addFamilyMembers';
  static const String myOrdersUrl = 'https://jaraapp.com/index.php/api/myOrders';
  static const String pointsProductsUrl = 'https://jaraapp.com/index.php/api/getPointsProducts';
  static const String replacePointsUrl = 'https://jaraapp.com/index.php/api/replacePoints';


  static String userPoints = '0';

  //static List <UserPayments>  listOfUserPayment ;

//static  String name, phone, location, email, image;

  static String welcomeTextInLoginDriver = 'اهلا بك مرة اخرى في بطريق ماركت ';
  static String dontHaveAccount = ' ليس لدي حساب ؟ ';
  static String createAccount = ' انشاء حساب ';
  static String loginUsingText = 'سجل دخولك بواسطة';

  static String termsImage =
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80';
  static String privacyImage =
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80';
  static String helpImage =
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80';

  static const String profileImage = 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80';
    static String name = ' ';

  static String termsText = 'Title Title Title TitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitle';
  static String privacyText = 'https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=v';
  static String helpText = 'https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=https://jaraapp.com/index.php/api/userBalance?api_token=v';

  static String termsTitle = 'Title';
  static String privacyTitle = 'Title';
  static String helpTitle = 'Title';

  static List<FamilyMembers> familyMembers = new List<FamilyMembers>();
  static UserInfo userInfo = new UserInfo();
  static UserBalance userBalance = new UserBalance();

  static List<UserPayments> listOfUserPayment = new List<UserPayments>();
  static List<EmployeeInfo> listEmployeeInfo = new List<EmployeeInfo>();

  static String orderNo = '20';
  static String stopPointNumber = '1';

  static String whatsAppURL = 'https://api.whatsapp.com/send?phone=+962786892862';

}
