import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/utils/styles.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(Shared.width * 0.2);
}

class _HomeAppBarState extends State<HomeAppBar> {
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
       IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage("assets/images/notification.png"),
                color: kWhiteColor,
              )
       ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'محمد على',
                        style: Styles.textStyle16.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          'مصمم واجهات',
                          style: Styles.textStyle14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset('assets/images/profile_img.png'),
              )
            ],
          )
        ],
      ),
    );
  }


}
