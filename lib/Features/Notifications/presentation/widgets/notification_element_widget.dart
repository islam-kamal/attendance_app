import 'package:attendance_app_code/Base/common/shared.dart';
import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class NotificationElementWidget extends StatelessWidget{
  final String header;
  final String description;
  final String timeStamp;
  NotificationElementWidget({required this.header,
    required this.description,required this.timeStamp});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey.shade50,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Container(
        //  height: Shared.height * 0.15,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [

              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: kLightRed,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/images/notification_icon.png"),
                    ),
                  )),

              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(header ?? '',
                            textDirection: TextDirection.rtl,
                            maxLines: 3,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                          Text(description ?? '',
                          textDirection: TextDirection.rtl,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),   maxLines: 3,),
                          Text(" منذ ${generatePeriodString(DateTime.parse(timeStamp),DateTime.now()) ?? ''}  ",
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),   maxLines: 3,),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  String generatePeriodString(DateTime startDate, DateTime endDate) {
    // Handle cases where end date is before start date
    if (endDate.isBefore(startDate)) {
      return "Invalid: End date cannot be before start date.";
    }

    // Calculate difference in years, months, and days
    final int yearDiff = endDate.year - startDate.year;
    final int monthDiff = endDate.month - startDate.month;
    final int dayDiff = endDate.day - startDate.day;
    final int hourdiff = endDate.day - startDate.hour;
    final int minuteDiff = endDate.day - startDate.minute;

    // Build the period string
    String period = "";

    if (yearDiff > 0) {
      period += yearDiff == 1 ? "$yearDiff year " : "$yearDiff years ";
    }

    if (monthDiff > 0) {
      period += monthDiff == 1 ? "$monthDiff month " : "$monthDiff months ";
    }

    if (dayDiff > 0) {
      period += dayDiff == 1 ? "$dayDiff day" : "$dayDiff days";
    }
    if (hourdiff > 0) {
      period += hourdiff == 1 ? "  $hourdiff  " + "ساعة": "   $hourdiff  "+ "ساعة";
    }
    if (minuteDiff > 0) {
      period += minuteDiff == 1 ? "$minuteDiff دقيقة " : "$minuteDiff دقيقة ";
    }
    // Handle cases where no difference is found
    if (period.isEmpty) {
      period = "Same day";
    }

    return period.trim();
  }

}