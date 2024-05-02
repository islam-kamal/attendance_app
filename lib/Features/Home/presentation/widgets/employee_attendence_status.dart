import 'package:flutter/cupertino.dart';

import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';

class EmployeeAttendenceStatus extends StatelessWidget {
  final int status;
  EmployeeAttendenceStatus({required this.status});
  @override
  Widget build(BuildContext context) {
    return emp_status(status: status);
  }

  Widget emp_status({int? status}) {
    switch (status) {
      case 0: // when employee attend to work on time
        return Container(
          width: Shared.width * 0.35,
          height: Shared.width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 168, 244, 228),
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                'حضرت',
                style: TextStyle(
                    color: kGreenColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'في الموعد المحدد',
              ),
            ],
          ),
        );
        break;
      case 1: // before employee attend to work
        return Container(
          width: 135,
          height: 138,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                kWhiteColor,
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                'متبقي5:26 دقائق',
                style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(' علي موعد الحضور'),
            ],
          ),
        );
        break;
      case 2: // when employee attend to work later
        return Container(
          width: 135,
          height: 138,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 226, 113, 113),
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                'تأخير',
                style: TextStyle(
                    color: kRedColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'عن الموعد المحدد',
              ),
            ],
          ),
        );
        break;
      default: // before employee attend to work
        return Container(
          width: 135,
          height: 138,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                kWhiteColor,
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/3dicons.png',
              ),
              Text(
                'متبقي5:26 دقائق',
                style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(' علي موعد الحضور'),
            ],
          ),
        );
    }
  }
}
