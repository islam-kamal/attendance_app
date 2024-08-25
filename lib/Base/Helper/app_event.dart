

import 'package:attendance_app_code/Features/Authentication/domain/entities/sigin_entity.dart';

abstract class AppEvent {}

class logoutClickEvent extends AppEvent{}

class loginClickEvent extends AppEvent{
  final SiginEntity  siginEntity;

  loginClickEvent({required this.siginEntity});
}


class ApplyRegisterationEvent extends AppEvent{
  final String  status;

  ApplyRegisterationEvent({required this.status});
}
