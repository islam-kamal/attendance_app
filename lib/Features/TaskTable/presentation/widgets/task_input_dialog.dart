import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:uuid/uuid.dart';

import '../../../../Base/common/shared.dart';
import '../../../../model/user.dart';

class TaskInputDialog extends StatelessWidget{
  TextEditingController header_controller = new TextEditingController();
  TextEditingController description_controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                  child:   TextField(
                    controller: header_controller,

                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                        hintText: "ادخل العنوان"
                    ),
                    onChanged: (value) {},
                  ) ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child:    TextField(
                  controller: description_controller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                      hintText: "ادخل التفاصيل"),
                  keyboardType: TextInputType.text,
                  maxLines: 8,
                  onChanged: (value) {
                  },
                ),)
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () async {
                // Do something with name and age
                QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection("Employee")
                    .where('id', isEqualTo: User.employeeId)
                    .get();
                await FirebaseFirestore.instance
                    .collection("Employee")
                    .doc(snap.docs[0].id)
                    .collection("Tasks")
                    .doc(Uuid().v4())
                    .set({
                  'date': Shared.task_selected_date, //Timestamp.now(),
                  'header': header_controller.text,
                  'description':description_controller.text,
                  'status': false
                });
                Navigator.of(context).pop();
              },
              child: Text('تدوين',
                style: TextStyle(color: kGreenColor),),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('أغلاق',
              style: TextStyle(color: kRedColor),),
            ),


          ],
        ));

  }

}