import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Base/validator.dart';
import 'package:attendance_app_code/Features/Notifications/data/repositories/notification_repository.dart';
import 'package:bloc/bloc.dart';

class NotificationsBloc extends Bloc<AppEvent,AppState> with Validator {

  NotificationsBloc() :super(Start()) {
    on<GetNotificationsEvent>(_onGetNotificationsClick);
  }

  Future<void> _onGetNotificationsClick(GetNotificationsEvent event,
      Emitter<AppState> emit) async {
    emit(Loading());
      var response = await notificationsRepository.getNotifications();
      if (response!.success! ) {
        emit(GetNotificationsDone(notificationModel: response));
      } else {
        emit(GetNotificationsErrorLoading(message: response.message));
      }

  }


}

NotificationsBloc notificationsBloc = new NotificationsBloc();
