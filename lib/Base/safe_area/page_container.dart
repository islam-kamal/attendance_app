import 'dart:io';

import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:flutter/material.dart';


class PageContainer extends StatelessWidget {
  final Widget? child;
  const PageContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Platform.isIOS ? kWhiteColor : kGreenColor,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child,
          ),
        ));
  }
}
