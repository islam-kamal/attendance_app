import 'package:flutter/material.dart';
import '../../../../Base/utils/styles.dart';
import 'form_login_view.dart';

class LoginViewBody extends StatelessWidget{
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  WillPopScope(
      onWillPop: ()async=>false,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 72,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/reportLogo1.png')),
              const SizedBox(height: 28,),
              const Text(
                '👋 مرحبًا بعودتك',
                style: Styles.textStyle28,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                'أبنائي',
                style: Styles.textStyle28.copyWith(
                  color: const Color(0xff01DAAD),
                  fontWeight: FontWeight.bold
                ),
                ),
                    const Text(
                ' إلي',
                style: Styles.textStyle28,
                ),
                  ],
                ),
                const SizedBox(height: 8,),
                const Opacity(
                  opacity: 0.3,
                  child: Text('مرحبًا بك، قم بتسجيل الدخول للمتابعة',style: Styles.textStyle16,)),
                  const SizedBox(height: 26,),
                  const FormLoginView(),
          ],
            ),
        ),
      ),
          )
      )],

      ),
    );

    
    
  }
}

