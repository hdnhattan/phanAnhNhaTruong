import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_all_home/all_reflect_home.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_detail_page.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/update_profile_screen.dart';
import 'package:shop_giay/src/feutures/core/screen/widget/icon_and_text.dart';
import 'package:shop_giay/src/utils/file_utils.dart';
import 'package:intl/intl.dart';

class ListReflectUserScreen extends StatefulWidget {
  const ListReflectUserScreen({super.key});

  @override
  State<ListReflectUserScreen> createState() => _ListReflectUserScreenState();
}

class _ListReflectUserScreenState extends State<ListReflectUserScreen> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  List<dynamic> dataList = [];
  final _unfocusNode = FocusNode();
  final idemail = getEmail();
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

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {}, icon: Icon(LineAwesomeIcons.angle_left)),
      //   title: Text(
      //     "Trang phan anh",
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
      //   ],
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(12),
          child: FutureBuilder<List<ReflectModel>>(
            future: idemail != "admin@gmail.com"
                ? controller.getAllReflectUserSucc()
                : controller.getAllReflectAcceptAdmin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.parse(
                          snapshot.data![index].createdAt!.toDate().toString());
                      String formatedDate = DateFormat.yMd().format(date);
                      String file =
                          getFileName("${snapshot.data?[index].media?[0]}");
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReflectDetailPage(
                                        reflect: snapshot.data![index],
                                      )),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            // width: 260,
                            height: 106,
                            decoration: BoxDecoration(
                              color: Color(0xFF656565),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6,
                                  color: Color(0x34000000),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                isImageFromPath(file.split('.').last)
                                    ? Container(
                                        width: 100,
                                        height: 106,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              "${snapshot.data![index].media![0]}",
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFF656565),
                                            width: 0.5,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Container(
                                          width: 100,
                                          height: 106,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/video.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                Column(
                                  // mainAxisSize: MainAxisSize.max,
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 8, 0, 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Text(
                                          '${snapshot.data![index].title}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 5, 0, 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        height: 50,
                                        child: Text(
                                          '${snapshot.data![index].content}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: [
                                            iconAndText(
                                                textStyle:
                                                    TextStyle(fontSize: 12),
                                                size: 12,
                                                title:
                                                    '${snapshot.data![index].category}',
                                                icon:
                                                    LineAwesomeIcons.bookmark),
                                            iconAndText(
                                                textStyle:
                                                    TextStyle(fontSize: 12),
                                                size: 12,
                                                title: formatedDate,
                                                icon: Icons.calendar_month),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
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
