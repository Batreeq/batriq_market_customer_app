import 'package:customerapp/Library/carousel_pro/src/carousel_pro.dart';
import 'package:customerapp/UI/wigets/CategoryItemValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        images: [
          AssetImage("assets/images/baner1.png"),
          AssetImage("assets/images/baner12.png"),
          AssetImage("assets/images/baner2.png"),
          AssetImage("assets/images/baner3.png"),
          AssetImage("assets/images/baner4.png"),
        ],
      ),
    );
  }

  var categoryImageBottom = Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CategoryItemValue(
                    image: "assets/images/category2.png",
                    title: "عروض بطريق",
                    tap: () {},
                  ),
                  CategoryItemValue(
                    image: "assets/images/category1.png",
                    title: "عروض خاصة لاسم المستخدم",
                    tap: () {},
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  CategoryItemValue(
                    image: "assets/images/category3.png",
                    title: "عروض لمرة واحدة",
                    tap: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  CategoryItemValue(
                    image: "assets/images/category4.png",
                    title: "عروض أصنافي",
                    tap: () {},
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  CategoryItemValue(
                    image: "assets/images/category5.png",
                    title: "مجمدات",
                    tap: () {},
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
            ],
          ),
        )
      ],
    ),
  );
  Widget getList() {
    return Container(height: 620, child: categoryImageBottom);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getSlider(),
          getList(),
        ],
      ),
    );
  }
}
