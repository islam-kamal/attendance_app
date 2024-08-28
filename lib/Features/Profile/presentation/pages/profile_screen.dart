import 'package:attendance_app_code/Base/common/shared_preference_manger.dart';
import 'package:attendance_app_code/Features/Authentication/presentation/pages/login_screen.dart';
import 'package:attendance_app_code/Features/Home/presentation/pages/homescreen.dart';
import 'package:attendance_app_code/Features/BottomNavigationBar/custom_app_bar.dart';
import 'package:attendance_app_code/main.dart';
import 'package:attendance_app_code/model/user.dart';
import 'package:flutter/material.dart';
import '../../../../Base/common/navigtor.dart';
import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

/*
  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance
        .ref().child("${User.employeeId.toLowerCase()}_profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        User.profilePicLink = value;
      });

      await FirebaseFirestore.instance.collection("Employee").doc(User.id).update({
        'profilePic': value,
      });
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'الملف الشخصى',
            icon: InkWell(
                onTap: () {
                  customAnimatedPushNavigation(context, HomeScreen());
                } ,
                child: Icon(Icons.arrow_back_ios)),
          ),
        body:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
           child: Column(
             children: [
                Container(
                   margin:  EdgeInsets.only(top: Shared.width * 0.1,),
                   height:  Shared.width * 0.3,
                   width:  Shared.width * 0.3,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: User.profilePicLink == " " ?  kPrimaryColor : Colors.transparent,
                   ),
                   child: Center(
                     child: User.profilePicLink == " " ? const Icon(
                       Icons.person,
                       color: Colors.white,
                       size: 80,
                     ) : ClipRRect(
                       borderRadius: BorderRadius.circular(20),
                       child: Image.network(User.profilePicLink,fit: BoxFit.fill,),
                     ),
                   ),
                 ),

               const SizedBox(height: 24,),
               field("User Name", User.username),
               field("Email", User.email),
               field("Phone", User.phone),
               Padding(
                 padding:  EdgeInsets.symmetric(vertical: Shared.width * 0.05),
                 child: SizedBox(
                   width: Shared.width * 0.8,
                   height: Shared.width * 0.15,
                   child:  OutlinedButton(
                     onPressed: () async {
                       sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
                       sharedPreferenceManager.removeData(CachingKey.USER_NAME);
                       sharedPreferenceManager.removeData(CachingKey.USER_ID);
                       sharedPreferenceManager.removeData(CachingKey.EMAIL);
                       sharedPreferenceManager.removeData(CachingKey.MOBILE_NUMBER);
                       sharedPreferenceManager.removeData(CachingKey.START_TIME);
                       sharedPreferenceManager.removeData(CachingKey.END_TIME);
                       customAnimatedPushNavigation(
                           navigatorKey.currentContext!, LoginScreen());
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: kRedColor,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(11),
                           side: BorderSide(color: kRedColor)
                       ),

                     ) ,
                     child:  Text(
                         "تسجيل الخروج",
                         style: TextStyle(color: kWhiteColor, fontSize: 18,
                           fontWeight: FontWeight.bold,)
                     ),
                   ),
                 ),
               ),
             ],
           ),
        )



      ),
    );
  }


  Widget field(String title, String text) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "Cairo",
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          height: kToolbarHeight,
          width: Shared.width,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.only(left: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: "Cairo",
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textField(String title, String hint, TextEditingController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "Cairo",
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: "Cairo",
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
        ),
      ),
    );
  }

}
