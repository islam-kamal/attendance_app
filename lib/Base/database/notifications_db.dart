import 'dart:io';

import 'package:attendance_app_code/Features/Notifications/domain/entities/notifications_element.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotificationsDatabase{
 static Future<Database> getDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notifications.db';
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Notifications (id INTEGER PRIMARY KEY, header TEXT , description Text , timeStamp Text)');
        });
  }

 static Future<List<NotificationElement>> getSavedNotifications() async {
   final Database db = await getDatabase();
   final List<Map<String, dynamic>> maps = await db.query('Notifications');
   return List.generate(maps.length, (i) {
     return NotificationElement(
         header: maps[i]['header'],
         description: maps[i]['description'],
         timeStamp: maps[i]['timeStamp']);
   });
 }

 static Future<void> saveNotification({String? header , String? description , String? timeStamp}) async {
   final Database db = await NotificationsDatabase.getDatabase();
   await db.insert('Notifications', {
     'header': header ,
     'description': description,
     'timeStamp' : timeStamp
   });
 }

}