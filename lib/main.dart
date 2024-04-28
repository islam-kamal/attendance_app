import 'dart:io';

import 'package:attendance_app_code/Base/Notifications/local_notification_service.dart';
import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Base/database/notifications_db.dart';
import 'package:attendance_app_code/Features/BottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:attendance_app_code/Features/Notifications/presentation/pages/notifications_screen.dart';
import 'package:attendance_app_code/homescreen.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Features/Login/presentation/pages/login_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalizeAndTranslate.init(
    defaultType: LocalizationDefaultType.device,
    supportedLanguageCodes: <String>['ar', 'en'],
    assetLoader: AssetLoaderRootBundleJson(
      'assets/i18n/',
    ),

  );
  await ScreenUtil.ensureScreenSize();

  /// maintain the push message if the application is closed
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp( MyApp());
}

class MyApp extends StatefulWidget{
  static var app_langauge;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  Locale? local;
  Key? key = UniqueKey();
  void restartApp() {
    setState(() {
      get_Static_data();
      key = UniqueKey();
    });
  }

  void get_Static_data() async {
    await sharedPreferenceManager.readString(CachingKey.APP_LANGUAGE).then((value) {
      if (value == '') {
        MyApp.app_langauge = LocalizeAndTranslate.getLanguageCode();
      } else {
        MyApp.app_langauge = value;
      }
    });
    String? device_token = await FirebaseMessaging.instance.getToken();
    sharedPreferenceManager.writeData(CachingKey.DEVICE_TOKEN, device_token);
  }

  @override
  void initState() {
    super.initState();
    get_Static_data();
    _fcmConfigure(context);

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    navigatorKey: navigatorKey,
    title: 'Flutter Demo',
    theme: ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'DINNextLTArabic'
    ),
    home: LocalizedApp(
    child:const KeyboardVisibilityProvider(
    child: AuthCheck(),
    ) ),

    locale: local,
    supportedLocales: LocalizeAndTranslate.getLocals(),

    localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
    ],

    );
    });
  }

  Future<void> _fcmConfigure(BuildContext context) async {
    LocalNotificationService.initialize(context);
    final _firebaseMessaging = FirebaseMessaging.instance;


    String? device_token = await FirebaseMessaging.instance.getToken();

    sharedPreferenceManager.writeData(CachingKey.DEVICE_TOKEN, device_token);

    ///required by IOS permissions
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // //get the current device token
    // _getCustomerNotification();

    ///gives you the message on which use taps
    ///and it opened from the terminated state
    _firebaseMessaging.getInitialMessage().then((message) async {
      // get the remote message when your app opened from push notification while in background state
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

// check if it is exists
      if (initialMessage != null) {
        // check the data property within RemoteMessage and do navigate based on it
        final routeMessage = initialMessage.data['Type'];
        switch (routeMessage) {
          case "Notification":
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>NotificationsScreen()
            ));
            break;
        }
      }
    });

    ///app open on ForeGround. notification will not be visibile but you will receive the data
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
        NotificationsDatabase.saveNotification(
            header: message.notification?.title ?? '',
            description: message.notification?.body ?? '',
            timeStamp: message.sentTime.toString()
        );
      }

      if (message != null) {
        final routeMessage = message.data['Type'];
        switch (routeMessage) {
          case "Notification":
            Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
                builder: (BuildContext context) =>NotificationsScreen()
            ));
            break;
        }
      }
    });

    ///app in background and not terminated when you click on the notification this should be triggered
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        final routeMessage = message.data['Type'];
        switch (routeMessage) {
          case "Notification":
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>NotificationsScreen()
            ));
            break;
        }
      }

    });

    FirebaseMessaging.onBackgroundMessage((message)async{
      await Firebase.initializeApp();

      if (message != null) {
        final routeMessage = message.data['Type'];
        switch (routeMessage) {
          case "Notification":
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>NotificationsScreen()
            ));
            break;
        }
      }
    });

  }

}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return  userAvailable ?  IndexScreen() : const LoginScreen();
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if(sharedPreferences.getString('employeeId') != null) {
        setState(() {
          User.employeeId = sharedPreferences.getString('employeeId')!;
          userAvailable = true;
        });
      }
    } catch(e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (message != null) {
    final routeMessage = message.data['Type'];
      switch (routeMessage) {
        case "Notification":
          Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
              builder: (BuildContext context) =>NotificationsScreen()
          ));
          break;
      }

  }
}
