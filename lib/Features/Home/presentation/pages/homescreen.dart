import 'package:attendance_app_code/Features/Notifications/presentation/pages/notifications_screen.dart';
import 'package:attendance_app_code/calendarscreen.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:attendance_app_code/profilescreen.dart';
import 'package:attendance_app_code/services/employee_schedule_screen.dart';
import 'package:attendance_app_code/services/location_service.dart';
import 'package:attendance_app_code/todayscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    _startLocationService();
    getId().then((value) {
      _getCredentials();
    });
  }

  void _getCredentials() async {
    try {
      print("_getCredentials User.id : ${User.id}");
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Employee").doc(User.id).get();
      print("_doc['firstName'] : ${doc['firstName']}");
      setState(() {
        User.canEdit = doc['canEdit'];
        User.firstName = doc['firstName'];
        User.lastName = doc['lastName'];
        User.birthDate = doc['birthDate'];
        User.address = doc['address'];
      });
    } catch(e) {
      return;
    }
  }


  void _startLocationService() async {
    LocationService().initialize();

    LocationService().getLongitude().then((value) {
      setState(() {
        User.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          User.lat = value!;
        });
      });
    });
  }

  Future<void> getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: new HomeView()
    );
  }
}
