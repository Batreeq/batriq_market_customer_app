import 'package:flutter/cupertino.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/models/UserPayments.dart';

class BalanceDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BalanceDetails();
  }
}

class _BalanceDetails extends State {
  bool isSelect = false;
  bool isAscending = true;
  List<UserPayments> list = new List<UserPayments>();
  UserPayments userPayments = new UserPayments();
  @override
  void initState() {
    super.initState();
  }

  bool isSelected() {
    if (isSelect)
      isSelect = false;
    else
      isSelect = true;
    print(isSelect.toString());
    return isSelect;
  }

  sortAscending() {
    if (isAscending)
      isAscending = false;
    else
      isAscending = true;
    print(isAscending.toString());
    return isAscending;
  }

  @override
  Widget build(BuildContext context) {
    list = sharedData.listOfUserPayment;
    if (list == null || list.length == 0) list.add(userPayments);
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
        child: Align(
          alignment: Alignment.topCenter,
          child: DataTable(
            sortAscending: sortAscending(),
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
                      ((element) => DataRow(
                            selected: isSelected(),
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
        ));
  }
}
