import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Features/Attendance_Table/presentation/pages/attendance_tabel_screen.dart';
import 'package:attendance_app_code/Features/PenaltyList/presentation/pages/penalty_list_screen.dart';
import 'package:attendance_app_code/Features/TaskTable/presentation/pages/tasks_table_screen.dart';
import 'package:attendance_app_code/Features/Home/presentation/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';





class IndexScreen extends StatefulWidget {
  int index;
  IndexScreen({ required this.index});
  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int? current_index ;
  @override
  void initState() {
     current_index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller = PersistentTabController(initialIndex: current_index!);

    List<PersistentBottomNavBarItem> _navBarsItems = [
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.3, // Adjust the scale as needed to increase the size
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
/*      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.3, // Adjust the scale as needed to increase the size
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
      ),*/
      PersistentBottomNavBarItem(

        icon: Transform.scale(
            scale: 1.3, // Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/task.png"),
                  color: current_index == 1 ? kGreenColor  : kBlackColor
              ),
            )),
        title: ("جدول المهام"),
        activeColorPrimary: Color(0xFF01D9AC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.3,// Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/clipboard-close.png"),
                  color: current_index == 2 ? kGreenColor  : kBlackColor
              ),
            )),
        title: ("لائحة الخصم"),
        activeColorPrimary: Color(0xFF01D9AC),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Transform.scale(
            scale: 1.3, // Adjust the scale as needed to increase the size
            child:Padding(
              padding: EdgeInsets.all(5),
              child:  ImageIcon(
                  AssetImage("assets/images/user-tick.png"),
                  color: current_index == 3 ? kGreenColor  : kBlackColor
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
        //NotificationsScreen(),
        TasksTableScreen(),
        PenaltyListScreen(),
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
