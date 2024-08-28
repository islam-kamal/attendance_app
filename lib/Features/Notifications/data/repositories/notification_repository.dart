
import 'package:attendance_app_code/Base/common/config.dart';
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Base/network/network_util.dart';
import 'package:attendance_app_code/Features/Notifications/data/models/notification_model.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationsRepository {

  Future<NotificationModel?> getNotifications() async {
    Map<String, String> headers = {
      'lang': LocalizeAndTranslate.getLanguageCode(),
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': LocalizeAndTranslate.getLanguageCode() == 'ar' ? 'ar-EG' : 'en-EG',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
    };
    return NetworkUtil.internal().get(
        NotificationModel(), baseUrl + getNotificationsUrl, headers: headers,
    );
  }

}
NotificationsRepository notificationsRepository = new NotificationsRepository();