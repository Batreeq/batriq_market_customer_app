import 'package:cached_network_image/cached_network_image.dart';
import 'package:customerapp/DataLayer/Catigory.dart';
import 'package:customerapp/DataLayer/Product.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/SubCategoriesPage.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/product_detail_screen.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart';
import 'package:customerapp/models/ProductDetailsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/models/PostsModel.dart';

class PostItemValue extends StatelessWidget {
  PostsModel item;

  PostItemValue({this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            ProductDetailsModel productDetails = item.product_details;
            Product product = Product(
                title: productDetails.name,
                image: productDetails.image,
                price: productDetails.price,
                size: productDetails.size,
                catigory: null,
                id: productDetails.id.toString(),
                is_offer: false,
                is_package: false);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProductDetailsScreen(
                      product: product,
                    )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                item.text.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,


                ),
              ),
              Container(

                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(item.image),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*ProductsScreen*/
