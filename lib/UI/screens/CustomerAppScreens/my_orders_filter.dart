import 'package:customerapp/DataLayer/Cart.dart';
import 'package:customerapp/shared_data.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrdersFilter extends StatefulWidget {
  List<CartToAdd> orders;
  String title;
  int state;
  MyOrdersFilter({this.orders, this.title});

  @override
  _MyOrdersFilterState createState() => _MyOrdersFilterState();
}

class _MyOrdersFilterState extends State<MyOrdersFilter> {
  List<CartToAdd> filteredList;
  @override
  Widget build(BuildContext context) {
    filterList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: sharedData.appBar(context, widget.title, null, () {}),
      body: buildList(),
    );
  }

  buildList() {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return buildFilter();
        } else if (i == 1) {
          CartToAdd cart = CartToAdd(
              quantity: "الكمية",
              title: "الاسم",
              price: "السعر",
              date: "التاريخ");
          return buildProductItem(i, cart);
        } else {
          return buildProductItem(i, filteredList[i - 2]);
        }
      },
      itemCount: filteredList.length + 2,
    );
  }

  buildProductItem(int i, CartToAdd cart) {
    return Container(
      height: i == 1 ? 40 : 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: i == 1 ? sharedData.mainColor : Colors.white,
        border: Border(
            top: BorderSide(width: 0.25, color: Colors.lightBlue.shade600),
            bottom: BorderSide(
              width: 0.25,
            ),
            right: BorderSide(width: 0.5, color: Colors.lightBlue.shade600),
            left: BorderSide(width: 0.5, color: Colors.lightBlue.shade600)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                cart.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                cart.quantity,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                cart.price,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                cart.date,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  List names = [];
  List dates = [];
  List titles = [];
  List datess = [];
  List fake = ['hey'];
  getNamesAndDates() {
    names = [];
    names.add({
      "display": "الكل",
      "value": "الكل",
    });
    dates.add({
      "display": "الكل",
      "value": "الكل",
    });
    widget.orders.forEach((item) {
      if (!titles.contains(item.title)) {
        names.add({
          "display": item.title,
          "value": item.title,
        });
      }
      titles.add(item.title);
      if (!datess.contains(item.date)) {
        dates.add({
          "display": item.date,
          "value": item.date,
        });
      }
      datess.add(item.date);
    });
  }

  String selectedName = "الكل";
  String selectedDate = "الكل";

  Widget buildFilter() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 100 ,
      child: Row(
        children: <Widget>[
          Flexible(
            child: DropDownFormField(
              titleText: 'اختر الاسم',
              hintText: '',
              value: selectedName,
              onSaved: (value) {
//          setState(() {
//            selectedRegion = value;
//          });
              },
              onChanged: (value) {
                setState(() {
                  selectedName = value;
//            getRegionsByCityName(selectedCity);
                });
              },
              dataSource: names,
              textField: 'display',
              valueField: 'value',
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: DropDownFormField(
              titleText: ' اختر التاريخ',
              hintText: '',
              value: selectedDate,
              onSaved: (value) {
//          setState(() {
//            selectedRegion = value;
//          });
              },
              onChanged: (value) {
                setState(() {
                  selectedDate = value;
//            getRegionsByCityName(selectedCity);
                });
              },
              dataSource: dates,
              textField: 'display',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  filterList() {
    print(selectedName);
    if (selectedName != "الكل" && selectedDate == "الكل") {
      filteredList =
          widget.orders.where((order) => order.title == selectedName).toList();
    } else if (selectedDate == "الكل" && selectedName == "الكل") {
      filteredList = widget.orders;
    } else if (selectedName == "الكل" && selectedDate != "الكل") {
      filteredList =
          widget.orders.where((order) => order.date == selectedDate).toList();
    } else {
      filteredList = widget.orders
          .where((order) =>
              order.date == selectedDate && order.title == selectedName)
          .toList();
    }

    print("filtered :  $filteredList");
  }

  @override
  void initState() {
    super.initState();
    getNamesAndDates();
  }
}
