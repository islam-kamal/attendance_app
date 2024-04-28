import 'dart:async';
import 'package:attendance_app_code/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';
import '../../../Home/presentation/widgets/custom_app_bar.dart';
import '../widgets/attendance_table_header_widget.dart';
import '../widgets/date_selection_widget.dart';

class AttendanceTableScreen extends StatefulWidget {
  const AttendanceTableScreen({Key? key}) : super(key: key);

  @override
  _AttendanceTableScreenState createState() => _AttendanceTableScreenState();
}

class _AttendanceTableScreenState extends State<AttendanceTableScreen> {
  Color primary = const Color(0xffeef444c);

  Stream<QuerySnapshot<Object?>>? employee_schedule_stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'جدول الحضور',
          onPress: () {},
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                DataSelectionWidget(),

                //  AttendanceTableHeaderWidget(),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Employee")
                      .doc(User.id)
                      .collection("employee_schedule")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      print("snap : ${snap}");
                      if (snap.isNotEmpty) {
                        return Padding(
                            padding: EdgeInsets.all(10),
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
                                    child: DataTable(
                                        columns: [
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'التاريخ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                                child: Text(
                                              'تسجيل الوصول',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                                child: Text(
                                              'تسجيل المغادرة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                                child: Text(
                                              'الحالة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ],
                                        sortAscending: true,
                                        rows: [

                                          ...List.generate(
                                              growable: true,
                                              snap.length, (index) {
                                            return DataRow(
                                              cells: [
                                                DataCell( Text(
                                                        snap[index]['day'])),
                                                DataCell( Text(snap[index]
                                                        ['branchName'])),
                                                DataCell(Text(
                                                      snap[index]['address']
                                                          ['name'],
                                                    )),
                                                DataCell( Text(
                                                      snap[index]['address']
                                                          ['name'],
                                                    )),
                                              ],
                                            );
                                          })
                                        ]))));
                      } else {
                        return Center(
                            child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Shared.width / 2),
                          child: const Text(
                            "There Is No Data",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ));
                      }
                    } else {
                      return Center(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Shared.width / 2),
                        child: const Text(
                          "There Is No Data",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
