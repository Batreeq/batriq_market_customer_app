import 'package:customerapp/UI/screens/ping/HomePage.dart';
import 'package:customerapp/models/searchResult.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;

import '../../../shared_data.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  SearchData searchData = new SearchData();
  List<Products> productsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar<Products>(
          onCancelled: () {
            // on press cancel button
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext c) => HomePagee()));
          },
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          icon: sharedData.searchIcon,
          hintText: sharedData.searchHintText,
          onSearch: search,
          onError: (error) {
            print('search error ' + error.toString());
            return Center(child: Text('No Items Found',
              style: sharedData.textInProfileTextStyle,));
          },
          onItemFound: (Products post, int index) {
            // onItemFound callback in order to return the Widget corresponding to one item of the list ,  and return a ListTile :
            return ListTile(
              title: Text(post.name),
              subtitle: Text(post.price),
            );
          },
        ),
      ),
    );
  }


  // this function called   the user type string and will take the searched String and return a list of Post items generated from the String.
  Future<List<Products>> search(String searchString) async {
    getSearchDataFromAPI(searchString); //.then((val) async {

    if (searchData != null)
      if (searchData.products != null)
        if (searchData.products.length != 0) {
          productsList = searchData.products;
          // here should be the search api to get te result
          await Future.delayed(Duration(seconds: 5));
          return List.generate(searchData.products.length, (int index) {
            return Products(
              name: productsList
                  .elementAt(index)
                  .name,
              id: productsList
                  .elementAt(index)
                  .id,
              categoryId: productsList
                  .elementAt(index)
                  .categoryId,
              size: productsList
                  .elementAt(index)
                  .size,
              createdAt: productsList
                  .elementAt(index)
                  .createdAt,
              detailsImage: productsList
                  .elementAt(index)
                  .detailsImage,
              detailsText: productsList
                  .elementAt(index)
                  .detailsText,
              detailsTitle: productsList
                  .elementAt(index)
                  .detailsTitle,
              image: productsList
                  .elementAt(index)
                  .image,
              notice: productsList
                  .elementAt(index)
                  .notice,
              price: productsList
                  .elementAt(index)
                  .price,
              quantity: productsList
                  .elementAt(index)
                  .quantity,
              updatedAt: productsList
                  .elementAt(index)
                  .updatedAt,

            );
          });
        } else {
          sharedData.flutterToast('List is Empty');
        }
  }

  Future<SearchData> getSearchDataFromAPI(String searchString) async {
    searchString = 'بيض';
    print(searchString);
    if (searchString != '') {
      final response = await Requests.get(
          sharedData.searchUrl + 'name=' + searchString,
          bodyEncoding: RequestBodyEncoding.FormURLEncoded
      );
      print(response.json());
      print(response.statusCode);

      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        // response.raiseForStatus();
        dynamic json = response.json();
        searchData = SearchData.fromJson(json);
        if (searchData.products.length != 0)
          print('name index 0 = ' + searchData.products
              .elementAt(0)
              .name);
        else
          print('list of products is null ');
        //  search(searchString , searchData
        // fillFeilds(info);
        //return sharedData ;
      }
    } else
      print('Search String is null ');
  }
}