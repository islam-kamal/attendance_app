/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _preferredHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xff21CDAF), Color(0xff1093BC)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.8), //👈 Customize your shadow
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            child: Text(
              'Resources',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredHeight);
}*/



import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget    implements PreferredSizeWidget{
  final String title;
  Function onPress;
  CustomAppBar({required this.title,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      toolbarHeight:MediaQuery.of(context).size.height/10,
      leading: Icon(Icons.arrow_back_ios),
      centerTitle: true,
      title: Text("$title",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
      ),
      backgroundColor: kPrimaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.vertical(
          bottom: new Radius.elliptical(
              MediaQuery.of(context).size.width, MediaQuery.of(context).size.width*0.2),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQuery.of(navigatorKey.currentContext!).size.height/8);

}