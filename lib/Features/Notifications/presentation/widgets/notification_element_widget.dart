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
      padding: const EdgeInsets.all(5.0),
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
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                          Text(description ?? '',
                          textDirection: TextDirection.rtl,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),   maxLines: 3,),
                          Text("منذ ${generatePeriodString(DateTime.parse(timeStamp)/*DateTime.parse("2024-08-28 00:00:39")*/,DateTime.now())} ",
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

    // Calculate difference in years, months, days, hours, and minutes
     int yearDiff = endDate.year - startDate.year;
     int monthDiff = endDate.month - startDate.month;
     int dayDiff = endDate.day - startDate.day;
     int hourDiff = endDate.hour - startDate.hour;
     int minuteDiff = endDate.minute - startDate.minute;

    // Adjust the monthDiff and yearDiff if dayDiff is negative
    if (dayDiff < 0) {
      monthDiff -= 1;
    }
    // Adjust the monthDiff and yearDiff if monthDiff is negative
    if (monthDiff < 0) {
      monthDiff += 12;
      yearDiff -= 1;
    }

    // Build the period string
    String period = "";

    if (yearDiff > 0) {
      period += yearDiff == 1 ? "$yearDiff عام " : "$yearDiff اعوام ";
    }

    if (monthDiff > 0) {
      period += monthDiff == 1 ? "$monthDiff شهر " : "$monthDiff شهور ";
    }

    // Handle days only if there are days, otherwise skip
    if (dayDiff > 0) {
      period += dayDiff == 1 ? "$dayDiff يوم " : "$dayDiff يوم ";
    } else if (hourDiff > 0) {
      // Handle hours only if there are hours and no days
      period += hourDiff == 1 ? "$hourDiff ساعة " : "$hourDiff ساعات ";
      if (minuteDiff > 0) {
        period += minuteDiff == 1 ? "$minuteDiff دقيقة " : "$minuteDiff دقيقة ";
      }
    }else if(minuteDiff > 0){
      period += minuteDiff == 1 ? "$minuteDiff دقيقة " : "$minuteDiff دقيقة ";

    }
    // Handle cases where no significant difference is found
    if (period.isEmpty) {
      period = "Same day";
    }

    print("period: $period");
    return period.trim();
  }

}