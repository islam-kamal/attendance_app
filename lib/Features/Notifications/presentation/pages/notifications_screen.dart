import 'package:attendance_app_code/Features/Notifications/domain/entities/notifications_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
class NotificationsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Page();
  }

}

class Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }

}

class _PageState extends State<Page>{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}*/



import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import '../../../../Base/database/notifications_db.dart';


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
      appBar: AppBar(
        title: Text('Push Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(notifications[index].header),
            subtitle: Column(children: [
              Text(notifications[index].description),
              Text(notifications[index].timeStamp)
            ],),

          );
        },
      ),
     /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulate receiving a push notification
          NotificationsDatabase.saveNotification(
            header: 'New Notification ${notifications.length + 1}',
            description: "good notifications",
             timeStamp: DateTime.now().toString()
          );
          _loadNotifications();
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}






