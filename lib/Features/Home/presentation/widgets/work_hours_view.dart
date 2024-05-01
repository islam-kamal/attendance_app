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
      required this.checkOut});

  final Color color;
  final String baseText;
  final String text;
  final Color textColor;
  final String location;
  final String checkIn;
  final String checkOut;

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
            "${DateFormat('EEEE dd MMMM', 'ar').format(DateTime.now())}",//  'الاثنين 01 نوفمبر',
              style: Styles.textStyle14.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: Shared.width * 0.35,
            height: Shared.width * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  color,
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
                  baseText,
                  style: TextStyle(
                    color: textColor
                  ),
                ),
                Text(text),
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          location == '' ? Container() :  Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                    opacity: 0.9,
                    child:  Container(
                      width: Shared.width * 0.7,
                      child: Text(
                        location,
                        style: Styles.textStyle14.copyWith(color: Colors.white),
                        textAlign: TextAlign.end,
                      ),)

                ),
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
          const SizedBox(
            height: 10,
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
