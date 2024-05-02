import 'package:attendance_app_code/Base/common/shared.dart';
import 'package:attendance_app_code/Features/TaskTable/presentation/widgets/task_input_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Base/common/theme.dart';
import '../../../../Base/utils/styles.dart';
import '../../../Home/presentation/widgets/times_of_work_list_view.dart';
import 'custom_tasks_cards_widget.dart';

class CustomDaysListView extends StatefulWidget {
  const CustomDaysListView({super.key});

  @override
  State<CustomDaysListView> createState() => _CustomDaysListViewState();
}

class _CustomDaysListViewState extends State<CustomDaysListView> {
  DateTime now = DateTime.now();
  int? selected_day;
  @override
  void initState() {
    selected_day = generateMonthDayNames(now)[0].number;
    super.initState();
  }

  List<Day> generateMonthDayNames(DateTime dateTime) {
    List<Day> monthDayNames = [];

    // Iterate through 7 days starting from the current date
    for (int i = 0; i < 31; i++) {
      // Add the formatted month day name to the list
      monthDayNames.add(Day(
          name: DateFormat.EEEE('ar').format(dateTime),
          number: dateTime.day,
      date: dateTime));

      // Increment the date by one day for the next iteration
      dateTime = dateTime.add(Duration(days: 1));
    }

    return monthDayNames;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            height: 65,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: generateMonthDayNames(now).length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        selected_day = generateMonthDayNames(now)[index].number;
                        Shared.task_selected_date = generateMonthDayNames(now)[index].date;
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
                                  generateMonthDayNames(now)[index].number
                              ? kGreenColor
                              : kWhiteColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                generateMonthDayNames(now)[index]
                                    .number
                                    .toString(),
                                style: Styles.textStyle24,
                              ),
                              Text(
                                generateMonthDayNames(now)[index].name,
                                style: Styles.textStyle16,
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



      CardWidget()
    ]);
  }
}

class Day {
  final String name;
  final int number;
  final DateTime date ;
  Day({required this.name, required this.number,required this.date});
}
