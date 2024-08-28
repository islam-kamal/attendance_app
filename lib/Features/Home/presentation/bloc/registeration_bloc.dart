import 'dart:async';
import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Features/Attendance_Table/presentation/bloc/attendance_bloc.dart';
import 'package:attendance_app_code/Features/Home/data/repositories/registeration_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Base/validator.dart';

class RegisterationBloc extends Bloc<AppEvent,AppState> with Validator {

  RegisterationBloc() :super(Start()) {
    on<ApplyRegisterationEvent>(_onApplyRegisterationClick);
  }

  Future<void> _onApplyRegisterationClick(ApplyRegisterationEvent event,
      Emitter<AppState> emit) async {
    emit(Loading());
    print("1");
    await registerationRepository.applyRegisteration(
        status: event.status
    ).then((value){
      print("2");
      print("((()))response : ${value!.success} , ${value.data}");
      if (value!.success! ) {
        print("3");
        emit(ApplyRegisterationDone(registerationModel: value));
      } else {
        print("4");
        emit(ApplyRegisterationErrorLoading(message: value.message));
      }
    });

  }


}

RegisterationBloc registerationBloc = new RegisterationBloc();


