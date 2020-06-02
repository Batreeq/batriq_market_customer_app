import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerapp/DataLayer/tab.dart';

import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart' as cate;
import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart';
import 'package:customerapp/models/mainCategoriesModel/Category.dart';
import 'package:customerapp/models/mainCategoriesModel/SubCategory.dart';

import 'package:customerapp/shared_data.dart';

import 'package:flutter/material.dart';

class SubCategoryItemValue extends StatelessWidget {
  Category catigory;
  String offerId;

  SubCategoryItemValue({this.catigory,this.offerId});


  @override
  Widget build(BuildContext context) {

    void  openProductPage(){
      tabs.clear();
      tabs.add(ProductTab(id: "-1000", name: sharedData.all));
      List<SubCategory> subCategoiesList=catigory.sub_categories;
      subCategoiesList.forEach((item){
        ProductTab tab =ProductTab(id: item.id.toString(), name: item.name.toString());
        tabs.add(tab);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductsScreen(
            offerId: offerId.toString(),
            category: catigory,
          ),
        ),
      );


    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap:(){
          openProductPage();
        }
       /*   Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                offerId: catigory.id.toString(),
              ),
            ),
          );*/
        ,
        child: Container(
          height: 105.0,
          width: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            color: sharedData.mainColor

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
