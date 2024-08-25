
import 'package:attendance_app_code/Features/Attendance_Table/data/models/attendence_model.dart';
import 'package:attendance_app_code/Features/Home/data/models/registeration_model.dart';
import 'package:attendance_app_code/Features/PenaltyList/data/models/penalty_model.dart';

abstract class AppState {
  get model =>null;
}
class Start extends AppState{

}

class Loading extends AppState{
}

class Done extends AppState{
}

class ErrorLoading extends AppState{
  final String? message;
  ErrorLoading({this.message});
}

class ApplyRegisterationDone extends AppState{
  RegisterationModel? registerationModel ;
  ApplyRegisterationDone({this.registerationModel});
}

class ApplyRegisterationErrorLoading extends AppState{
  final String? message;
  ApplyRegisterationErrorLoading({this.message});
}


class GetAttendanceDone extends AppState{
  AttendanceModel? attendanceModel ;
  GetAttendanceDone({this.attendanceModel});
}

class GetAttendanceErrorLoading extends AppState{
  final String? message;
  GetAttendanceErrorLoading({this.message});
}

class GetPenaltyDone extends AppState{
  PenaltyModel? penaltyModel ;
  GetPenaltyDone({this.penaltyModel});
}

class GetPenaltyErrorLoading extends AppState{
  final String? message;
  GetPenaltyErrorLoading({this.message});
}

