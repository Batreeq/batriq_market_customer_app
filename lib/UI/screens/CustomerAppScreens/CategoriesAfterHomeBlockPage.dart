import 'package:customerapp/DataLayer/tab.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart';
import 'package:customerapp/UI/wigets/AfterHomeBlockItemValue.dart';
import 'package:customerapp/UI/wigets/SubCategoryValue.dart';
import 'package:customerapp/UI/wigets/custom_tab.dart';
import 'package:customerapp/helpers/AppApi.dart';
import 'package:customerapp/models/homeBlocks/CategoryHomeBlocks.dart';
import 'package:customerapp/models/homeBlocks/HomeBlocksModel.dart';
import 'package:customerapp/models/mainCategoriesModel/Category.dart';
import 'package:customerapp/models/mainCategoriesModel/MainCategroiesModel.dart';
import 'package:customerapp/models/mainCategoriesModel/SubCategory.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoriesAfterHomeBlockPage extends StatefulWidget {
  final HomeBlocksModel homeBlock;

  CategoriesAfterHomeBlockPage({this.homeBlock});

  @override
  _SubCategoriesPageState createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<CategoriesAfterHomeBlockPage> {
  final GlobalKey<RefreshIndicatorState> _refresh=
  new GlobalKey<RefreshIndicatorState>();
  var _controllerScrollCarer = ScrollController();
  MainCategroiesModel mainCategoiesResponse=MainCategroiesModel();

  bool doneRQ=false;




  @override
  void initState() {
    super.initState();
/*    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refresh.currentState.show());*/
  }

  Widget _itemGridView(List<CategoryHomeBlocks> data, context) {
  if(data == null)
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  sharedData.tryLater,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
    else if ( data!=null &&data.length > 0)
      return GridView.builder(
          controller: _controllerScrollCarer,
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
                child:AfterHomeBlockItemValue(catigory:data[index],),
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
                   sharedData.noData,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          sharedData.offerBatriq,
          style: TextStyle(fontSize: 15),
        ),
      ),body: SafeArea(child: _itemGridView(widget.homeBlock.categories, context))
    );
  }
}
