import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/user.dart';
import 'Helper/app_event.dart';
import 'Helper/app_state.dart';
import '../../../../Base/validator.dart';

class LoginBloc extends Bloc<AppEvent,AppState> with Validator{

  LoginBloc():super(Start()){
    on<loginClickEvent>(_onSignUpClick);
  }

  Future<void> _onSignUpClick(loginClickEvent event , Emitter<AppState> emit)async{
    emit( Loading());

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee").where('id', isEqualTo: event.username).get();

    try {

      if(event.password == snap.docs[0]['password']) {
        SharedPreferences   sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString('employeeId', event.username).whenComplete((){
          User.employeeId = event.username;

        });
        emit(Done());
      } else {
       emit(ErrorLoading());
      }
    } catch(e) {
      emit(ErrorLoading(
        message: e.toString()
      ));
    }
  }

  }






LoginBloc loginBloc = new LoginBloc();


