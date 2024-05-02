import 'package:attendance_app_code/Features/TaskTable/presentation/widgets/task_input_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Base/utils/styles.dart';
import '../../../Home/presentation/widgets/custom_app_bar.dart';
import 'custom_days_list_view_widget.dart';
import 'custom_tasks_cards_widget.dart';

class TasksTableView extends StatelessWidget {
  const TasksTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'جدول المهام',
        onPress: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomDaysListView(),

          ],
        ),
      ),
    );
  }
}
