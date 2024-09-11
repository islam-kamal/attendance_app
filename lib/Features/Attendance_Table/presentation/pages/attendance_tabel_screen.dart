
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
  Stream<QuerySnapshot<Object?>>? employeeScheduleStream;
  String selectedMonth = intl.DateFormat('MMMM').format(DateTime.now());
  String year = intl.DateFormat('yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    attendanceBloc.add(GetAttendanceEvent(offset: 1));
  }

  List<DateTime> _getDaysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0);
    return List.generate(lastDay.day, (index) => DateTime(year, month, index + 1));
  }

  Future<void> _selectMonthYear() async {
    final selectedDate = await SimpleMonthYearPicker.showMonthYearPickerDialog(
      context: context,
      titleTextStyle: TextStyle(color: Colors.black),
      selectionColor: kGreenColor,
      monthTextStyle: TextStyle(),
      yearTextStyle: TextStyle(),
      disableFuture: true,
    );
    if (selectedDate != null) {
      setState(() {
        selectedMonth = intl.DateFormat('MMMM').format(selectedDate);
        year = intl.DateFormat('yyyy').format(selectedDate);
        attendanceBloc.add(GetAttendanceEvent(offset: 1));
      });
    }
  }

  Widget _buildDateTable(List<DateTime> days, AttendanceModel? attendanceModel) {
    if (attendanceModel == null || attendanceModel.data?.attendance?.isEmpty == true) {
      return Center(child: Text("لا توجد سجلات حاليا"));
    }

    final now = DateTime.now();
    final parsedMonth = intl.DateFormat('MMMM').parse(selectedMonth).month;
    final parsedYear = int.parse(year);
    final daysInMonth = _getDaysInMonth(parsedYear, parsedMonth);

    List<DateTime> filteredDays = (parsedMonth == now.month && parsedYear == now.year)
        ? daysInMonth.where((day) => !day.isAfter(now)).toList()
        : daysInMonth;

    if (filteredDays.isEmpty) {
      return Center(child: Text("هذا الشهر غير متاح"));
    }

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
          child:  DataTable(
            columnSpacing: Shared.width * 0.02,
            horizontalMargin: 0,
            columns: _buildDataColumns(),
            rows: _buildDataRows(filteredDays, attendanceModel),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(
        label: Expanded(
          child: Text(
            'التاريخ',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'تسجيل الوصول',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'تسجيل المغادرة',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'الحالة',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _buildDataRows(List<DateTime> days, AttendanceModel attendanceModel) {
    return List.generate(days.length, (index) {
      final currentDay = days[index];
      final record = attendanceModel.data!.attendance!.firstWhere(
            (att) => intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(att.attendanceDate!)) ==
            intl.DateFormat('yyyy-MM-dd').format(currentDay),
        orElse: () => Attendance(),
      );

      return DataRow(
        cells: [
          DataCell(Center(
            child: Text(
              "${intl.DateFormat("dd").format(currentDay)} ${intl.DateFormat.EEEE('ar').format(currentDay)}",
            ),
          )),
          DataCell(Center(
            child: Text(
              record.registerIn != null
                  ? intl.DateFormat("HH:mm").format(_parseTime(record.registerIn!))
                  : 'N/A',
            ),
          )),
          DataCell(Center(
            child: Text(
              record.registerOut != null
                  ? intl.DateFormat("HH:mm").format(_parseTime(record.registerOut!))
                  : 'N/A',
            ),
          )),
          DataCell(Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _getCellColor(record),
            ),
            height: 30,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  _getCellText(record),
                  softWrap: true,
                ),
              ),
            ),
          )),
        ],
      );
    });
  }

  DateTime _parseTime(String time) {
    final parts = time.split(":");
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  Color _getCellColor(Attendance record) {
    if (record.registerIn != null || record.registerOut != null) {
      return (record.lateHours != null && record.lateHours! > 0)
          ? kLightRed
          : kLightGreenColor;
    }
    return kTransparentColor;
  }

  String _getCellText(Attendance record) {
    if (record.registerIn != null || record.registerOut != null) {
      return (record.lateHours != null && record.lateHours! > 0)
          ? "متاخر"
          : "فى العمل";
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'جدول الحضور'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 12),
                  child: GestureDetector(
                    onTap: _selectMonthYear,
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
                          padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.arrow_back_ios, color: kGreenColor, size: 25),
                              Text(
                                "$selectedMonth $year",
                                style: TextStyle(color: kGreenColor, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_forward_ios, color: kGreenColor, size: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                      return _buildDateTable(_getDaysInMonth(
                          int.parse(year),
                          intl.DateFormat('MMMM').parse(selectedMonth).month),
                          state.attendanceModel);
                    } else if (state is GetAttendanceErrorLoading) {
                      return Center(child: Text("${state.message}"));
                    }
                    return Container();
                  },
                ),

            ],
          ),
        ),
      ),
    );
  }
}
