import 'package:attendance_app_code/Base/common/theme.dart';
import 'package:attendance_app_code/Base/utils/styles.dart';
import 'package:flutter/material.dart';


class TimesOfWorkListView extends StatefulWidget{
  final int dayNumber ;
  final int index ;
  final String dayName;
  TimesOfWorkListView({required this.dayNumber, required this.dayName,required this.index});

  @override
  State<TimesOfWorkListView> createState() => TimesOfWorkListViewState();
}

class TimesOfWorkListViewState extends State<TimesOfWorkListView> {
  final clicked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          setState(() {
            clicked != clicked;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Container(

            width: MediaQuery.of(context).size.width * 0.21,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(11),
              color: clicked ? kGreenColor : kWhiteColor,
            ),
            child:  Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.dayNumber.toString(),style: Styles.textStyle24,),
                  Text(widget.dayName,style: Styles.textStyle16,),
                ],
              ),
            ),

          ),
        ));
  }
}