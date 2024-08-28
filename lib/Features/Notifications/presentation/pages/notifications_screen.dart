
import 'package:attendance_app_code/Base/Helper/app_event.dart';
import 'package:attendance_app_code/Base/Helper/app_state.dart';
import 'package:attendance_app_code/Base/Shimmer/loading_shimmer.dart';
import 'package:attendance_app_code/Base/common/navigtor.dart';
import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/Home/presentation/pages/homescreen.dart';
import 'package:attendance_app_code/Features/Notifications/presentation/bloc/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../../../Base/database/notifications_db.dart';
import '../../../BottomNavigationBar/custom_app_bar.dart';
import '../../domain/entities/notifications_element.dart';
import '../widgets/notification_element_widget.dart';


class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
/*
  List<NotificationElement> notifications = [
    NotificationElement(
      header: 'تم خصم يوم',
      description: 'نظرا لتغيبك عن العمل بدون اذن مسبق ',
      timeStamp: 'منذ ساعة',

    ),
    NotificationElement(
      header: 'تم ترقيتك لدرجة مدير',
      description: 'نظرا لتفانيك فى ادى العمل ',
      timeStamp: 'منذ ساعتين',

    ),

  ];
*/

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationsBloc.add(GetNotificationsEvent());
    });
  }

 /* Future<void> _loadNotifications() async {
    List<NotificationElement> savedNotifications = await NotificationsDatabase.getSavedNotifications();
    setState(() {
      notifications.addAll( savedNotifications);
    });
  }
  @override
  void didChangeDependencies() {
    _loadNotifications();
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: CustomAppBar(title: 'الاشعارات',
        icon: InkWell(
            onTap: () {
              customAnimatedPushNavigation(context, HomeScreen());
            } ,
            child: Icon(Icons.arrow_back_ios)),
           ),

      body: BlocBuilder<NotificationsBloc, AppState>(
        bloc: notificationsBloc,
        builder: (context, state) {
          if (state is Loading) {
            return const LoadingPlaceHolder(
              shimmerType: ShimmerType.list,
              cellShimmerHeight: 50,
              shimmerCount: 10,
            );
          } else if (state is GetNotificationsDone) {
            if(state.notificationModel!.data!.isNotEmpty){
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.notificationModel!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationElementWidget(
                      header: state.notificationModel!.data![index].title! ,
                      description: state.notificationModel!.data![index].body!,
                      timeStamp:state.notificationModel!.data![index].createdAt! ,
                    );
                  },
                ),
              );
            }else{
              return Center(
                child: Text("لا توجد أشعارات حاليا"),
              );
            }

          } else if (state is GetNotificationsErrorLoading) {
            return Center(
              child: Text("${state.message}"),
            );
          } else {
            return Container();
          }
        },
      )

    );
  }
}






