import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/cretae_reflect/crud_reflect/colors.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_detail_page.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/update_profile_screen.dart';
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
      appBar: AppBar(
        title: Text(
          "Phản ánh nhà trường",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: Container(
          padding: EdgeInsets.all(12),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].title}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: '${snapshot.data![index].category}',
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
                                    text: '${snapshot.data![index].content}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ])),
                                SizedBox(
                                  height: 10,
                                ),
                                isImageFromPath(file.split('.').last)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 0),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            child: Image.network(
                                              "${snapshot.data![index].media![0]}",
                                              width: MediaQuery.of(context)
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
                                          width: 350,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200]),
                                        ),
                                      ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 0.5,
                                  color: AppColors.backgroundHome,
                                ),
                              ],
                            ),
                          ),
                          // child: Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Container(
                          //       width: 100,
                          //       height: 106,
                          //       decoration: BoxDecoration(
                          //         color: Color(0xFFEEEEEE),
                          //         image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: Image.network(
                          //             "${snapshot.data![index].media![0]}",
                          //           ).image,
                          //         ),
                          //         borderRadius: BorderRadius.circular(8),
                          //         border: Border.all(
                          //           color: Color(0xFF656565),
                          //           width: 0.5,
                          //         ),
                          //       ),
                          //     ),
                          //     Container(
                          //       width: 260,
                          //       height: 106,
                          //       decoration: BoxDecoration(
                          //         color: Color(0xFF656565),
                          //         boxShadow: [
                          //           BoxShadow(
                          //             blurRadius: 6,
                          //             color: Color(0x34000000),
                          //             offset: Offset(0, 3),
                          //           )
                          //         ],
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //       child: Column(
                          //         mainAxisSize: MainAxisSize.max,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Padding(
                          //             padding: EdgeInsetsDirectional.fromSTEB(
                          //                 12, 8, 0, 0),
                          //             child: Text(
                          //               '${snapshot.data![index].title}',
                          //               textAlign: TextAlign.start,
                          //               maxLines: 1,
                          //               overflow: TextOverflow.ellipsis,
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsetsDirectional.fromSTEB(
                          //                 12, 5, 0, 0),
                          //             child: SizedBox(
                          //               height: 50,
                          //               child: Text(
                          //                 '${snapshot.data![index].content}',
                          //                 maxLines: 3,
                          //                 overflow: TextOverflow.ellipsis,
                          //               ),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsetsDirectional.fromSTEB(
                          //                 12, 5, 0, 0),
                          //             child: Row(
                          //               mainAxisSize: MainAxisSize.max,
                          //               children: [
                          //                 Icon(
                          //                   Icons.remove_red_eye,
                          //                   size: 12,
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsetsDirectional.fromSTEB(
                          //                           5, 0, 0, 0),
                          //                   child: Text(formatedDate),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsetsDirectional.fromSTEB(
                          //                           8, 0, 0, 0),
                          //                   child: Icon(
                          //                     Icons.calendar_month,
                          //                     size: 12,
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsetsDirectional.fromSTEB(
                          //                           5, 0, 0, 0),
                          //                   child: Text(
                          //                     '${snapshot.data![index].category}',
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
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

String getFileName(String url) {
  RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
  //This Regex won't work if you remove ?alt...token
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);

  return Uri.decodeFull(match.group(2)!);
}
