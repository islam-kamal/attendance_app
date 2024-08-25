import 'dart:async';
import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Features/Attendance_Table/data/repositories/attendance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Base/validator.dart';

class AttendanceBloc extends Bloc<AppEvent,AppState> with Validator {

  AttendanceBloc() :super(Start()) {
    on<GetAttendanceEvent>(_onGetAttendanceDataClick);
  }

  Future<void> _onGetAttendanceDataClick(GetAttendanceEvent event,
      Emitter<AppState> emit) async {
    emit(Loading());
    var response = await attendanceRepository.getAttendanceData(
      offset: event.offset
    );
    if (response!.success! ) {
      emit(GetAttendanceDone(attendanceModel: response));
    } else {
      emit(GetAttendanceErrorLoading(message: response.message));
    }
  }
}

AttendanceBloc attendanceBloc = new AttendanceBloc();


