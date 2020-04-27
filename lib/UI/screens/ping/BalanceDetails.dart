 import 'package:customerapp/models/UserBalance.dart';
import 'package:customerapp/models/orderInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';

class BalanceDetails extends StatefulWidget {
  List <UserPayments>  listOfUserPayment ;


  BalanceDetails(this.listOfUserPayment);

  @override
  State<StatefulWidget> createState() {
    return _BalanceDetails(this.listOfUserPayment);
  }
}

class _BalanceDetails extends State {
  List<UserPayments> listOfUserPayment;

  _BalanceDetails(this.listOfUserPayment);

  @override
  Widget build(BuildContext context) {


    //  listOfUserPayment.add('Rawan ');
    return Scaffold(
      appBar: sharedData.appBar(context, 'كشف الحساب', null, () {}),
      resizeToAvoidBottomInset: false,
      body: getTable(),
    );
  }

  Widget getTable() {
    if (sharedData.listOfUserPayment == null )
    if (sharedData.listOfUserPayment.length == 0)
      return Container();
     // sharedData.listOfUserPayment = new List<UserPayments>();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          columnSpacing: 7,
          dataRowHeight: 50,
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
          sharedData.listOfUserPayment // Loops through dataColumnText, each iteration assigning the value to element
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
        )
    );
  }
}
