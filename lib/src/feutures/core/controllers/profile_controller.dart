import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/repository/authentication_repository/authentication_repository.dart';
import 'package:shop_giay/src/repository/user_repository/user_respository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  // var myUser = UserModel(

  // ).obs;

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.allUser();
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}
