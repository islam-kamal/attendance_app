import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/Attendance_Table/presentation/pages/attendance_tabel_screen.dart';
import 'package:attendance_app_code/Features/DiscountList/presentation/pages/discount_list_screen.dart';
import 'package:attendance_app_code/Features/Notifications/presentation/pages/notifications_screen.dart';
import 'package:attendance_app_code/Features/Whatsapp_Chatbot/whatsapp_chatbot_screen.dart';
import 'package:attendance_app_code/homescreen.dart';
import 'package:attendance_app_code/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';





class IndexScreen extends StatefulWidget {
  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
   int current_index = 0;

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller = PersistentTabController(initialIndex: 0);

    List<PersistentBottomNavBarItem> _navBarsItems = [
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.5, // Adjust the scale as needed to increase the size
          child:Padding(
            padding: EdgeInsets.all(5),
            child:  ImageIcon(
                AssetImage("assets/images/home.png"),
                color: current_index == 0 ? kGreenColor  : kBlackColor
            ),
          )),
        title: "الرئيسية",
        activeColorPrimary: Color(0xFF01D9AC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.5, // Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/notifications.png"),
                  color: current_index == 1 ? kGreenColor  : kBlackColor
              ),
            )),
        title: ("الأشعارات"),
        activeColorPrimary:Color(0xFF01D9AC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(

        icon: Transform.scale(
            scale: 1.5, // Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/task.png"),
                  color: current_index == 2 ? kGreenColor  : kBlackColor
              ),
            )),
        title: ("جدول المهام"),
        activeColorPrimary: Color(0xFF01D9AC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.5,// Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/clipboard-close.png"),
                  color: current_index == 3 ? kGreenColor  : kBlackColor
              ),
            )),
        title: ("لائحة الخصم"),
        activeColorPrimary: Color(0xFF01D9AC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.5, // Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/user-tick.png"),
                  color: current_index == 4 ? kGreenColor  : kBlackColor
              ),
            )),
        title: ("الحضور"),
        activeColorPrimary: kGreenColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];

    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        NotificationsScreen(),
        DiscountListScreen(),
        WhatsappChatbotScreen(),
        AttendanceTableScreen(),
      ];
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        onItemSelected: (index){

         setState(() {
           current_index = index;
           print("current_index: ${current_index}");
         });
      },
        items: _navBarsItems,
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        navBarHeight: 80.0,
        navBarStyle: NavBarStyle.style3,

      ),
    );
  }
}
