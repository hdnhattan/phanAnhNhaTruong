import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shop_giay/src/feutures/authentication/controller/sigup_controller.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    String levelUser = "user";
    final _fromKey = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.all(8),
      child: Form(
          key: _fromKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: InputDecoration(
                    label: Text("Full Name"),
                    prefixIcon: Icon(Icons.person_outline_rounded)),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.email,
                decoration: InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.phoneNo,
                decoration: InputDecoration(
                    label: Text("Phone"), prefixIcon: Icon(Icons.numbers)),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.password,
                decoration: InputDecoration(
                    label: Text("Pass"), prefixIcon: Icon(Icons.fingerprint)),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
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

                        SignUpController.instance.createUser(user);
                      }
                    },
                    child: Text("DANG KY")),
              )
            ],
          )),
    );
  }
}
