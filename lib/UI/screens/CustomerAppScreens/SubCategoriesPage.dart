import 'package:customerapp/DataLayer/tab.dart';
import 'package:customerapp/UI/screens/CustomerAppScreens/products_screen.dart';
import 'package:customerapp/UI/wigets/SubCategoryValue.dart';
import 'package:customerapp/UI/wigets/custom_tab.dart';
import 'package:customerapp/helpers/AppApi.dart';
import 'package:customerapp/models/mainCategoriesModel/Category.dart';
import 'package:customerapp/models/mainCategoriesModel/MainCategroiesModel.dart';
import 'package:customerapp/models/mainCategoriesModel/SubCategory.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubCategoriesPage extends StatefulWidget {
  final offerId;

  SubCategoriesPage({this.offerId});

  @override
  _SubCategoriesPageState createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  final GlobalKey<RefreshIndicatorState> _refresh=
  new GlobalKey<RefreshIndicatorState>();
  var _controllerScrollCarer = ScrollController();
  MainCategroiesModel mainCategoiesResponse=MainCategroiesModel();

  bool doneRQ=false;




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refresh.currentState.show());
  }

  Widget _itemGridView(List<Category> data, context) {
    if (data == null &&!doneRQ)
      return Center(child: Container(
        child: SpinKitPulse(
            duration: Duration(milliseconds: 1000),
            color: sharedData.mainColor,
            size: 70
        ),
        width: 100,
        height: 100,
      ),);
    else if(data == null &&doneRQ)
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
            if(!doneRQ)
              return Center(child: Container(
                child: SpinKitPulse(
                    duration: Duration(milliseconds: 1000),
                    color: sharedData.mainColor,
                    size: 70
                ),
                width: 100,
                height: 100,
              ),);
            else
              return GestureDetector(
                child:SubCategoryItemValue(catigory: data.elementAt(index),offerId: widget.offerId.toString()),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          sharedData.offerBatriq,
          style: TextStyle(fontSize: 15),
        ),
      ),body: RefreshIndicator(
      key: _refresh,
      onRefresh: ()async{

        setState(() {doneRQ=false; });


        var sendToken="";
        if(isRegistered()) sendToken=token;


        var response=await getAllMainCategories(widget.offerId.toString(),sendToken);
        setState(() {doneRQ=true; });
        if(response.statusCode==200){

          setState(() {
            mainCategoiesResponse=response.object;
          });

        }else{

        }


      },child:_itemGridView(mainCategoiesResponse.categories, context) ,
    )
    );
  }
}
