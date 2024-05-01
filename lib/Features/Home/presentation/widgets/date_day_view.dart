import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/Home/presentation/widgets/attentance_day.dart';
import 'package:attendance_app_code/Features/Home/presentation/widgets/times_of_work_list_view.dart';
import 'package:flutter/material.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/utils/styles.dart';



class DatesDayView extends StatefulWidget{
  const DatesDayView({super.key});

  @override
  State<DatesDayView> createState() => _DatesDayViewState();
}

class _DatesDayViewState extends State<DatesDayView> {
  final List<int> daysOfMonth = List.generate(31, (index) => index + 1);
 int? selected_day ;
@override
  void initState() {
    selected_day  = daysOfMonth[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.3 ,

      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child:  Container(
                  height: Shared.width * 0.15,

                   child: ListView.builder(
                      itemCount: daysOfMonth.length,
                      shrinkWrap: true,

                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: InkWell(
                              onTap: (){
                                setState(() {
                                  selected_day = daysOfMonth[index];
                                });
                              },
                              child: Container(

                                width: MediaQuery.of(context).size.width * 0.21,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: selected_day == index+1 ? kGreenColor :  Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(11),
                                  color: selected_day == index+1 ? kGreenColor : Colors.white,
                                ),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${daysOfMonth[index].toString()}',style: Styles.textStyle24,),
                                      Text('Sun',style: Styles.textStyle16,),
                                    ],
                                  ),
                                ),

                              ))



                        );
                      }),
                ),
              ),

            AttendanceDay(
              branch_name: "مكتب مدينة نصر",
              appoinment: "الاحد و الاثنين",
              attendence_time: "8:00",
              leave_time: "5:00",
              day_number: selected_day.toString(),
              day_name:  "SUN",
             ),
          ],
        ),
      ),
    );
  }
}




