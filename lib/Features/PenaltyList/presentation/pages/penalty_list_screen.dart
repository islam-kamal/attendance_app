import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Base/Shimmer/loading_shimmer.dart';
import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/PenaltyList/data/models/penalty_model.dart';
import 'package:attendance_app_code/Features/PenaltyList/presentation/bloc/penalty_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Base/common/shared.dart';
import '../../../BottomNavigationBar/custom_app_bar.dart';

class PenaltyListScreen extends StatefulWidget {
  @override
  _PenaltyListScreenState createState() => _PenaltyListScreenState();
}

class _PenaltyListScreenState extends State<PenaltyListScreen> {
  Stream<QuerySnapshot<Object?>>? employee_schedule_stream;
  int? selected_index = 0;

  List<String> discount_list_status = [
    'اول مرة',
    'ثانى مرة',
    'ثالث مرة',
    'متكرر'
  ];

  @override
  void initState() {
    super.initState();
    penaltyBloc.add(GetPenaltyEvent(offset: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: kWhiteColor,
          appBar: CustomAppBar(
            title: 'لائحة الخصم',
          ),
          body: BlocBuilder<PenaltyBloc, AppState>(
            bloc: penaltyBloc,
            builder: (context, state) {
              if (state is Loading) {
                return const LoadingPlaceHolder(
                  shimmerType: ShimmerType.list,
                  cellShimmerHeight: 50,
                  shimmerCount: 10,
                );
              } else if (state is GetPenaltyDone) {
                if (state.penaltyModel!.data!.isNotEmpty) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: kInactiveColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: Shared.width * 0.15,
                              child: ListView.builder(
                                  itemCount: discount_list_status.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected_index = index;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: Shared.width / 4,
                                        decoration: BoxDecoration(
                                            color: selected_index == index
                                                ? kGreenColor
                                                : kInactiveColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Text(
                                          discount_list_status[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: selected_index == index
                                                ? kWhiteColor
                                                : kBlackColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                          SizedBox(
                            height: 20,
                          ),
                          DataTable(
                            columns: [
                              DataColumn(
                                label: Expanded(
                                    child: Text(
                                  'الموثرات',
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  discount_list_status[selected_index!],
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                            headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: kBlackColor),
                            border: TableBorder.all(
                                color: kBlackColor,
                                borderRadius: BorderRadius.circular(10)),
                            columnSpacing: 0,
                            sortAscending: true,
                            rows: [
                              ...List.generate(
                                  growable: true,
                                  state.penaltyModel!.data!.length, (index) {
                                return DataRow(
                                  cells: [
                                    DataCell(Center(
                                      child: Text(
                                        state.penaltyModel!.data![index].type!,
                                      ),
                                    )),
                                    penaltyData(
                                        penalty:
                                            state.penaltyModel!.data![index]),
                                  ],
                                );
                              })
                            ],
                            dataTextStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: kBlackColor),
                          )
                        ],
                      ));
                } else {
                  return Center(
                    child: Text("لا توجد سجلات حاليا"),
                  );
                }
              } else if (state is GetPenaltyErrorLoading) {
                return Center(
                  child: Text("${state.message}"),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  DataCell penaltyData({required Penalty penalty}) {
    return DataCell(Center(
        child: Text(
      " خصم "
      "${selected_index == 0 ? penalty.first!.toString() : selected_index == 1 ? penalty.second!.toString() : selected_index == 2 ? penalty.third!.toString() : penalty.moreThanThree!.toString()} "
      "${penalty.amountType == "fixed" ? penalty.timeType : "%"}",
      maxLines: 5,
      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    )));
  }
}

