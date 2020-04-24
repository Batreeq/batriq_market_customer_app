import 'package:carousel_slider/carousel_slider.dart';
import 'package:customerapp/UI/screens/balance_screen.dart';
import 'package:customerapp/UI/screens/ping/BalanceDetails.dart';
import 'package:customerapp/UI/screens/ping/SearchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import '../../../shared_data.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String token;

  // this method to get the sequers in the home page (include image and text filled form the api)
  Widget getList() {
    return GridView.count(
        shrinkWrap: true,
        // Create a grid with 2 columns.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(sharedData.boxesImages.length, (index) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFAvatar(
                      backgroundImage:
                          NetworkImage(sharedData.boxesImages.elementAt(index)),
                      shape: GFAvatarShape.standard)
              ),
              Center(
                  child: Text(
                    sharedData.boxesTexts.elementAt(index),
                style: sharedData.optionStyle,
              ))
            ],
          );
        }));
  }

  // this method to get the slider at the top of the home page with images came from api filled in the splash screen
  Widget getSlider(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        // height: 400.0,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 900),
        autoPlayCurve: Curves.easeInQuad,
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        items: sharedData.sliderHomeImages.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                // width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                   color: sharedData.grayColor12,
                    image: DecorationImage(
                        image: NetworkImage(i)
                    )
                ),
              );
            },
          );
        }).toList(),
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // search icon when press go to search screen
                  IconButton(
                    icon: sharedData
                        .searchIcon, // from Utility class to be easy to change later
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => SearchPage())),
                  ),
                  //menu icon
                  IconButton(
                    icon: sharedData.menuIcon,
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c )=>BalanceScreen())) ;  },
                  ),
                ],
              ),
              getSlider(),
              getList(),
            ],
          ),
        ),
      ),
    );
  }
}
