import 'dart:convert';

import 'package:attendance_app_code/Base/common/config.dart';
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Base/network/network_util.dart';
import 'package:attendance_app_code/Features/Home/data/models/registeration_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class RegisterationRepository{

  Future<RegisterationModel?> applyRegisteration({required String status}) async {
    print("1-1");
    Map<String, String> headers = {
      'lang': LocalizeAndTranslate.getLanguageCode(),
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': LocalizeAndTranslate.getLanguageCode() == 'ar' ? 'ar-EG' : 'en-EG',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    };
    print("1-2");
    return NetworkUtil.internal().post(
        RegisterationModel(),
        baseUrl + registerationUrl,
        headers: headers ,
        body: jsonEncode({
          "check_type": status,
        })
    );
  }


}
RegisterationRepository registerationRepository = new RegisterationRepository();