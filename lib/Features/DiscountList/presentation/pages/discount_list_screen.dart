import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../Base/common/shared.dart';
import '../../../Home/presentation/widgets/custom_app_bar.dart';

class DiscountListScreen extends StatefulWidget {
  @override
  _DiscountListScreenState createState() => _DiscountListScreenState();
}

class _DiscountListScreenState extends State<DiscountListScreen> {
  Stream<QuerySnapshot<Object?>>? employee_schedule_stream;
int? selected_index = 0;
  @override
  void initState() {
    super.initState();

    /*  WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      employee_schedule_stream = FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .collection("employee_schedule")
          .snapshots();
    });
*/
  }

  List<String> discount_list_status = ['اول مرة','ثانى مرة','متكرر'];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: kWhiteColor,
          appBar: CustomAppBar(
            title: 'لائحة الخصم',
            onPress: () {},
          ),
          body: Directionality(textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: kInactiveColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: Shared.width * 0.15,
                      child: ListView.builder(
                          itemCount: discount_list_status.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return  InkWell(
                              onTap: (){
                                setState(() {
                                  selected_index = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Shared.width /3,
                                decoration: BoxDecoration(
                                    color: selected_index == index ? kGreenColor : kInactiveColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(discount_list_status[index],
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                                    color: selected_index == index ? kWhiteColor : kBlackColor,),),
                              ),
                            );
                          })

                  ),
                  SizedBox(height: 20,),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Employee")
                        .doc(User.id)
                        .collection("employee_schedule")
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        if (snap.isNotEmpty) {
                          return  DataTable(
                            columns: [
                              DataColumn(
                                label: Text('Day'),
                              ),
                              DataColumn(
                                label: Text('Branch'),
                              ),
                            ],

                            headingTextStyle: TextStyle(
                                fontWeight: FontWeight.normal,fontSize: 20,color: kBlackColor),
                            border: TableBorder.all(
                                color: kBlackColor,
                                borderRadius: BorderRadius.circular(10)),
                            columnSpacing: Shared.width / 2,
                            sortAscending: true,
                            rows: [
                              ...List.generate(growable: true, snap.length,
                                      (index) {
                                    return DataRow(
                                      cells: [
                                        DataCell( Text(snap[index]['day'],),

                                        ),
                                        DataCell( Text(snap[index]['branchName']
                                          ,maxLines: 5,)),
                                      ],
                                    );
                                  })
                            ],

                            dataTextStyle: TextStyle(
                                fontWeight: FontWeight.normal,fontSize: 20,color: kBlackColor),
                          );
                        } else {
                          return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Shared.width / 2),
                                child: const Text(
                                  "There Is No Data",
                                  style: TextStyle(
                                    fontFamily: "NexaRegular",
                                    fontSize: 20,
                                    color: Colors.black54,
                                  ),
                                ),
                              ));
                        }
                      } else {
                        return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Shared.width / 2),
                              child: const Text(
                                "There Is No Data",
                                style: TextStyle(
                                  fontFamily: "NexaRegular",
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                              ),
                            ));
                      }
                    },
                  )
                ],
              ) ),
        ));
  }
}
