import 'dart:async';
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Features/Authentication/presentation/pages/login_screen.dart';
import 'package:attendance_app_code/Features/BottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Base/common/navigtor.dart';
import '../../../../Base/common/shared.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences sharedPreferences;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      Shared.device_token = token!;
      print("Device Token: $token");
    });
    super.initState();
    authetication_fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/reportLogo1.png"),
      ),
    );
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      bool isExpired = JwtDecoder.isExpired(
          await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      DateTime? expirationDate = JwtDecoder.getExpirationDate(
          await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      print("isExpired : ${isExpired}");
      print("expirationDate : ${expirationDate}");

      if (sharedPreferenceManager.readString(CachingKey.USER_NAME) != null && !isExpired) {
        User.username = await sharedPreferenceManager.readString(CachingKey.USER_NAME);
        customAnimatedPushNavigation(
            context,
            IndexScreen(
              index: 0,
            ));
      } else {
        customAnimatedPushNavigation(context, const LoginScreen());
      }
    } catch (e) {
      customAnimatedPushNavigation(context, const LoginScreen());
    }
  }

  void authetication_fun() {
    Timer(Duration(seconds: 2), () async {
      try {
        _getCurrentUser();
      } catch (e) {
        _getCurrentUser();
      }
    });
  }
}
