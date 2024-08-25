import 'dart:convert';

import 'package:attendance_app_code/Base/common/config.dart';
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Base/network/network_util.dart';
import 'package:attendance_app_code/Features/Attendance_Table/data/models/attendence_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class AttendanceRepository{

  Future<AttendanceModel?> getAttendanceData({int offset = 1}) async {
    Map<String, String> headers = {
      'lang': LocalizeAndTranslate.getLanguageCode(),
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': LocalizeAndTranslate.getLanguageCode() == 'ar' ? 'ar-EG' : 'en-EG',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    };
    return NetworkUtil.internal().get(
        AttendanceModel(), baseUrl + getAttendaceUrl, headers: headers ,
    data: jsonEncode({
        "limit":31,
        "with":["user"],
        "offset": offset.toString(),
        "sort":"ASC", //DESC
        "paginate":"true",
        "field":"id",
        "deleted":"all",//all,deleted
        "resource":"all",//all,custom
        "resource_columns":["id"],
        "columns":["user_id"],
        "operand":["="],
        "column_values":["1"]

    }));
  }
}
final attendanceRepository = AttendanceRepository();