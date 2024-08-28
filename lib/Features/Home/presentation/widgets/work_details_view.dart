import 'package:flutter/material.dart';

import '../../../../Base/utils/styles.dart';

class WorkDetailsView extends StatelessWidget{
   WorkDetailsView({required this.checkIn, required this.checkOut});
  final String checkIn;
  final String checkOut;
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/countdown.png',
                color: Colors.white,
                ),
                const SizedBox(
                  height: 7,
                ),
                 Text(
                  '08h00m',
                  style: Styles.textStyle14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                  ),
                Text(
                  'ساعات العمل ',
                  style: Styles.textStyle14.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
                  ),
              ],
            ),

            Column(
              children: [
                Image.asset(
                  'assets/images/afternoon.png',
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 7,
                ),
                 Text(
                 checkOut, //'05:30',
                  style: Styles.textStyle14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                  ),
                Text(
                  'وقت الانصراف',
                  style: Styles.textStyle14.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
                  ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/clock.png',
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  checkIn, //  '07:00',
                  style: Styles.textStyle14.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'وقت الحضور',
                  style: Styles.textStyle14.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
         );
  }
}