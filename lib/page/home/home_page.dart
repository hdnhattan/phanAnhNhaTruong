import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_giay/constants/ui_constants.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/cretae_reflect/create_reflect.dart';



import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/profile_screen.dart';
import 'package:shop_giay/theme/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final idemail = getEmail();
  int _page = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCreateReflect() {
    Navigator.push(context, CreateReflectPage.route()).then((value) {
      setState(() {});
    });
  }

  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: UIConstants.appBar(),
      floatingActionButton: idemail != "admin@gmail.com"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, CreateReflectPage.route())
                    .then((value) {
                  setState(() {});
                });
              },
              child: Icon(
                Icons.add,
                color: Pallete.whiteColor,
                size: 28,
              ),
            )
          : SizedBox(),
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),

      bottomNavigationBar:
          BottomNavigationBar(currentIndex: _page, onTap: onPageChange, items: [
        BottomNavigationBarItem(
            label: "Home",
            icon: _page == 0
                ? Icon(
                    Icons.home,
                    color: Colors.white,
                  )
                : Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "Thông báo",
            icon: _page == 1
                ? Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )
                : Icon(Icons.notifications)),
        BottomNavigationBarItem(
            label: "Cá nhân",
            icon: _page == 2
                ? Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : Icon(Icons.person)),
      ]),
    );
  }
}
