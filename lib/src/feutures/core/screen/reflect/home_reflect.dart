import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/constants/ui_constants.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/cretae_reflect/create_reflect.dart';

import 'package:shop_giay/page/home/component/tweet_icon.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_detail_page.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/update_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/video_reflect/video_no_player.dart';
import 'package:shop_giay/src/utils/file_utils.dart';
import 'package:shop_giay/theme/pallete.dart';

class ReflectHome extends StatefulWidget {
  const ReflectHome({super.key});

  @override
  State<ReflectHome> createState() => _ReflectHomeState();
}

class _ReflectHomeState extends State<ReflectHome> {
  final controller = Get.put(ReflectController());

  ReflectModel? reflect;
  UserModel? user;
  DocumentReference? likesRef;
  bool like = false;

  Map<String, dynamic>? data;

  String getFileName(String url) {
    RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);

    return Uri.decodeFull(match.group(2)!);
  }

  List<DocumentSnapshot> _data = [];

  Future<void> _getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Reflect')
        .where("Handle", isEqualTo: 2)
        .get();
    setState(() {
      _data = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final getreflect = controller.getAllReflect();
    final idemail = getEmail();

    return Scaffold(
      appBar: UIConstants.appBar(),
      // padding: EdgeInsets.all(12),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: FutureBuilder<List<ReflectModel>>(
            future: controller.getAllReflecHandle2(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      // physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        DateTime date = DateTime.parse(snapshot
                            .data![index].createdAt!
                            .toDate()
                            .toString());
                        String formatedDate = DateFormat.yMd().format(date);

                        String file =
                            getFileName("${snapshot.data?[index].media?[0]}");
                        // UserModel user = snapshot.data as UserModel;
                        // print("USERIDD ==  ${user.email}");

                        //                                                     final getemail =
                        //                                                         await getEmail();
                        // // if(snapshot
                        // //                                                           .data![index].likes![index] == getemail)

                        final likeIndex = snapshot.data![index].likes?.length;

                        return Padding(
                          // padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReflectDetailPage(
                                            reflect: snapshot.data![index],
                                          ))).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Text(
                                                "${snapshot.data![index].category}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                formatedDate,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(formatedDate),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 350,
                                          child: Text(
                                            "${snapshot.data![index].content}",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                            maxLines: 3,
                                            // overflow: ,
                                          ),
                                        ),
                                        isImageFromPath(file.split('.').last)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, top: 8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  child: Image.network(
                                                    "${snapshot.data![index].media![0]}",
                                                    height: 200,
                                                    width: 350,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 200,
                                                width: 350,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200]),
                                                child: VideoNoPlayer(
                                                    "${snapshot.data![index].media![0]}",
                                                    UniqueKey())),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TweetIcon(
                                                  icon: Icons.favorite,
                                                  text:
                                                      "${snapshot.data![index].likes!.length}",
                                                  onTap: () async {
                                                    setState(() {
                                                      like = !like;
                                                    });
                                                    if (like == true) {
                                                      await ReflectController
                                                          .likesPost(snapshot
                                                              .data![index]
                                                              .id!);
                                                    } else {
                                                      await ReflectController
                                                          .disLikesPost(snapshot
                                                              .data![index]
                                                              .id!);
                                                    }
                                                  }),
                                              TweetIcon(
                                                  text: "",
                                                  onTap: () {},
                                                  icon: Icons.chat)
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            }),
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
