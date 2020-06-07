import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerapp/Library/carousel_pro/src/carousel_pro.dart';
import 'package:customerapp/UI/wigets/CategoryItemValue.dart';
import 'package:customerapp/UI/wigets/SubCategoryValue.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared_data.dart';

class Home extends StatelessWidget {
  Widget getSlider() {
    return Container(
      height: 182.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        dotColor: Color(0xFFe55039).withOpacity(0.8),
        dotSize: 5.5,
        dotSpacing: 16.0,
        dotBgColor: Colors.transparent,
        showIndicator: true,
        overlayShadow: true,
        overlayShadowColors: Colors.white.withOpacity(0.9),
        overlayShadowSize: 0.9,
        images: buildSlideImages(),
      ),
    );
  }

  List<Widget> buildSlideImages() {
    List<Widget> images = [];
    sharedData.sliderHomeImages.forEach((image) {
      images.add(CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      ));
    });
    return images;
  }

  Widget Categories(context) => Container(
        height: (sharedData.homeBlockcatigoriesData.length *
                MediaQuery.of(context).size.width /
                4) +
            50,
        color: Colors.white,
        child: buildGrideList(context),
      );

  Widget getList(context) {
    return Container(
        height: (sharedData.homeBlockcatigoriesData.length *
                MediaQuery.of(context).size.width /
                4) +
            50,
        width: MediaQuery.of(context).size.width,
        child: Categories(context));
  }

  @override
  Widget build(BuildContext context) {
    appbarBloc.setTitle("الصفحة الرئيسية");

    return SingleChildScrollView(
      child: Container(
        height: (sharedData.homeBlockcatigoriesData.length *
                MediaQuery.of(context).size.width /
                4) +
            258,
        child: Column(
          children: <Widget>[
            getSlider(),
            getList(context),
          ],
        ),
      ),
    );
  }

  Widget buildGrideList(context) {
    return GridView.builder(
    //  physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      itemCount: sharedData.homeBlockcatigoriesData.length,
      itemBuilder: (ctx, i) {
        final catigory = sharedData.homeBlockcatigoriesData[i];
        return Container(
          child: SubCategoryItemValue(
            catigory: catigory,
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2),
        mainAxisSpacing: 10,
      ),
    );
  }
}