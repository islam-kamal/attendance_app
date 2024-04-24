import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'Helper/app_event.dart';
import 'Helper/app_state.dart';
import '../../../../Base/validator.dart';

class LoginBloc extends Bloc<AppEvent,AppState> with Validator{

  LoginBloc():super(Start()){
    on<loginClickEvent>(_onSignUpClick);
  }






  Future<void> _onSignUpClick(loginClickEvent event , Emitter<AppState> emit)async{
    emit( Loading());
    var response;
/*     response = await AuthenticationRepository.signUp(
        userEductionEntity: event.userEductionEntity
    );*/
    if(response.httpStatusCode == 200 || response.httpStatusCode == 201){


      emit( Done(model: response));

    }else{
      emit( ErrorLoading(model: response,message: response.message));
    }

  }




}

LoginBloc signUpBloc = new LoginBloc();


