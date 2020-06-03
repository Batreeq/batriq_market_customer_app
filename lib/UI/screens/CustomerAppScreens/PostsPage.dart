import 'package:customerapp/UI/wigets/PostItemValue.dart';

import 'package:flutter/material.dart';



import 'package:customerapp/shared_data.dart';
import 'package:customerapp/models/PostsModel.dart';



class PostsPage extends StatelessWidget {

  Widget _itemGridView(List<PostsModel> data, context) {

     if(data == null)
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  'حاول لاحقا ',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
    else if ( data!=null &&data.length > 0)
      return GridView.builder(

          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: EdgeInsets.only(
              left: 16,
              right:16,bottom: 60),
          itemBuilder: (context, index) {

              return GestureDetector(
                child:PostItemValue(item: data.elementAt(index)),
                onTap: () {},
              );
          });
    else
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  'لايوجد بيانات  ',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    appbarBloc.setTitle(sharedData.posts);
    return _itemGridView(postsList,context);
  }
}
