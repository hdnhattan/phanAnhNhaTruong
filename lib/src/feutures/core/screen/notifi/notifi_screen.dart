import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/global/global.dart';

import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/accept_reflect/accrpt_reflect.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_detail_page.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/update_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:shop_giay/src/feutures/core/screen/widget/icon_and_text.dart';

class NotifiScreen extends StatefulWidget {
  const NotifiScreen({super.key});

  @override
  State<NotifiScreen> createState() => _NotifiScreenState();
}

class _NotifiScreenState extends State<NotifiScreen> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  List<dynamic> dataList = [];
  final idemail = getEmail();
  bool checkNotifi = true;
  // @override
  // void initState() {
  //   super.initState();

  //   final databaseReference =
  //       FirebaseDatabase.instance.reference().child("Users");

  //   databaseReference.onValue.listen((event) {
  //     Map<dynamic, dynamic> map = event.snapshot.value!;
  //     if (map != null) {
  //       dataList = map.values.toList();
  //       setState(() {});
  //     }
  //   });
  // }

  void delete(String id) {
    FirebaseFirestore.instance.collection("Reflect").doc(id).delete();
    AnimatedSnackBar.material(
      'Xóa phản ánh thành công!',
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {}, icon: Icon(LineAwesomeIcons.angle_left)),
          title: Text(
            "Thông báo",
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        // delete(snapshot.data![index].id!);
                        // setState(() {});
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'DELETE',
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      checkNotifi = !checkNotifi;
                    });
                    print("CHECKNOTIFI ==  $checkNotifi");
                  },
                  child: Container(
                    // width: 260,
                    height: 106,
                    decoration: BoxDecoration(
                      color: checkNotifi != true
                          ? Colors.lightGreen
                          : Color(0xFF656565),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Color(0x34000000),
                          offset: Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                          child: SizedBox(
                            child: Text(
                              'Thông báo phản ánh của bạn đã được tiếp nhận',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
                          child: SizedBox(
                            height: 50,
                            child: Text(
                              'Thông báo phản ánh của bạn đã được tiếp nhận',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                iconAndText(
                                    textStyle: TextStyle(fontSize: 12),
                                    size: 12,
                                    title: 'Thong bao',
                                    icon: LineAwesomeIcons.bookmark),
                                iconAndText(
                                    textStyle: TextStyle(fontSize: 12),
                                    size: 12,
                                    title: "12/12/12",
                                    icon: Icons.calendar_month),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.titile,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
  });

  final String titile;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  // final Color? textColor;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.lightBlue),
      ),
      title: Text(titile),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: Colors.grey),
              child: Icon(
                LineAwesomeIcons.angle_left,
                size: 18,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
