/*
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';

class EmployeeAttendenceStatus extends StatelessWidget {
  final int status;
  EmployeeAttendenceStatus({required this.status});
  @override
  Widget build(BuildContext context) {
    return emp_status(status: status);
  }

  Widget emp_status({int? status}) {
    switch (status) {
      case 0: // when employee attend to work on time
        return Container(
          width: Shared.width * 0.35,
          height: Shared.width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 168, 244, 228),
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                'حضرت',
                style: TextStyle(
                    color: kGreenColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'في الموعد المحدد',
              ),
            ],
          ),
        );
        break;
      case 1: // before employee attend to work
        return Container(
          width: 135,
          height: 138,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                kWhiteColor,
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                ' متبقي ${calculateTimeToWorkBegin()}',
                style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(' علي موعد الحضور'),
            ],
          ),
        );
        break;
      case 2: // when employee attend to work later
        return Container(
          width: 135,
          height: 138,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 226, 113, 113),
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                'تأخير',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'عن الموعد المحدد',
              ),
            ],
          ),
        );
        break;
      default: // before employee attend to work
        return Container(
          width: 135,
          height: 138,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                kWhiteColor,
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                ' متبقي ${calculateTimeToWorkBegin()}',
                style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(' علي موعد الحضور'),
            ],
          ),
        );
    }
  }


  String calculateTimeToWorkBegin() {

    sharedPreferenceManager.readString(CachingKey.START_TIME).then((value) {
      DateTime now = DateTime.now();
      // Parse the time string
      DateFormat timeFormat = DateFormat.jm(); // "jm" is for parsing "9:00 AM" format
      DateTime parsedTime = timeFormat.parse(value);
      // Combine today's date with the parsed time
      DateTime todayWithTime = DateTime(
        now.year,
        now.month,
        now.day,
        parsedTime.hour,
        parsedTime.minute,
      );
      // Calculate the difference
      print("now : ${now}");
      print("todayWithTime : ${todayWithTime}");
      Duration difference = todayWithTime.difference(now);
      // Extract the difference in days, hours, minutes, and seconds
      int days = difference.inDays;
      int hours = difference.inHours.remainder(24);
      int minutes = difference.inMinutes.remainder(60);
      int seconds = difference.inSeconds.remainder(60);

      print("Difference: $days days, $hours hours, $minutes minutes, $seconds seconds");
      return formatTime(hours , minutes );
    });

  }

  String formatTime(int hour, int minute) {
    // Use the padLeft method to add a leading zero if needed
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return "$formattedHour:$formattedMinute";
  }
}
*/

import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';

class EmployeeAttendenceStatus extends StatelessWidget {
  final int status;
  EmployeeAttendenceStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    return emp_status(status: status);
  }

  Widget emp_status({int? status}) {
    switch (status) {
      case 0: // when employee attends work on time
        return statusContainer(
          backgroundColors: [Color.fromARGB(255, 168, 244, 228), Color(0xffFFFFFF)],
          textColor: kGreenColor,
          mainText: 'حضرت',
          subText: 'في الموعد المحدد',
        );
      case 1: // before employee attends work
        return FutureBuilder<String>(
          future: calculateTimeToWorkBegin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // or any placeholder you prefer
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return statusContainer(
                backgroundColors: [kWhiteColor, Color(0xffFFFFFF)],
                textColor: kBlackColor,
                mainText: 'متبقي ${snapshot.data}',
                subText: 'علي موعد الحضور',
              );
            }
          },
        );
      case 2: // when employee attends work late
        return statusContainer(
          backgroundColors: [Color.fromARGB(255, 226, 113, 113), Color(0xffFFFFFF)],
          textColor: kRedColor,
          mainText: 'تأخير',
          subText: 'عن الموعد المحدد',
        );
      default: // before employee attends work (default case)
        return FutureBuilder<String>(
          future: calculateTimeToWorkBegin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // or any placeholder you prefer
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return statusContainer(
                backgroundColors: [kWhiteColor, Color(0xffFFFFFF)],
                textColor: kBlackColor,
                mainText: 'متبقي ${snapshot.data}',
                subText: 'علي موعد الحضور',
              );
            }
          },
        );
    }
  }

  Widget statusContainer({
    required List<Color> backgroundColors,
    required Color textColor,
    required String mainText,
    required String subText,
  }) {
    return Container(
      width: Shared.width * 0.35,
      height: Shared.width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: backgroundColors,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/3dicons.png'),
          Text(
            mainText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(subText),
        ],
      ),
    );
  }

  Future<String> calculateTimeToWorkBegin() async {
    String startTime = await sharedPreferenceManager.readString(CachingKey.START_TIME);
    DateTime now = DateTime.now();

    // Parse the time string
    DateFormat timeFormat = DateFormat.Hms(); // "jm" is for parsing "9:00 AM" format
    print("startTime : ${startTime}");
    DateTime parsedTime = timeFormat.parse(startTime);

    // Combine today's date with the parsed time
    DateTime todayWithTime = DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    // Calculate the difference
    Duration difference = now.difference(todayWithTime);

    // Extract the difference in hours and minutes
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);
    print("hours : ${hours}");
    print("minutes : ${minutes}");
    return formatTime(hours, minutes);
  }

  String formatTime(int hour, int minute) {
    // Use the padLeft method to add a leading zero if needed
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return "$formattedHour:$formattedMinute";
  }
}
