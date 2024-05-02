import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';

class DataSelectionWidget extends StatefulWidget{
  @override
  State<DataSelectionWidget> createState() => _DataSelectionWidgetState();
}

class _DataSelectionWidgetState extends State<DataSelectionWidget> {
  String _month = DateFormat('MMMM').format(DateTime.now());

  String _year = DateFormat('yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:   Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(top: 32),

        child: GestureDetector(
          onTap: () async {
            final selectedDate =
            await SimpleMonthYearPicker.showMonthYearPickerDialog(
                context: context,
                titleTextStyle: TextStyle(
                    color: kBlackColor
                ),
                selectionColor: kGreenColor,
                monthTextStyle: TextStyle(),
                yearTextStyle: TextStyle(),
                disableFuture:
                true // This will disable future years. it is false by default.
            );
      setState(() {
        // Use the selected date as needed
        print('Selected date: $selectedDate');
        _month = DateFormat('MMMM').format(selectedDate);
        _year = DateFormat('yyyy').format(selectedDate);
      });
          },
          child:   Material(
              elevation: 5,borderRadius: BorderRadius.circular(10),
              child: Container(
                  alignment: Alignment.center,
                  height: Shared.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kWhiteColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Shared.width * 0.15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios,
                          color: kGreenColor,size: 25,),

                        Text("${_month}  ${_year}",
                          style: TextStyle(color: kGreenColor,fontSize: 20
                              ,fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_forward_ios,
                          color: kGreenColor,size: 25,),
                      ],
                    ),
                  )
              )),


        ),
      ),

    );
  }
}