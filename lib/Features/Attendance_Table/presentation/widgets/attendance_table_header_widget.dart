import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';

class AttendanceTableHeaderWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Padding(padding: EdgeInsets.all(10),
      child:  Material(
          elevation: 5,borderRadius: BorderRadius.circular(10),
          child: Container(
              alignment: Alignment.center,
              height: Shared.width * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kWhiteColor),
              ),
              child: DataTable(
                columnSpacing: Shared.width * 0.08,
                columns: [
                  DataColumn(
                    label: Expanded(child: Text('التاريخ',
                      style: TextStyle(fontWeight: FontWeight.bold),),),
                  ),
                  DataColumn(
                    label: Expanded(child:Text('تسجيل الوصول',  style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  DataColumn(
                    label: Expanded(child:Text('تسجيل المغادرة',  style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  DataColumn(
                    label:Expanded(child: Text('الحالة',  style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ], rows: [],)
          )),);
  }

}