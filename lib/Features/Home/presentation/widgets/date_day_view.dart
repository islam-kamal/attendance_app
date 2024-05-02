import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/Home/presentation/widgets/attentance_day.dart';
import 'package:flutter/material.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/utils/styles.dart';

class DatesDayView extends StatefulWidget {
  const DatesDayView({super.key});

  @override
  State<DatesDayView> createState() => _DatesDayViewState();
}

class _DatesDayViewState extends State<DatesDayView> {
  DateTime now = DateTime.now();
  int? selected_day;

  @override
  void initState() {
    selected_day = Shared.generateMonthDayNames(now)[0].number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: Shared.width * 0.18,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: Shared.generateMonthDayNames(now).length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              selected_day = Shared.generateMonthDayNames(now)[index].number;
                              Shared.task_selected_date = Shared.generateMonthDayNames(now)[index].date;
                            });

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.21,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(11),
                                color: selected_day ==
                                    Shared.generateMonthDayNames(now)[index].number
                                    ? kGreenColor
                                    : kWhiteColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Shared.generateMonthDayNames(now)[index]
                                          .number
                                          .toString(),
                                      style: Styles.textStyle24.copyWith(
                                        color: selected_day ==
                                            Shared.generateMonthDayNames(now)[index].number
                                            ? kWhiteColor
                                            : kBlackColor,

                                      ),
                                    ),
                                    Text(
                                      Shared.generateMonthDayNames(now)[index].name,
                                      style: Styles.textStyle16.copyWith(
                                        color: selected_day ==
                                            Shared.generateMonthDayNames(now)[index].number
                                            ? kWhiteColor
                                            : kBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));

                    },
                  ),
                ),
              ),
            ),

            AttendanceDay(
              branch_name: "مكتب مدينة نصر",
              appoinment: "الاحد و الاثنين",
              attendence_time: "8:00",
              leave_time: "5:00",
              day_number: selected_day.toString(),
              day_name: "SUN",
            ),
          ],
        ),
      ),
    );
  }
}
