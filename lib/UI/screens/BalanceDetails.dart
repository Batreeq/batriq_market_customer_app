 import 'package:customerapp/models/UserBalance.dart';
import 'package:customerapp/models/orderInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';

class BalanceDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BalanceDetails();
  }
}

class _BalanceDetails extends State {
  List<UserPayments> list;
  UserPayments userPayments ;

  @override
  void initState() {
    super.initState();
    list = new List<UserPayments> ();
    userPayments = new UserPayments();
    list = sharedData.listOfUserPayment ;
    if (list == null || list.length == 0 )
      list.add(userPayments);
  }

  @override
  Widget build(BuildContext context) {
    list = new List<UserPayments>();
    //  list.add('Rawan ');
    return Scaffold(
      appBar: sharedData.appBar(context, 'كشف الحساب', null, () {}),
      resizeToAvoidBottomInset: false,
      body: getTable(),
    );
  }

  Widget getTable() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:Align(
          alignment: Alignment.topCenter,
          child:  DataTable(
            columnSpacing: 18,
            columns: [
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'رصيد',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),

              ),
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'دائن مدين+',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'تفاصيل',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'التاريخ',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),
              ),
            ],
            rows:
            list // Loops through dataColumnText, each iteration assigning the value to element
                .map(
              ((element) =>
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        element.totalBalance,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                      //Extracting from Map element the value
                      DataCell(Text(
                        element.creditDebt,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                      DataCell(Text(
                      element.details,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                      DataCell(Text(
                      element.createdDate,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                    ],
                  )),
            )
                .toList(),
          ),
        )
    );
  }
}
