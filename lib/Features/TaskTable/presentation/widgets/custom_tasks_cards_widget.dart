import 'package:attendance_app_code/Features/TaskTable/presentation/widgets/task_input_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';
import '../../../../Base/utils/styles.dart';
import '../../../../model/user.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Employee')
            .doc(User.id)
            .collection("Tasks")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Column(
            children: [
           Directionality(textDirection: TextDirection.ltr,
               child:    Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(onPressed: (){
                       showDialog(context: context,
                           builder: (_) => TaskInputDialog(
                           ));


                     },
                         icon: const Icon(
                           Icons.add,
                           size: 28,
                         )),
                     Column(
                       children: [
                         Text(
                             'مهام اليوم',
                             style: Styles.textStyle28),
                          Opacity(
                             opacity: 0.9,
                             child: Text(
                               "${snapshot.data!.docs.where((document){

                                 Timestamp timestamp = document['date'] as Timestamp;
                                 DateTime dateTime = timestamp.toDate();
                                 return (dateTime.day == Shared.task_selected_date.day);
                               }).length.toString()}  مهام هذا اليوم",
                               style: Styles.textStyle16,
                             )),
                       ],
                     )
                   ],
                 ),
               )),
                Container(
                  height: Shared.width,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      Timestamp timestamp = data['date'] as Timestamp;
                      DateTime dateTime = timestamp.toDate();

                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Shared.task_selected_date.day == dateTime.day
                              ? Card(
                            color: kInactiveColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                            child: ListTile(
                              title: Text(
                                data['header'],
                                style: Styles.textStyle16.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: data['status']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () async {
                                  data['status'] = !data['status'];
                                  await FirebaseFirestore.instance
                                      .collection("Employee")
                                      .doc(User.id)
                                      .collection("Tasks")
                                      .doc(document.id)
                                      .update({
                                    'status': data['status']
                                  });
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: data['status']
                                              ? kGreenColor
                                              : kBlackColor),
                                      color: data['status']
                                          ? kGreenColor
                                          : kInactiveColor),
                                  child: data['status']
                                      ? Icon(Icons.check,
                                      size: 20, color: kWhiteColor)
                                      : null,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['description'],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage("assets/images/calendar.png"),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                            "${intl.DateFormat.EEEE('ar').format(dateTime)} , ${intl.DateFormat('dd MMMM yyyy', 'ar').format(dateTime)} "),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                            ),
                          )
                              : Container());
                    }).toList(),
                  ),
                ),

            ],
          );
        },
      ),
    );
  }


}
