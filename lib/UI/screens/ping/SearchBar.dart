import 'package:customerapp/Bloc/bloc_provider.dart';
import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/DataLayer/Product.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/product_detail_screen.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:customerapp/models/searchResult.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;
import 'package:customerapp/Bloc/appBarTitleBloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../shared_data.dart';
import 'package:customerapp/shared_data.dart';

class CustomAppBar extends StatelessWidget {
  int currentPage = 1;
  final scaffoldKey;
  CustomAppBar({this.currentPage, this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    appbarBloc = new appBarBloc();
    return Container(
      height: 75,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/app_bar_background.png',
            height: 75,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            right: 0,
            bottom: 10,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  'assets/images/menu.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 5,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black, // Here
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SearchPage()));
                },
              ),
            ),
          ),
          BlocProvider<appBarBloc>(
            bloc: appbarBloc,
            child: StreamBuilder<String>(
                stream: appbarBloc.titleStream,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: Text(
                          snapshot.data == null ? appBarTitle : snapshot.data),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  SearchData searchData = new SearchData();
  bool _hasSpeech = false;
  bool _stressTest = false;
  double level = 0.0;
  int _stressLoops = 0;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 130,
            color: sharedData.mainColor,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: SearchBar<Products>(
              searchBarStyle: SearchBarStyle(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(10),
                  borderRadius: BorderRadius.circular(0)),
              onCancelled: () {
                // on press cancel button
                Navigator.of(context).pop();
              },
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              icon: sharedData.searchIcon,
              hintText: sharedData.searchHintText,
              onSearch: search,
              onError: (error) {
                print(error.toString());
                return Center(
                    child: Text(
                  'لا توجد نتائج',
                  style: sharedData.textInProfileTextStyle,
                ));
              },
              onItemFound: (Products post, int index) {
                // onItemFound callback in order to return the Widget corresponding to one item of the list ,  and return a ListTile :
                return Column(
                  children: <Widget>[
                    index == 0
                        ? SizedBox(
                            height: 70,
                          )
                        : Container(),
                    buildSearchVoiceItem(post),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap:
                    !_hasSpeech || speech.isListening ? null : startListening,
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset(
                    'assets/images/speech.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
          isVoice
              ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                      color: Colors.white, child: buildSearchVoiceList()),
                )
              : Container(),
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
          Container(
            height: speech.isListening ? 250 : 60,
            margin: EdgeInsets.only(top: 200),
            width: double.infinity,
            child: Column(children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            bottom: 10,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: speech.isListening
                                  ? Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: .26,
                                              spreadRadius: level * 1.5,
                                              color:
                                                  Colors.black.withOpacity(.05))
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: IconButton(icon: Icon(Icons.mic)),
                                    )
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              speech.isListening
                  ? Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(lastError),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              speech.isListening
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: sharedData.mainColor,
                      child: Center(
                          child: Text(
                        "تحدث الان  .... ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
            ]),
          ),
        ],
      ),
    );
  }

  bool isloading = false;
  void NavigatorPage(Product product) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProductDetailsScreen(
              product: product,
            )));
  }

  List<Products> productsList;

  // this function called   the user type string and will take the searched String and return a list of Post items generated from the String.
  Future<List<Products>> search(String searchString) async {
    getSearchDataFromAPI(searchString); //.then((val) async {
    if (sharedData != null) {
      productsList = searchData.products;
      // here should be the search api to get te result
      await Future.delayed(Duration(seconds: 5));
      return searchData.products;
    } else {
      sharedData.flutterToast('List is Empty');
    }
  }

  Future<SearchData> getSearchDataFromAPI(String searchString) async {
    // searchString = 'بيض'
    setState(() {
      isVoice = false;
    });
    print(searchString);
    if (searchString != '') {
      final response = await Requests.get(
          sharedData.searchUrl + 'name=' + searchString,
          bodyEncoding: RequestBodyEncoding.FormURLEncoded);
      print(response.json());
      print(response.statusCode);

      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        // response.raiseForStatus();
        dynamic json = response.json();
        searchData = SearchData.fromJson(json);
        if (searchData.products.length != 0)
          print('name index 0 = ' + searchData.products.elementAt(0).name);
        else
          print('list of products is null ');
        //  search(searchString , searchData
        // fillFeilds(info);
        //return sharedData ;
      }
    } else
      print('Search String is null ');
  }

  Widget buildSearchVoiceList() {
    return ListView.builder(
      itemCount: searchData.products != null ? searchData.products.length : 0,
      itemBuilder: (ctx, i) {
        return buildSearchVoiceItem(searchData.products[i]);
      },
    );
  }

  Widget buildSearchVoiceItem(Products post) {
    return InkWell(
      onTap: () {
        NavigatorPage(new Product(
            title: post.name,
            image: post.image,
            size: post.size,
            price: post.price,
            id: post.id.toString(),
            catigory: Catigory(id: post.categoryId, image: "", name: "")));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side:
                new BorderSide(color: Colors.blue.withOpacity(0.3), width: 0.5),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: 90,
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      post.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue.withOpacity(0.3),
                  height: double.infinity,
                  width: 1,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              post.name ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ///total price
                            Text(
                              "عروض اصنافي" + "  JD",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),

                            ///price
                            Text(
                              post.price + "  JD",
                              style: TextStyle(
                                  color: sharedData.mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isVoice = false;

  Future<SearchData> getSearchDataByVoiceFromAPI(String searchString) async {
    setState(() {
      isloading = true;
    });
    // searchString = 'بيض'
    print(searchString);
    if (searchString != '') {
      final response = await Requests.get(
          sharedData.searchUrl + 'name=' + searchString,
          bodyEncoding: RequestBodyEncoding.FormURLEncoded);
      print(response.json());
      print(response.statusCode);

      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        // response.raiseForStatus();
        dynamic json = response.json();
        searchData = SearchData.fromJson(json);
        if (searchData.products.length != 0)
          print('name index 0 = ' + searchData.products.elementAt(0).name);
        else
          print('list of products is null ');
        //  search(searchString , searchData
        // fillFeilds(info);
        //return sharedData ;
      }
    } else
      print('Search String is null ');

    setState(() {
      isVoice = true;
      isloading = false;
    });
  }

  void stressTest() {
    if (_stressTest) {
      return;
    }
    _stressLoops = 0;
    _stressTest = true;
    print("Starting stress test...");
    startListening();
  }

  void changeStatusForStress(String status) {
    if (!_stressTest) {
      return;
    }
    if (speech.isListening) {
      stopListening();
    } else {
      if (_stressLoops >= 100) {
        _stressTest = false;
        print("Stress test complete.");
        return;
      }
      print("Stress loop: $_stressLoops");
      ++_stressLoops;
      startListening();
    }
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    print('start');
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    lastWords = "${result.recognizedWords}";
    getSearchDataByVoiceFromAPI(lastWords);
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    changeStatusForStress(status);
    setState(() {
      lastStatus = "$status";
    });
  }
}
