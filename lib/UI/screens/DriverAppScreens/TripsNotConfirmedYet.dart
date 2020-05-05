import 'dart:math';
import 'package:customerapp/models/ListOfMyOrders.dart';
import 'package:customerapp/models/Trip.dart';
import 'package:customerapp/models/orderInfo.dart';
import 'package:customerapp/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class TripsNotConfirmedYet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TripsNotConfirmedYet();
  }
}

class _TripsNotConfirmedYet extends State {

  List <Trip> trips ;
  Trip trip ;
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
  }

  @override
  Widget build(BuildContext context) {

    trips = new List<Trip>();
    trip = new Trip ();
    trip.number = '103' ;
    trip.startTime= '10:15';
    trip.expectedTime = '2:16';
    trip.goingPoint = 'Irbid' ;
    trips.add(trip);
    trips.add(trip);

    return Scaffold(
      appBar: sharedData.appBar(context, 'جولات قيد التأكيد ', null, () {}),
      body: getBody()
    );
  }

  Widget getTable() {
    return trips != null ?
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              columnSpacing: 18,
              columns: [
                DataColumn(
                  label:  Text(
                        'نقطة الانطلاق',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                ),
                DataColumn(
                  label:
                      Text(
                        'الوقت المتوقع',
                        style: sharedData.tableFieldsTextStyle,
                      ),

                ),
                DataColumn(
                  label:
                      Text(
                        'وقت البدء',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                ),
                DataColumn(
                  label:
                      Text(
                        'الرقم',
                        style: sharedData.tableFieldsTextStyle,
                      ),
                ),
              ],
              rows: // Loops through dataColumnText, each iteration assigning the value to element
              trips
                  .map((element) {
                //Extracting from Map element the value
                return
                  DataRow(
                    selected: isSelected(),
                    cells: <DataCell>[
                      DataCell(
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on , color: sharedData.yellow,),
                              Text(
                                element.goingPoint,
                                style: sharedData.tableFieldsTextStyle,
                              ),
                            ],
                          ),
                          onTap: () {
                          }),
                      DataCell(
                          Text(
                            element.expectedTime,
                            style: sharedData.tableFieldsTextStyle,
                          ),
                          onTap: () {
                          }),
                      DataCell(
                          Text(
                            element.startTime,
                            style: sharedData.tableFieldsTextStyle,
                          ),
                          onTap: () {
                          }),
                      DataCell(
                          Text(
                            element.number,
                            style: sharedData.tableFieldsTextStyle,
                          ),
                          onTap: () {
                          }),
                    ],
                  );
              }
              )
                  .toList(),
            )
        )
            : Container();
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        SizedBox(height: 50,),
        getTable(),
      ],
    );
  }
}