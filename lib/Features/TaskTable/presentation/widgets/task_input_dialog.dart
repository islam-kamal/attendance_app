import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/TaskTable/data/data_sources/database/tasks_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../Base/common/shared.dart';

class TaskInputDialog extends StatefulWidget{
  final void Function()? onTaskSaved;
  TaskInputDialog({this.onTaskSaved});
  @override
  State<TaskInputDialog> createState() => _TaskInputDialogState();
}

class _TaskInputDialogState extends State<TaskInputDialog> {
  TextEditingController header_controller = new TextEditingController();

  TextEditingController description_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                  child:   TextField(
                    controller: header_controller,

                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                        hintText: "ادخل العنوان"
                    ),
                    onChanged: (value) {},
                  ) ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child:    TextField(
                  controller: description_controller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                      hintText: "ادخل التفاصيل"),
                  keyboardType: TextInputType.text,
                  maxLines: 8,
                  onChanged: (value) {
                  },
                ),)
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () async {
                TasksDatabase.saveTasks(
                    header: header_controller.text?? '',
                    description: description_controller.text ?? '',
                    status: false,
                    timeStamp: Shared.task_selected_date.toString()
                ).whenComplete((){
                  widget.onTaskSaved!.call();
                });
                Navigator.of(context).pop();
              },
              child: Text('تدوين',
                style: TextStyle(color: kGreenColor),),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('أغلاق',
              style: TextStyle(color: kRedColor),),
            ),


          ],
        ));

  }
}