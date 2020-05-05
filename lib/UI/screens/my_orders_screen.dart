import 'dart:math';
import 'package:customerapp/models/ListOfMyOrders.dart';
import 'package:customerapp/models/orderInfo.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'OrderDetails.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyOrdersScreen();
  }
}

class _MyOrdersScreen extends State {
  String token = '';
  DateTime selectedDate = DateTime.now();
  DateTime oldTime;
  String price = "";
  ListOfMyOrders listOfMyOrders;
  List<Orders> wholeList;
  Orders orders = new Orders();
  bool isSelect = false;
  bool isSelected() {
    if (isSelect)
      isSelect = false;
    else
      isSelect = true;
    print(isSelect.toString());
    return isSelect;
  }

  @override
  void initState() {
    super.initState();
    oldTime = new DateTime.utc(2020, 1, 1, 12);
    listOfMyOrders = new ListOfMyOrders();
    listOfMyOrders.orders = new List<Orders>();
    sharedData.readFromStorage(key: 'token').then((tokn) {
      getUserOrders(tokn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedData.appBar(context, 'طلبياتي ', null, () {}),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    'من تاريخ',
                    style: sharedData.tableFieldsTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 130,
                      child: FlatButton(
                        shape: Border.all(
                          color: sharedData.grayColor12,
                        ),
                        onPressed: () {
                          _selectDate(context, 'from');
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.keyboard_arrow_down,
                                color: sharedData.yellow),
                            Text(oldTime.day.toString() +
                                '-' +
                                oldTime.month.toString() +
                                '-' +
                                oldTime.year.toString())
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    'الى تاريخ',
                    style: sharedData.tableFieldsTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 130,
                      child: FlatButton(
                        shape: Border.all(
                          color: sharedData.grayColor12,
                        ),
                        onPressed: () {
                          _selectDate(context, 'to');
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: sharedData.yellow,
                            ),
                            Text(selectedDate.day.toString() +
                                '-' +
                                selectedDate.month.toString() +
                                '-' +
                                selectedDate.year.toString())
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    'السعر',
                    style: sharedData.tableFieldsTextStyle,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      child: new Container(
                          child: new TextField(
                        onChanged: (v) {
                          price = v;
                          filteredOrders(
                              wholeList, oldTime, selectedDate, price);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'السعر'),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            getTable()
          ],
        ),
      ),
    );
  }

  Widget getTable() {
    return Center(
        child: listOfMyOrders.orders != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  columnSpacing: 20,
                  columns: [
                    DataColumn(
                      label: Row(
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_down),
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
                  rows: // Loops through dataColumnText, each iteration assigning the value to element

                      listOfMyOrders.orders.map((element) {
                    //Extracting from Map element the value
                    List<String> dateSplit = element.createdAt.split('-');
                    return DataRow(
                      selected: isSelected(),
                      cells: <DataCell>[
                        DataCell(
                            Text(
                              element.totalPrice.toString() + 'JD',
                              style: sharedData.tableFieldsTextStyle,
                            ), onTap: () {
                          goToOrderDetails(
                              element.orderDetails, element.createdDate);
                        }),
                        DataCell(
                            Text(
                              'متفرقة',
                              style: sharedData.tableFieldsTextStyle,
                            ), onTap: () {
                          goToOrderDetails(
                              element.orderDetails, element.createdDate);
                        }),
                        DataCell(
                            Text(
                              element.createdDate,
                              style: sharedData.tableFieldsTextStyle,
                            ), onTap: () {
                          goToOrderDetails(
                            element.orderDetails,
                            element.createdDate,
                          );
                        }),
                      ],
                    );
                  }).toList(),
                ))
            : Container());
  }

  goToOrderDetails(List<OrderDetails> listOfOrdersDetails, String date) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext c) =>
                OrderDetailsScreen(listOfOrdersDetails, date)));
  }

  Future<Null> _selectDate(BuildContext context, String type) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: type == 'from ' ? selectedDate : oldTime,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101, 12));
    if (type == 'from') if (picked != null && picked != oldTime)
      setState(() {
        oldTime = picked;
      });
    else if (type == 'to') if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    filteredOrders(wholeList, oldTime, selectedDate, price);
  }

  void getUserOrders(String token) async {
    print('token in before do get orders request $token');
    sharedData.showLoadingDialog(context);
    if (token != '') {
      final response = await Requests.post(sharedData.myOrdersUrl,
          body: {'api_token': token},
          bodyEncoding: RequestBodyEncoding.FormURLEncoded);

      if (response.statusCode == 200) {
        response.raiseForStatus();
        dynamic json = response.json();
        setState(() {
          listOfMyOrders = ListOfMyOrders.fromJson(json);
        });
        wholeList = listOfMyOrders.orders;
        if (listOfMyOrders.orders.length != 0)
          print('delivary time index 0 = ' +
              listOfMyOrders.orders.elementAt(0).deliveryTime);
        else
          print('list of products is null ');

        Navigator.of(context).pop(); //close the dialog
      } else
        sharedData.flutterToast(
            'Some thing went wrong in getting your orders, please try again ' +
                response.statusCode);
    } else
      print('token is null in my orders method is null ');
  }

  filteredOrders(
      List<Orders> orders, DateTime start, DateTime end, String price) {
    List<Orders> filteredOrders = [];
    orders.forEach((order) {
      var orderDate = DateTime.parse(order.createdAt);
      print(orderDate);
      if (orderDate.isAfter(start) &&
          orderDate.isBefore(end) &&
          ((price.trim().length > 0 && price == order.totalPrice.trim()) ||
              price == "")) {
        filteredOrders.add(order);
      }
    });

    setState(() {
      listOfMyOrders.orders = filteredOrders;
    });
  }
}
