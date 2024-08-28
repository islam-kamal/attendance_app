import 'dart:async';
import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Base/Shimmer/loading_shimmer.dart';
import 'package:attendance_app_code/Features/Attendance_Table/data/models/attendence_model.dart';
import 'package:attendance_app_code/Features/Attendance_Table/presentation/bloc/attendance_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simple_month_year_picker/simple_month_year_picker.dart';
import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';
import '../../../BottomNavigationBar/custom_app_bar.dart';

class AttendanceTableScreen extends StatefulWidget {
  const AttendanceTableScreen({Key? key}) : super(key: key);

  @override
  _AttendanceTableScreenState createState() => _AttendanceTableScreenState();
}

class _AttendanceTableScreenState extends State<AttendanceTableScreen> {
  Color primary = const Color(0xffeef444c);

  Stream<QuerySnapshot<Object?>>? employee_schedule_stream;
  String selected_month = intl.DateFormat('MMMM').format(DateTime.now());

  String year = intl.DateFormat('yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
   // attendanceBloc.add(GetAttendanceEvent(offset: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'جدول الحضور',
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 12),
                    child: GestureDetector(
                      onTap: () async {
                        final selectedDate = await SimpleMonthYearPicker
                            .showMonthYearPickerDialog(
                                context: context,
                                titleTextStyle: TextStyle(color: kBlackColor),
                                selectionColor: kGreenColor,
                                monthTextStyle: TextStyle(),
                                yearTextStyle: TextStyle(),
                                disableFuture:
                                    true // This will disable future years. it is false by default.
                                );
                        setState(() {
                          // Use the selected date as needed
                          print('Selected date: $selectedDate');
                          selected_month =
                              intl.DateFormat('MMMM').format(selectedDate);
                          year = intl.DateFormat('yyyy').format(selectedDate);
                        });
                      },
                      child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              alignment: Alignment.center,
                              height: Shared.width * 0.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: kWhiteColor),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Shared.width * 0.15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: kGreenColor,
                                      size: 25,
                                    ),
                                    Text(
                                      "${selected_month}  ${year}",
                                      style: TextStyle(
                                          color: kGreenColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: kGreenColor,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ))),
                    ),
                  ),
                ),
                BlocBuilder<AttendanceBloc, AppState>(
                  bloc: attendanceBloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      return const LoadingPlaceHolder(
                        shimmerType: ShimmerType.list,
                        cellShimmerHeight: 50,
                        shimmerCount: 10,
                      );
                    } else if (state is GetAttendanceDone) {
                      if (state.attendanceModel!.data!.attendance!.isNotEmpty) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    height: Shared.width * 0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: kWhiteColor),
                                    ),
                                    child: DataTable(
                                        columnSpacing: Shared.width * 0.02,
                                        horizontalMargin: 0,
                                        columns: [
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'التاريخ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),

                                          ),
                                          DataColumn(
                                            label: Expanded(
                                                child: Text(
                                              'تسجيل الوصول',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            )),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                                child: Text(
                                              'تسجيل المغادرة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            )),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                                child: Text(
                                              'الحالة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            )),
                                          ),
                                        ],
                                        sortAscending: true,
                                        rows: [
                                          ...List.generate(
                                              growable: true,
                                              state.attendanceModel!.data!
                                                  .attendance!.length, (index) {
                                            Attendance record = state
                                                .attendanceModel!
                                                .data!
                                                .attendance![index];
                                            return intl.DateFormat('MMMM').format(
                                                        DateTime.parse(record
                                                            .attendanceDate!)) ==
                                                    selected_month
                                                ? DataRow(
                                                    cells: [
                                                      DataCell(Center(
                                                          child: Text(
                                                        "${intl.DateFormat("dd").format(DateTime.parse(record.attendanceDate!))}"
                                                        " ${intl.DateFormat.EEEE('ar').format(DateTime.parse(record.attendanceDate!))}",
                                                      ))),
                                                      DataCell(Center(
                                                          child: Text(record
                                                                      .registerIn !=
                                                                  null
                                                              ? intl.DateFormat(
                                                                      "hh:mm")
                                                                  .format(DateTime
                                                                      .parse(record
                                                                              .attendanceDate! +
                                                                          " ${record.registerIn!}"))
                                                              : 'N/A'))),
                                                      DataCell(Center(
                                                          child: Text(record
                                                                      .registerOut !=
                                                                  null
                                                              ? intl.DateFormat(
                                                                      "hh:mm")
                                                                  .format(DateTime
                                                                      .parse(record
                                                                              .attendanceDate! +
                                                                          " ${record.registerOut!}"))
                                                              : 'N/A'))),
                                                      DataCell(Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: (record.lateHours! >
                                                                        0 &&
                                                                    record.lateMin! >
                                                                        0)
                                                                ? kLightRed
                                                                : kLightGreenColor),
                                                        height: 30,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 0,
                                                                  horizontal:
                                                                      20),
                                                          child: Center(
                                                              child: Text(
                                                            (record.lateHours! >
                                                                        0 &&
                                                                    record.lateMin! >
                                                                        0)
                                                                ? "متاخر"
                                                                : "فى العمل",
                                                            softWrap: true,
                                                          )),
                                                        ),
                                                      )),
                                                    ],
                                                  )
                                                : DataRow(cells: [
                                                    DataCell(Container()),
                                                    DataCell(Container()),
                                                    DataCell(Container()),
                                                    DataCell(Container())
                                                  ]);
                                          })
                                        ]))));
                      } else {
                        return Center(
                          child: Text("لا توجد سجلات حاليا"),
                        );
                      }
                    } else if (state is GetAttendanceErrorLoading) {
                      return Center(
                        child: Text("${state.message}"),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
