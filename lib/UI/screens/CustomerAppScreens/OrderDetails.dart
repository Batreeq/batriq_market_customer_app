
import 'package:customerapp/models/ListOfMyOrders.dart';
import 'package:customerapp/models/orderInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget{
  List <OrderDetails> listOfOrdersDetails ;
  String date ;

  OrderDetailsScreen(this.listOfOrdersDetails , this.date);
  @override
  State<StatefulWidget> createState() {
    return _OrderDetails(this.listOfOrdersDetails ,this.date);
  }
}

 class _OrderDetails  extends State {

   OrderDetails orderDetails ;
   String orderDate ;

   List <OrderDetails> listOfOrdersDetails ;

   bool isSelect = false;

  _OrderDetails(this.listOfOrdersDetails , this.orderDate);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedData.appBar(context, 'تفاصيل الطلبية', null, () {}),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 7,),
                    Text('وقت الطلبية ',
                      style: sharedData.textInProfileTextStyle,),
                    SizedBox(width: 15,),
                    Text(orderDate, style: sharedData.tableFieldsTextStyle,),
                  ],
                ),
              ), // order date row
              getTable(),
              Container(
                // height: 30,
                decoration: BoxDecoration(color: Color(0xFFFFD180)),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //   SizedBox(width: 7,),
                    Text('المجموع', style: sharedData.textInProfileTextStyle,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(totalPrice(), style: sharedData.tableFieldsTextStyle,),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  String totalPrice (){

    double totalPrice = 0 ;
    try {
      for (orderDetails in listOfOrdersDetails) {
        totalPrice +=  double.parse(orderDetails.totalPrice  );
      }
    }catch(e){
      print ('error in casting price to int '+e.toString());
      sharedData.flutterToast('error in casting price to int ');
    }
    return totalPrice.toString() ;
  }

  Widget getTable() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              columnSpacing: 30,
              columns: [
                DataColumn(
                  label:  Row(
                      children: <Widget>[
                        Text(
                          'السعر',
                          style: sharedData.tableFieldsTextStyle,
                        ),
                      ],
                    ),
                ),
                DataColumn(
                  label: Row(
                    children: <Widget>[
                      Text(
                        'العدد',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                    ],
                  ),
                ),
                DataColumn(
                  label: Row(
                    children: <Widget>[
                      Text(
                        'الصنف',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
              rows: listOfOrdersDetails // Loops through dataColumnText, each iteration assigning the value to element
                  .map(
                ((element) =>
                    DataRow(
                      selected: isSelected(),
                      cells: <DataCell>[
                        DataCell(Text(
                          element.totalPrice.toString() + 'JD',
                          style: sharedData.tableFieldsTextStyle,
                        )),
                        //Extracting from Map element the value
                        DataCell(Text(
                          element.quantity,
                          style: sharedData.tableFieldsTextStyle,
                        )),
                        DataCell(Text(
                          element.categoryName,
                          style: sharedData.tableFieldsTextStyle,
                        )),
                      ],
                    )),
              )
                  .toList(),
            )));
  }


   bool isSelected() {
     if (isSelect)
       isSelect = false;
     else
       isSelect = true;
     print(isSelect.toString());
     return isSelect;
   }
 }