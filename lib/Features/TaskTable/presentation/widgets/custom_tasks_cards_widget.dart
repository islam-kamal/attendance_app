import 'package:attendance_app_code/Features/TaskTable/data/data_sources/database/tasks_db.dart';
import 'package:attendance_app_code/Features/TaskTable/data/models/task.dart';
import 'package:attendance_app_code/Features/TaskTable/presentation/widgets/task_input_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';
import '../../../../Base/utils/styles.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
List<Task> tasks = [];
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> savedTasks = await TasksDatabase.getSavedTasks();
    Set<String?> existingTaskIds = tasks.map((task) => task.id).toSet();
    List<Task> newTasks = savedTasks.where((task) => !existingTaskIds.contains(task.id)).toList();
    setState(() {
      tasks.addAll(newTasks);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Directionality(textDirection: TextDirection.ltr,
              child:    Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      showDialog(context: context,
                          builder: (_) => TaskInputDialog(
                            onTaskSaved: (){
                              _loadTasks();
                            },
                          ));


                    },
                        icon: const Icon(
                          Icons.add,
                          size: 28,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'مهام اليوم',
                            style: Styles.textStyle24),
                        Opacity(
                            opacity: 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("مهام هذا اليوم"),
                                Text(
                                  " ${tasks.where((task){
                                    String timestampString = task.timeStamp as String;
                                    DateTime dateTime = DateTime.parse(timestampString);
                                    return (dateTime.day == Shared.task_selected_date.day);
                                  }).length.toString()}  ",
                                  style: Styles.textStyle16,
                                )
                              ],
                            )
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Container(
            height: Shared.width,
            child: tasks.where((task){
              String timestampString = task.timeStamp as String;
              DateTime dateTime = DateTime.parse(timestampString);
              return (dateTime.day == Shared.task_selected_date.day);
            }).isEmpty ? Center(
              child: Text("لا توجد مهام",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            )
                : ListView(
              shrinkWrap: true,
              children: tasks.map((task) {
                String timestampString = task.timeStamp as String;
                DateTime dateTime = DateTime.parse(timestampString);
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Shared.task_selected_date.day == dateTime.day
                        ? Card(
                      color: kInactiveColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(11))),
                      child: ListTile(
                        title: Text(
                          task.header!,
                          style: Styles.textStyle16.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: task.status!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            task.status = !task.status!;
                            await TasksDatabase.updateTaskStatus(task.id!, task.status!);
                            _loadTasks();

                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: task.status!
                                        ? kGreenColor
                                        : kBlackColor),
                                color: task.status!
                                    ? kGreenColor
                                    : kInactiveColor),
                            child: task.status!
                                ? Icon(Icons.check,
                                size: 20, color: kWhiteColor)
                                : null,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.description!,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                ImageIcon(
                                  AssetImage("assets/images/calendar.png"),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                      "${intl.DateFormat.EEEE('ar').format(dateTime)} , ${intl.DateFormat('dd MMMM yyyy', 'ar').format(dateTime)} "),
                                )
                              ],
                            )
                          ],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                    )
                        : Container());
              }).toList(),
            ),
          ),

        ],
      ),
    );
  }


}
