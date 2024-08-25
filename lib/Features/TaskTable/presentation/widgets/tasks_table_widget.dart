import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../BottomNavigationBar/custom_app_bar.dart';
import 'custom_days_list_view_widget.dart';

class TasksTableView extends StatelessWidget {
  const TasksTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'جدول المهام',
      ),
      body: const CustomDaysListView(),
    );
  }
}
