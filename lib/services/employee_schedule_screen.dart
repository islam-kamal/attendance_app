/*
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LocationCheckScreen extends StatefulWidget {
  @override
  _LocationCheckScreenState createState() => _LocationCheckScreenState();
}

class _LocationCheckScreenState extends State<LocationCheckScreen> {
  final companyLatitude = 29.9738252; // Example latitude of company location
  final companyLongitude = 31.2478788; // Example longitude of company location
  final distanceThreshold = 10000; // Example distance threshold in meters

  String locationStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    checkLocation();
  }

  Future<void> checkLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double distanceInMeters = await Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      companyLatitude,
      companyLongitude,
    );

    setState(() {
      if (distanceInMeters <= distanceThreshold) {
        locationStatus = 'You are within the company zone';
      } else {
        locationStatus = 'You are outside the company zone';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Check'),
      ),
      body: Center(
        child: Text(
          locationStatus,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
*/

import 'dart:async';

import 'package:attendance_app_code/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class EmployeeScheduleScreen extends StatefulWidget {
  const EmployeeScheduleScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScheduleScreenState createState() => _EmployeeScheduleScreenState();
}
class _EmployeeScheduleScreenState extends State<EmployeeScheduleScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);

  String _month = DateFormat('MMMM').format(DateTime.now());
  Stream<QuerySnapshot<Object?>>? employee_schedule_stream;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      employee_schedule_stream = FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .collection("employee_schedule")
          .snapshots();
    });

  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Employee Schedule",
          style: TextStyle(
              fontFamily: "NexaBold",
              fontSize: screenWidth / 18,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight / 1.45,
              child: StreamBuilder<QuerySnapshot>(
                stream: employee_schedule_stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    print("snap : ${snap}");
                  if(snap.isNotEmpty){
                    return  ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text('Day'),
                                  ),
                                  DataColumn(
                                    label: Text('Branch'),
                                  ),
                                  DataColumn(
                                    label: Text('Address'),
                                  ),
                                  DataColumn(
                                    label: Text('Times of Work'),
                                  ),
                                ],
                                columnSpacing: screenWidth / 25,
                                sortAscending: true,

                                rows: [
                                  DataRow(

                                    cells: [
                                      DataCell(Container(
                                          width: screenWidth / 6,
                                          child: Text(snap[index]['day']))),
                                      DataCell(Container(
                                          width: screenWidth / 6,
                                          child:
                                          Text(snap[index]['branchName']))),
                                      DataCell(Container(
                                          width: screenWidth / 5,
                                          child: Text(
                                            snap[index]['address']['name'],
                                          ))),
                                      DataCell(Container(
                                        width: screenWidth / 4,
                                        child: Text(snap[index]['timesOfWork']
                                        ['open'] +
                                            '/' +
                                            snap[index]['timesOfWork']['close']),
                                      )),
                                    ],
                                  )
                                ]));
                      },
                    );
                  }else{
                    return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: screenWidth / 2),
                          child: const Text(
                            "There Is No Data",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ));
                  }
                  } else {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth / 2),
                      child: const Text(
                        "There Is No Data",
                        style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ));
                  }
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
