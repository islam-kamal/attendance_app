import 'dart:async';
import 'package:attendance_app_code/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'Base/common/shared.dart';
import 'Features/Home/presentation/widgets/date_day_view.dart';
import 'Features/Home/presentation/widgets/home_app_bar.dart';
import 'Features/Home/presentation/widgets/work_hours_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";
  String location = "";
  String scanResult = " ";
  String officeCode = " ";

  Color primary = const Color(0xffeef444c);

  @override
  void initState() {
    super.initState();
    _getRecord();
  }


  void _getLocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(User.lat, User.long);

    setState(() {
      location = "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
    });
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snap2['checkIn'];
        checkOut = snap2['checkOut'];
        location = snap2['checkInLocation'];
      });
    } catch(e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
        location = "";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xff0E81CF),
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WorkHoursView(
              color: Color.fromARGB(255, 168, 244, 228),
              baseText: 'حضرت',
              text: 'في الموعد المحدد',
              textColor: Color(0xff01D9AC),
              location: location,
              checkIn: checkIn,
              checkOut: checkOut,
            ),

           Container(
              margin: const EdgeInsets.only(top: 10, bottom: 12),
              width: Shared.width * 0.85,
              child: Builder(
                builder: (context) {
                  GlobalKey<SlideActionState> key = GlobalKey();

                  return SlideAction(
                    text: checkIn == "--/--" ? "Slide to Check In" : "Slide to Check Out",
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    outerColor: Colors.white,
                    innerColor: primary,
                    key: key,
                    height: Shared.width * 0.15,
                    sliderButtonIconSize: Shared.width * 0.04,
                    onSubmit: () async {
                      if(User.lat != 0) {
                        _getLocation();
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("Employee")
                            .where('id', isEqualTo: User.employeeId)
                            .get();
                        DocumentSnapshot snap2 = await FirebaseFirestore.instance
                            .collection("Employee")
                            .doc(snap.docs[0].id)
                            .collection("Record")
                            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                            .get();
                        try {
                          print("4");
                          String checkIn = snap2['checkIn'];
                          print("5");
                          setState(() {
                            checkOut = DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .update({
                            'date': Timestamp.now(),
                            'checkIn': checkIn,
                            'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                            'checkInLocation': location,
                            'status' : 'فى العمل '
                          });
                        } catch (e) {
                          setState(() {
                            checkIn = DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .set({
                            'date': Timestamp.now(),
                            'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                            'checkOut': "--/--",
                            'checkOutLocation': location,
                            'status' : '-'
                          });
                        }
                        key.currentState!.reset();
                      } else {
                        Timer(const Duration(seconds: 3), () async {
                          _getLocation();
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();
                          DocumentSnapshot snap2 = await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .get();
                          try {
                            String checkIn = snap2['checkIn'];
                            setState(() {
                              checkOut = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .update({
                              'date': Timestamp.now(),
                              'checkIn': checkIn,
                              'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                              'checkInLocation': location,
                              'status' : 'فى العمل'
                            });
                          } catch (e) {
                            setState(() {
                              checkIn = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .set({
                              'date': Timestamp.now(),
                              'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                              'checkOut': "--/--",
                              'checkOutLocation': location,
                              'status' : '-'
                            });
                          }
                          key.currentState!.reset();
                        });
                      }
                    },
                  );
                },
              ),
            ),

             DatesDayView(),
          ],
        ),
      )
    );
  }
}
