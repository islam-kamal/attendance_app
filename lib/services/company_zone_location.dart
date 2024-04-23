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
