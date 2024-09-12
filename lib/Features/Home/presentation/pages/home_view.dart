import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Base/Shimmer/loading_shimmer.dart';
import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/Attendance_Table/presentation/bloc/attendance_bloc.dart';
import 'package:attendance_app_code/Features/Home/presentation/bloc/registeration_bloc.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../../../Base/common/shared.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/work_hours_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String checkIn = "--/--";
  String checkOut = "--/--";
  String location = "";
  String scanResult = " ";
  String officeCode = " ";
  int status = 0;
  @override
  void initState() {
    super.initState();
    attendanceBloc.add(GetAttendanceEvent(offset: 1));
  }

  void _getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(User.lat, User.long);

    setState(() {
      location = "${placemark[0].street}, ${placemark[0].administrativeArea}";
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocListener(
            bloc: registerationBloc,
            listener: (context, state) {
              if (state is Loading) {
             //   Shared.showLoadingDialog(context: context);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  headerBackgroundColor: kPrimaryColor,

                );
              } else if (state is ApplyRegisterationDone) {
                Shared.dismissDialog(context: context);

                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: state.registerationModel!.data!.register_in != null
                      ? 'تم تسجيل الحضور بنجاح'
                  : "تم تسجيل الانصراف بنجاح",
                  confirmBtnText: "اغلاق",
                  onConfirmBtnTap: (){
                    Shared.dismissDialog(context: context);
                    attendanceBloc.add(GetAttendanceEvent(offset: 1));

                  },
                  title: "اهلا"
                );

              } else if (state is ApplyRegisterationErrorLoading) {
                print("ApplyRegisterationErrorLoading");
                print("state.message : ${state.message}");

               Shared.dismissDialog(context: context);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Oops...',
                  text: state.message,
                );
                /*    Shared.showSnackBarView(
                  error_status: true,
                  backend_message: state.message,
                );*/
              }
            },
            child: Scaffold(
              appBar: HomeAppBar(),
              body: BlocBuilder<AttendanceBloc, AppState>(
                bloc: attendanceBloc,
                builder: (context, state) {
                  if (state is Loading) {
                    return const LoadingPlaceHolder(
                      shimmerType: ShimmerType.list,
                      cellShimmerHeight: 50,
                      shimmerCount: 10,
                    );
                  }
                  else if (state is GetAttendanceDone) {
                    final todayAttendance = state
                        .attendanceModel!.data!.attendance!
                        .where((element) => isSameDay(
                            DateTime.parse(element.createdAt.toString()),
                           /* DateTime.parse("2024-08-29")*/ DateTime.now()))
                        .toList();

                    return Container(
                      color: kPrimaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WorkHoursView(
                            color: Color.fromARGB(255, 168, 244, 228),
                            baseText: 'حضرت',
                            text: 'في الموعد المحدد',
                            textColor: Color(0xff01D9AC),
                            location: location,
                            checkIn: todayAttendance.isEmpty
                                ? "--/--"
                                : todayAttendance[0].registerIn == null
                                ? "--/--"
                                : todayAttendance[0]
                                .registerIn!
                                .substring(0, 5),
                            checkOut: todayAttendance.isEmpty
                                ? "--/--"
                                : todayAttendance[0].registerOut == null
                                ? "--/--"
                                : todayAttendance[0]
                                .registerOut!
                                .substring(0, 5),
                            status: todayAttendance.isEmpty
                                ? 1
                                : (todayAttendance[0].lateHours! > 0 &&
                                todayAttendance[0].lateMin! > 0)
                                ? 2
                                : 0 /*(todayAttendance[0].lateHours! == 0 && todayAttendance[0].lateMin! == 0)
                        ? 0
                        : 1*/
                            ,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Shared.width * 0.1),
                            width: Shared.width * 0.85,
                            child: Builder(
                              builder: (context) {
                                GlobalKey<SlideActionState> key = GlobalKey();
                                return SlideAction(
                                  text: todayAttendance.isEmpty
                                      ? "اسحب لتسجيل الحضور"
                                      : todayAttendance[0].registerIn == null
                                      ? "اسحب لتسجيل الحضور"
                                      : "اسحب لتسجيل الانصراف",
                                  textStyle: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  outerColor: Colors.white,
                                  innerColor: kPrimaryColor,
                                  enabled: todayAttendance.isEmpty
                                      ? true
                                      : (todayAttendance[0].registerOut != null &&
                                      todayAttendance[0].registerIn != null)
                                      ? false
                                      : true,
                                  elevation: 10,
                                  key: key,
                                  height: Shared.width * 0.15,
                                  sliderButtonIconSize: Shared.width * 0.04,
                                  onSubmit: () async {
                                    String status;
                                    if (todayAttendance.isEmpty) {
                                      status = "in";
                                      _getLocation();
                                    } else {

                                      if (todayAttendance[0].registerIn == null) {
                                        status = "in";
                                        _getLocation();
                                      } else {
                                        status = "out";
                                      }
                                    }

                                    registerationBloc.add(
                                        ApplyRegisterationEvent(status: status));

                                  },
                                );
                              },
                            ),
                          ),

                          /*          Expanded(
                child:  DatesDayView()),*/
                        ],
                      ),
                    );

                  }
                  else if (state is GetAttendanceErrorLoading) {
                    return Center(
                      child: Text("${state.message}"),
                    );
                  }
                  else {
                    return Container();
                  }
                },
              ),
            )));
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
