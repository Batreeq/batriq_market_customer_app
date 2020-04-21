import 'package:flutter/material.dart';

class CategoryItemValue extends StatelessWidget {
  String image, title;
  GestureTapCallback tap;

  CategoryItemValue({
    this.image,
    this.title,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: tap,
        child: Container(
          height: 115.0,
          width: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black.withOpacity(0.25),
            ),
            child: Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Berlin",
                fontSize: 15,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w800,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
