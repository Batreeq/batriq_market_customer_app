import 'package:customerapp/models/Employee.dart';
import 'package:customerapp/models/UserBalance.dart';
import 'package:customerapp/models/orderInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';

class PrepareForEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrepareForEmployee();
  }
}

class _PrepareForEmployee extends State {

  bool isSelect = false;

  bool isAscending = true;

  List<EmployeeInfo> list = new List<EmployeeInfo> ();
  EmployeeInfo employee  = new EmployeeInfo();

  String orderNo ;
  String stopPointNumber ;

  @override
  void initState() {
    super.initState();
    orderNo = sharedData.orderNo == null ? '' : sharedData.orderNo  ;
    stopPointNumber = sharedData.stopPointNumber == null ? '' : sharedData.stopPointNumber  ;
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
    list = sharedData.listEmployeeInfo;

    employee.name = 'Ola  ';
    employee.number = '20';
    employee.id = '220';
    employee.address = 'Canada';

    if (list == null || list.length == 0)
      list.add(employee);

    return Scaffold(
      appBar: sharedData.appBar(context, 'جهز للموظف/طلبية رقم $orderNo', null, () {}),
      resizeToAvoidBottomInset: false,
      body: getBody(),
    );
  }

  Widget getBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('نقطة التوقف رقم $stopPointNumber '),
        ),
        getTable()
      ],
    );
  }
  Widget getTable() {
    return Padding(
        padding: const EdgeInsets.only(top :8.0 , right: 2 ,left: 2 , bottom: 8),
        child: Align(
          alignment: Alignment.topCenter,
          child: DataTable(
            sortAscending: sortAscending(),
            columnSpacing: 13,
            columns: [
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'اسم الزبون',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),

              ),
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'عدد الكيس',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'رقم الكيس',
                      style: sharedData.tableFieldsTextStyle,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: <Widget>[
                    Text(
                      'عنوان الزبون',
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
                    selected: isSelected(),
                    cells: <DataCell>[
                      DataCell(Text(
                        element.name,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                      //Extracting from Map element the value
                      DataCell(Text(
                        element.number,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                      DataCell(Text(
                        element.id,
                        style: sharedData.tableFieldsTextStyle,
                      )),
                      DataCell(Text(
                        element.address,
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