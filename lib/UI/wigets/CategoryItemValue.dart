import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryItemValue extends StatelessWidget {
  Catigory catigory;
  CategoryItemValue({this.catigory});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                offerId: catigory.id,
              ),
            ),
          );
        },
        child: Container(
          height: 105.0,
          width: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            image: DecorationImage(
                image: CachedNetworkImageProvider(catigory.image),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              color: Colors.black.withOpacity(0.25),
            ),
            child: Center(
                child: Text(
              catigory.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.5,
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
