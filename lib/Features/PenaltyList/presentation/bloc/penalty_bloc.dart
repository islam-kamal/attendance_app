import 'dart:async';
import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Features/PenaltyList/data/repositories/penalty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Base/validator.dart';

class PenaltyBloc extends Bloc<AppEvent,AppState> with Validator {

  PenaltyBloc() :super(Start()) {
    on<GetPenaltyEvent>(_onGetPenaltiesDataClick);
  }

  Future<void> _onGetPenaltiesDataClick(GetPenaltyEvent event,
      Emitter<AppState> emit) async {
    emit(Loading());
    var response = await penaltyRepository.getPenaltyData(
        offset: event.offset
    );
    if (response!.success! ) {
      emit(GetPenaltyDone(penaltyModel: response));
    } else {
      emit(GetPenaltyErrorLoading(message: response.message));
    }
  }
}

PenaltyBloc penaltyBloc = new PenaltyBloc();


