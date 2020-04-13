

import 'package:customerapp/UI/screens/ping/SearchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';

import '../../../shared_data.dart';
import '../../../shared_data.dart';
import '../../../shared_data.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String token;

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
                      shape: GFAvatarShape.standard)),
              Center(
                  child: Text(
                    sharedData.boxesTexts.elementAt(index),
                style: sharedData.optionStyle,
              ))
            ],
          );
        }));
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
                    onPressed: () {},
                  ),
                ],
              ),
              getList(),
            ],
          ),
        ),
      ),
    );
  }
}
