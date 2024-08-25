
import 'package:attendance_app_code/Features/Home/data/models/registeration_model.dart';

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



