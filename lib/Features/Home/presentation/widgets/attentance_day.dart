import 'package:flutter/material.dart';

import '../../../../Base/utils/styles.dart';


class AttendanceDay extends StatelessWidget{
   AttendanceDay({required this.branch_name,required this.appoinment,required this.attendence_time,
     required this.day_number,required this.leave_time,required this.day_name});

  final String branch_name;
  final String appoinment;
  final String attendence_time;
  final String leave_time;
  final String day_number;
  final String day_name;

  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:Directionality(
        textDirection: TextDirection.rtl,
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مواعيد اليوم',
                textAlign: TextAlign.right,
                style: Styles.textStyle16.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.16,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,

                  margin: const EdgeInsets.all(10),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 11),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(branch_name ?? '',style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                              ),),
                              SizedBox(height: 3,),
                              Text(appoinment ?? '',style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 3,),
                              Row(
                                children: [
                                  Text(attendence_time ?? ''),
                                  SizedBox(width: 3,),
                                  Image.asset('assets/images/icon-clock.png'),
                                  SizedBox(width: 16,),
                                  Text(leave_time ?? ''),
                                  SizedBox(width: 3,),
                                  Image.asset('assets/images/iconClockkk.png')
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${day_number ?? ''}' , style: Styles.textStyle28.copyWith(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,

                              ),),
                              Text('${day_name ?? ''}' , style: Styles.textStyle28.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,

                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ));
  }
}