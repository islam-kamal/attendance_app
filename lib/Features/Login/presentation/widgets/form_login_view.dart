import 'package:attendance_app_code/Features/BottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:attendance_app_code/Features/Login/presentation/bloc/login_bloc.dart';
import 'package:attendance_app_code/Features/Home/presentation/pages/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Base/common/navigtor.dart';
import '../../../../Base/common/shared.dart';
import '../../../../Base/common/theme.dart';
import '../../../../Base/utils/styles.dart';
import '../bloc/Helper/app_event.dart';
import '../bloc/Helper/app_state.dart';

class FormLoginView extends StatefulWidget {
  const FormLoginView({super.key});

  @override
  State<FormLoginView> createState() => _FormLoginViewState();
}

class _FormLoginViewState extends State<FormLoginView> {
  bool _isHidden = true;
  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: loginBloc,
      listener: (context, state) {
        if(state is Loading){
          Shared.showLoadingDialog(context: context);
        }
        else if(state is Done){
          Shared.dismissDialog(context: context);
          customAnimatedPushNavigation(context, IndexScreen(index: 0,));

        }
        else if(state is ErrorLoading){
          Shared.dismissDialog(context: context);
          Shared.showSnackBarView(
              error_status: true,
              backend_message:  "error ocured",
          );
        }
      },
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      controller: username_controller,
                      textAlign: TextAlign.right,
                      autocorrect: true,
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          decorationStyle: TextDecorationStyle.solid,
                          overflow: TextOverflow.ellipsis,
                          color: kBlackColor,
                        ),
                        labelText: 'عنوان البريد الإلكتروني',
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                      ),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      controller: password_controller,
                      textAlign: TextAlign.right,
                      obscureText: _isHidden,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "كلمة المرور",
                        labelStyle: TextStyle(
                          color: kBlackColor,
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: Shared.width,
                    height: Shared.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (username_controller.text.isEmpty) {
                          Shared.showSnackBarView(
                            message:  "Email is still empty!",
                            error_status: true
                          );
                        } else if (password_controller.text.isEmpty) {
                          Shared.showSnackBarView(
                            message: "Password is still empty!",
                              error_status: true

                          );

                        } else {
                          loginBloc.add(loginClickEvent(
                              username: username_controller.text,
                              password: password_controller.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 52, 30, 117),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الدخول',
                        style: Styles.textStyle16,
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
