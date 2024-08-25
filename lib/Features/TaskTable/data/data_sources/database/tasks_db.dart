import 'dart:io';
import 'package:attendance_app_code/Features/TaskTable/data/models/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TasksDatabase{
 static Future<Database> getDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tasks.db';
    return openDatabase(path, version: 3, // Increment version number for updates
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, header TEXT, description TEXT, status INTEGER, timeStamp TEXT)');
        },
        onUpgrade: (Database db, oldVersion, newVersion) async {
          if (oldVersion < newVersion) {
            // Handle schema updates
            await db.execute('ALTER TABLE Tasks ADD COLUMN status INTEGER');
          }
        });
  }

 static Future<List<Task>> getSavedTasks() async {
   final Database db = await getDatabase();
   final List<Map<String, dynamic>> maps = await db.query('Tasks');
   return List.generate(maps.length, (i) {
     return Task(
       id: maps[i]['id'].toString(),
         header: maps[i]['header'],
         description: maps[i]['description'],
       status: maps[i]['status'] == 1? true : false ,
       timeStamp: maps[i]['timeStamp'],

        );
   });
 }

 static Future<void> saveTasks({String? header , String? description ,bool? status , String? timeStamp}) async {
   final Database db = await TasksDatabase.getDatabase();
   await db.insert('Tasks', {
     'header': header ,
     'description': description,
     'status': status! ? 1 : 0,
     'timeStamp' : timeStamp
   });
 }

 static Future<void> updateTaskStatus(String id, bool status) async {
   final Database db = await getDatabase();
   await db.update(
     'Tasks',
     {'status': status?1:0},
     where: 'id = ?',
     whereArgs: [id],
   );
 }

}