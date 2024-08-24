

import 'dart:convert';

import 'package:attendance_app_code/Base/common/config.dart';
import 'package:attendance_app_code/Base/common/shared.dart';
import 'package:attendance_app_code/Base/network/network_util.dart';
import 'package:attendance_app_code/Features/Authentication/data/models/sign_in_model.dart';
import 'package:attendance_app_code/Features/Authentication/domain/entities/sigin_entity.dart';

class SiginInRepository {

   Future<SiginModel> signIn({SiginEntity? siginEntity}) async {

    return NetworkUtil.internal().post(SiginModel(),
        baseUrl +  loginUrl,
        body: jsonEncode( {
          "user_name": siginEntity?.userName,
          "password": siginEntity?.password,
          "fcm_token" : Shared.device_token
        }),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));
  }

}
SiginInRepository siginInRepository = new SiginInRepository();