import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../Base/common/shared.dart';
import '../../../BottomNavigationBar/custom_app_bar.dart';

class DiscountListScreen extends StatefulWidget {
  @override
  _DiscountListScreenState createState() => _DiscountListScreenState();
}

class _DiscountListScreenState extends State<DiscountListScreen> {
  Stream<QuerySnapshot<Object?>>? employee_schedule_stream;
int? selected_index = 0;


  List<String> discount_list_status = ['اول مرة','ثانى مرة','متكرر'];
  List<DiscountData> discount_data_list = [
    DiscountData(
      influences: "تاخير 30 دقيقة",
      first_time: "-",
      second_time: "خصم نصف يوم",
      third_time: "خصم يوم"
    ),
    DiscountData(
        influences: "تاخير 60 دقيقة",
        first_time: "خصم يوم",
        second_time: "خصم يومين",
        third_time: "خصم 3 ايام"
    ),
    DiscountData(
        influences:"تاخير 180 دقيقة",
        first_time: "خصم 3 ايام",
        second_time: "انذار اول",
        third_time: "انذار ثانى"
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: kWhiteColor,
          appBar: CustomAppBar(
            title: 'لائحة الخصم',
          ),
          body: Directionality(textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: kInactiveColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))
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
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Text(discount_list_status[index],
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                                    color: selected_index == index ? kWhiteColor : kBlackColor,),),
                              ),
                            );
                          })

                  ),

                  SizedBox(height: 20,),


             DataTable(
                         columns: [
                           DataColumn(
                             label: Expanded(
                                 child: Text(
                                   'الموثرات',
                                   textAlign: TextAlign.center,
                                 )),
                           ),
                           DataColumn(
                             label: Expanded(
                           child: Text(selected_index == 0 ? 'اول مرة'
                                 : selected_index == 1 ? 'ثانى مرة' : 'متكرر',
                             textAlign: TextAlign.center,),

                        )  ),
                         ],

                         headingTextStyle: TextStyle(
                             fontWeight: FontWeight.bold,fontSize: 20,color: kBlackColor),
                         border: TableBorder.all(
                             color: kBlackColor,
                             borderRadius: BorderRadius.circular(10)),
                         columnSpacing: 0,
                         sortAscending: true,
                         rows: [
                           ...List.generate(growable: true, discount_data_list.length,
                                   (index) {
                                 return DataRow(
                                   cells: [
                                     DataCell(  Center(child: Text(discount_data_list[index].influences,),
                                     )
                                     ),
                                     DataCell(   Center(child:Text(selected_index == 0 ? discount_data_list[index].first_time :
                                     selected_index == 1 ? discount_data_list[index].second_time
                                         : discount_data_list[index].third_time
                                       ,maxLines: 5,
                                    ))),
                                   ],
                                 );
                               })
                         ],

                         dataTextStyle: TextStyle(
                             fontWeight: FontWeight.normal,fontSize: 20,color: kBlackColor),
                       )



              /*    StreamBuilder<QuerySnapshot>(
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
                                    fontFamily: "Cairo",
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
                                  fontFamily: "Cairo",
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                              ),
                            ));
                      }
                    },
                  )*/
                ],
              ) ),
        ));
  }
}

class DiscountData {
  final String influences;
  final String first_time;
  final String second_time;
  final String third_time;
  DiscountData({required this.influences,required this.first_time,required this.second_time,required this.third_time});
}
