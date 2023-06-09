import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shop_giay/src/feutures/authentication/controller/sigup_controller.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    String levelUser = "user";
    bool _passwordVisible = false;
    // TextEditingController repass = TextEditingController();

    final _fromKey = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.all(8),
      child: Form(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: TextFormField(
              controller: controller.fullName,
              obscureText: false,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.person_outline_rounded),
                labelText: 'Họ và tên' /* Email Address */,
                hintText: 'Họ và tên' /* Enter your email... */,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),
          // TextFormField(
          //   controller: controller.email,
          //   decoration: InputDecoration(
          //       label: Text("Email"),
          //       prefixIcon: Icon(Icons.email_outlined)),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: TextFormField(
              controller: controller.email,
              obscureText: false,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email_outlined),
                labelText: 'Email' /* Email Address */,
                hintText: 'Email' /* Enter your email... */,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: TextFormField(
              controller: controller.phoneNo,
              obscureText: false,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.phone),
                labelText: 'Số điện thoại' /* Email Address */,
                hintText: 'Số điện thoại' /* Enter your email... */,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: TextFormField(
              controller: controller.password,
              obscureText: false,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock),
                labelText: 'Mật khẩu' /* Email Address */,
                hintText: 'Mật khẩu' /* Enter your email... */,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: TextFormField(
              controller: controller.repass,
              obscureText: false,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock),
                labelText: 'Nhập lại mật khẩu' /* Email Address */,
                hintText: 'Nhập lại mật khẩu' /* Enter your email... */,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),

          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(
                    MediaQuery.of(context).size.width / 2.5, 50), //////// HERE
              ),
              onPressed: () async {
                if (controller.email.text.trim() == null ||
                    controller.email.text.trim() == "") {
                  AnimatedSnackBar.material(
                    'Chưa nhập email!',
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                  print("not login");
                } else if (controller.password.text.trim() == null ||
                    controller.password.text.trim() == "") {
                  AnimatedSnackBar.material(
                    'Chưa nhập mật khẩu!',
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                } else if (controller.repass.text !=
                        controller.password.text.trim() ||
                    controller.repass.text == "") {
                  AnimatedSnackBar.material(
                    'Nhập lại mật khẩu không chính xác',
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                } else {
                  SignUpController.instance.registerUser(
                      controller.email.text.trim(),
                      controller.password.text.trim());
                  final user = UserModel(
                    fullName: controller.fullName.text.trim(),
                    email: controller.email.text.trim(),
                    phoneNo: controller.phoneNo.text.trim(),
                    password: controller.password.text.trim(),
                    level: levelUser,
                  );

                  await SignUpController.instance
                      .createUser(user)
                      .then((value) {
                    AnimatedSnackBar.material(
                      'Đăng ký thành công',
                      type: AnimatedSnackBarType.success,
                      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    ).show(context);
                    controller.fullName.text = "";
                    controller.email.text = "";
                    controller.phoneNo.text = "";
                    controller.password.text = "";
                    controller.repass.text = "";
                  });
                }
              },
              child: Text(
                "ĐĂNG KÝ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
        ],
      )),
    );
  }
}
