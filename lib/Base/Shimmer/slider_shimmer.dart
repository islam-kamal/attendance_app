import 'package:attendance_app_code/Base/common/shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/theme.dart';
class SliderSimmer extends StatefulWidget {
  @override
  _SliderSimmerState createState() => _SliderSimmerState();
}

class _SliderSimmerState extends State<SliderSimmer> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(
          Shared.width, Shared.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.grey[350]!,
          child: Container(
            height:Shared.height,
            width: Shared.width ,
            decoration: BoxDecoration(
                color: kGreenColor, borderRadius: BorderRadius.circular(10.0)),
          ),
        );
      },
    );

  }
}
