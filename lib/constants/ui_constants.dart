import 'package:flutter/material.dart';
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
      title: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(200)),
          child: Image.network(
            "https://scontent.fdad3-4.fna.fbcdn.net/v/t39.30808-6/341545871_234721855771192_1011689951864723698_n.png?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=Ar0SOsz1fssAX90wHrI&_nc_ht=scontent.fdad3-4.fna&oh=00_AfByOU6zzyu-w4SOAEyCLwrQ5mxbwGFWXSRpEqh8CdM7Ww&oe=64673F2F",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  static List<Widget> bottomTabBarPages = [
    ReflectHomeScreen(),
    Text('1'),
    ProfileScreen(),
  ];
}
