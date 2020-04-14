import 'package:customerapp/models/orderInfo.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyOrdersScreen();
  }
}

class _MyOrdersScreen extends State {
  DateTime selectedDate = DateTime.now();

  Widget getTable() {
    // static object of order to add to the list
    OrderInfo order = new OrderInfo();
    order.date = "30-07-2019";
    order.price = 2.90;
    order.type = "متفرقة";

    //this is a static data, will change later , will filled from the api
    sharedData.listOfColumns.add(order);
    sharedData.listOfColumns.add(order);
    sharedData.listOfColumns.add(order);
    sharedData.listOfColumns.add(order);
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              columnSpacing: 30,
              columns: [
                DataColumn(
                  label: Container(
                    decoration: BoxDecoration(color: sharedData.grayColor12),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.keyboard_arrow_down),
                        Text(
                          'السعر',
                          style: sharedData.tableFieldsTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                DataColumn(
                  label: Row(
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_down),
                      Text(
                        'الصنف',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                    ],
                  ),
                ),
                DataColumn(
                  label: Row(
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_down),
                      Text(
                        'وقت الطلبية',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
              rows: sharedData
                  .listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                  .map(
                ((element) =>
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                          element.price.toString() + 'JD',
                          style: sharedData.tableFieldsTextStyle,
                        )),
                        //Extracting from Map element the value
                        DataCell(Text(
                          element.type,
                          style: sharedData.tableFieldsTextStyle,
                        )),
                        DataCell(Text(
                          element.date,
                          style: sharedData.tableFieldsTextStyle,
                        )),
                      ],
                    )),
              )
                  .toList(),
            )));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 22,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('من تاريخ', style: sharedData.tableFieldsTextStyle,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 130,
                    child: FlatButton(
                      shape: Border.all(color: sharedData.grayColor12,),
                      onPressed: () {_selectDate(context);},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_down , color: Colors.yellow),
                          Text(selectedDate.day.toString() +
                              '-' +
                              selectedDate.month.toString() +
                              '-' +
                              selectedDate.year.toString())
                        ],
                      ),),),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('الى تاريخ', style: sharedData.tableFieldsTextStyle,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 130,
                    child: FlatButton(
                      shape: Border.all(color: sharedData.grayColor12,),
                      onPressed: () {_selectDate(context);},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_down, color: Colors.yellow,),
                          Text(selectedDate.day.toString() +
                              '-' +
                              selectedDate.month.toString() +
                              '-' +
                              selectedDate.year.toString())
                        ],
                      ),),),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('السعر', style: sharedData.tableFieldsTextStyle,),
                SizedBox(width: 25,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 130,
                    child: FlatButton(
                      shape: Border.all(color: sharedData.grayColor12,),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_down, color: Colors.yellow,),
                          Text('')
                        ],
                      ),),),
                ),
              ],),
          ),
          getTable()
        ],
      ),
    );
  }
}
