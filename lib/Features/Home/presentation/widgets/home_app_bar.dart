import 'package:flutter/material.dart';

import '../../../../Base/utils/styles.dart';

class HomeAppBar extends StatelessWidget{
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      child: Expanded(
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(

              onPressed: (){},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 34,
              ),
            ),

            Row(
              children: [
                Column(

                  children: [
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      'محمد على',
                      style: Styles.textStyle16.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Opacity(
                      opacity: 0.9,
                      child: Text(
                        'مصمم واجهات',
                        style: Styles.textStyle14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Image.asset('images/img.png'),

              ],
            )


          ],
        ),
      )
      ,
    );
  }
}