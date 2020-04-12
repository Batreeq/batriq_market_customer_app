
import 'package:customerapp/UI/screens/ping/HomePage.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared_data.dart';
import '../../../shared_data.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // this function called   the user type string and will take the searched String and return a list of Post items generated from the String.
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar<Post>(
          onCancelled: () {
            // on press cancel button
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext c) => HomePagee()));
          },
          icon: sharedData.searchIcon,
          hintText: sharedData.searchHintText,
          onSearch: search,
          onItemFound: (Post post, int index) {
            // onItemFound callback in order to return the Widget corresponding to one item of the list ,  and return a ListTile :
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.description),
            );
          },
        ),
      ),
    );
  }
}

// the result get after search
class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}
