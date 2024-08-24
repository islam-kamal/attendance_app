import 'dart:async';
import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Features/Authentication/data/repositories/sigin_repository.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Base/validator.dart';

class LoginBloc extends Bloc<AppEvent,AppState> with Validator {

  LoginBloc() :super(Start()) {
    on<loginClickEvent>(_onSignIn);
  }

  Future<void> _onSignIn(loginClickEvent event,
      Emitter<AppState> emit) async {
    emit(Loading());
    var response = await siginInRepository.signIn(
        siginEntity: event.siginEntity
    );

    if (response.accessToken != null) {
     User.username =  response.user!.fullName!.toString();
      sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.accessToken!);
      sharedPreferenceManager.writeData(CachingKey.USER_ID, response.user?.id!);
      sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.user?.fullName!.toString());
     sharedPreferenceManager.writeData(CachingKey.EMAIL, response.user?.email!.toString());
     sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.user?.phone!.toString());
      print("accessToken : ${response.accessToken}");

      emit(Done());
    } else {
      emit(ErrorLoading(message: response.message));
    }
  }


}

LoginBloc loginBloc = new LoginBloc();


