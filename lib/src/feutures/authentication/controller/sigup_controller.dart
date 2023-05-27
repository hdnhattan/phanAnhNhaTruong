import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/repository/authentication_repository/authentication_repository.dart';
import 'package:shop_giay/src/repository/user_repository/user_respository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final repass = TextEditingController();
  // final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    // phoneAuthentication(user.phoneNo!);
  }

  Future<void> createUserDetail(UserModel user) async {
    await userRepo.createUserDetail(user);
    // phoneAuthentication(user.phoneNo!);
  }
  //  void phoneAuthentication(String phoneNo){
  //   AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  // }
}
