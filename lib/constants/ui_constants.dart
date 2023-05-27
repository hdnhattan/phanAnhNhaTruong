import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_giay/src/feutures/core/screen/notifi/notifi_screen.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/profile_screen.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/home_reflect.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/list_reflect_accept.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/list_reflect_no_process.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_all_home/all_reflect_home.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: Center(child: Text("Phản Ánh Nhà Trường")),
    );
  }

  static AppBar appBarLogin() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        child: Image.asset(
          "assets/logo_dhkhh.png",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    ReflectHomeScreen(),
    NotifiScreen(),
    ProfileScreen(),
  ];
}
