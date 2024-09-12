import 'package:attendance_app_code/Features/Home/presentation/widgets/employee_attendence_status.dart';
import 'package:attendance_app_code/Features/Home/presentation/widgets/work_details_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Base/common/shared.dart';
import '../../../../Base/utils/styles.dart';

class WorkHoursView extends StatelessWidget {
  const WorkHoursView(
      {super.key,
      required this.color,
      required this.baseText,
      required this.text,
      required this.textColor,
      required this.location,
      required this.checkIn,
      required this.checkOut,
      this.status =0});

  final Color color;
  final String baseText;
  final String text;
  final Color textColor;
  final String location;
  final String checkIn;
  final String checkOut;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
             StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  '${DateFormat('hh:mm a').format(DateTime.now())}',
                  style: Styles.textStyle24.copyWith(color: Colors.white),
                ),
              );
            },
          ),
          Opacity(
            opacity: 0.9,
            child: Text(
              "${DateFormat('EEEE dd MMMM', 'ar').format(DateTime.now())}", //  'الاثنين 01 نوفمبر',
              style: Styles.textStyle14.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          EmployeeAttendenceStatus(status: status),
           SizedBox(
            height: Shared.width * 0.05,
          ),
          location == ''
              ? Container()
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                          opacity: 0.9,
                          child: Container(
                            width: Shared.width * 0.8,
                            child: Text(
                              location,
                              style: Styles.textStyle14
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                          )),
                      const SizedBox(
                        width: 7,
                      ),
                      Image.asset(
                        'assets/images/Vector.png',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
           SizedBox(
            height: Shared.width * 0.05,
          ),
          WorkDetailsView(
            checkIn: checkIn,
            checkOut: checkOut,
          ),
        ],
      ),
    );
  }
}
