import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/constants/ui_constants.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/cretae_reflect/crud_reflect/colors.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_detail_page.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/update_profile_screen.dart';
import 'package:shop_giay/src/feutures/core/screen/widget/icon_and_text.dart';
import 'package:shop_giay/src/utils/file_utils.dart';
import 'package:intl/intl.dart';

class ReflectHomeScreen extends StatefulWidget {
  const ReflectHomeScreen({super.key});

  @override
  State<ReflectHomeScreen> createState() => _ReflectHomeScreenState();
}

class _ReflectHomeScreenState extends State<ReflectHomeScreen> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  List<dynamic> dataList = [];
  final _unfocusNode = FocusNode();
  final idemail = getEmail();

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

  final List<String> listImages = [
    "assets/banner.jpg",
    "assets/banner1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phản Ánh Nhà Trường",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                    child: CarouselSlider.builder(
                  itemCount: listImages.length,
                  options: CarouselOptions(
                    // autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Image.asset(
                        listImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180,
                      )),
                    );
                  },
                ));

                // ClipRRect(
                //   child: Image.network(
                //     "https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-6/339074669_161210830196900_16419087122566169_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=e3f864&_nc_ohc=2RukOKdSA2UAX8z4IcQ&_nc_ht=scontent.fdad3-1.fna&oh=00_AfDr6Kx45QoIXZgqKBTD7wKAiF64mNVADGZkFygNdnUWww&oe=6472020C",
                //     width: double.infinity,
                //     height: 150,
                //     fit: BoxFit.cover,
                //   ),
                // );
              } else if (index == 1) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12),
                  child: Row(
                    children: [
                      Icon(Icons.menu),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Thông tin phản ánh",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: FutureBuilder<List<ReflectModel>>(
                    future: controller.getAllReflecHandle2(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              DateTime date = DateTime.parse(snapshot
                                  .data![index].createdAt!
                                  .toDate()
                                  .toString());
                              String formatedDate =
                                  DateFormat.yMd().format(date);
                              String file = getFileName(
                                  "${snapshot.data?[index].media?[0]}");
                              if (index == 0) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReflectDetailPage(
                                                  reflect: snapshot.data![0],
                                                )),
                                      ).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          isImageFromPath(file.split('.').last)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0, top: 0),
                                                  child: Center(
                                                    child: ClipRRect(
                                                      // borderRadius:
                                                      //     BorderRadius.all(
                                                      //         Radius.circular(
                                                      //             8)),
                                                      child: Image.network(
                                                        "${snapshot.data![0].media![0]}",
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Container(
                                                    height: 200,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.grey[200]),
                                                    child: Center(
                                                      child: Image.asset(
                                                        "assets/video.png",
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              "${snapshot.data![0].title}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text:
                                                    '${snapshot.data![0].category}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              TextSpan(
                                                text: ' - ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${snapshot.data![0].content}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            ])),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Container(
                                              height: 0.5,
                                              color: AppColors.backgroundHome,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReflectDetailPage(
                                                  reflect:
                                                      snapshot.data![index],
                                                )),
                                      ).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            isImageFromPath(
                                                    file.split('.').last)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0, top: 0),
                                                    child: Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                        child: Image.network(
                                                          "${snapshot.data![index].media![0]}",
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          height: 105,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      height: 105,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Center(
                                                        child: Image.asset(
                                                          "assets/video.png",
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            Container(
                                              width: 260,
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 8, 0, 0),
                                                    child: Text(
                                                      '${snapshot.data![index].title}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 5, 0, 0),
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: Text(
                                                        '${snapshot.data![index].content}',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 0, 12, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        iconAndText(
                                                            textStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        10),
                                                            size: 12,
                                                            title:
                                                                '${snapshot.data![index].category}',
                                                            icon:
                                                                LineAwesomeIcons
                                                                    .bookmark),
                                                        iconAndText(
                                                            textStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        10),
                                                            size: 12,
                                                            title: formatedDate,
                                                            icon: Icons
                                                                .calendar_month),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12,
                                              right: 12,
                                              top: 8,
                                              bottom: 8),
                                          child: Container(
                                            height: 0.5,
                                            color: AppColors.backgroundHome,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       isImageFromPath(file.split('.').last)
                                    //           ? Padding(
                                    //               padding:
                                    //                   const EdgeInsets.only(
                                    //                       left: 0, top: 0),
                                    //               child: Center(
                                    //                 child: ClipRRect(
                                    //                   borderRadius:
                                    //                       BorderRadius.all(
                                    //                           Radius.circular(
                                    //                               12)),
                                    //                   child: Image.network(
                                    //                     "${snapshot.data![index].media![0]}",
                                    //                     width: MediaQuery.of(
                                    //                                 context)
                                    //                             .size
                                    //                             .width /
                                    //                         2.5,
                                    //                     height: 150,
                                    //                     fit: BoxFit.cover,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             )
                                    //           : Center(
                                    //               child: Container(
                                    //                 width:
                                    //                     MediaQuery.of(context)
                                    //                             .size
                                    //                             .width /
                                    //                         3.5,
                                    //                 height: 100,
                                    //                 decoration: BoxDecoration(
                                    //                     color:
                                    //                         Colors.grey[200]),
                                    //               ),
                                    //             ),
                                    //       SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       Column(
                                    //         children: [
                                    //           Text(
                                    //             "${snapshot.data![index].title}",
                                    //             style: TextStyle(
                                    //                 fontWeight: FontWeight.bold,
                                    //                 fontSize: 16),
                                    //             maxLines: 2,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //           Text(
                                    //             "${snapshot.data![index].title}",
                                    //             style: TextStyle(
                                    //                 fontWeight: FontWeight.bold,
                                    //                 fontSize: 16),
                                    //             maxLines: 2,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       SizedBox(height: 5),
                                    //       SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       SizedBox(
                                    //         height: 15,
                                    //       ),
                                    //       Container(
                                    //         height: 0.5,
                                    //         color: AppColors.backgroundHome,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ),
                                );
                              }
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
                );
              }
            },
          )),
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

String getFileName(String url) {
  RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
  //This Regex won't work if you remove ?alt...token
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);

  return Uri.decodeFull(match.group(2)!);
}
