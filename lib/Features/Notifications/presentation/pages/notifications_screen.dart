
import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import '../../../../Base/database/notifications_db.dart';
import '../../../Home/presentation/widgets/custom_app_bar.dart';
import '../../domain/entities/notifications_element.dart';
import '../widgets/notification_element_widget.dart';


class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationElement> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    List<NotificationElement> savedNotifications = await NotificationsDatabase.getSavedNotifications();
    setState(() {
      notifications = savedNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: CustomAppBar(title: 'الاشعارات',
                 onPress: (){},

           ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {

            return NotificationElementWidget(
              header: notifications[index].header ,
              description: notifications[index].description,
              timeStamp:notifications[index].timeStamp ,

            );

          },
        ),
      ),
    );
  }
}






