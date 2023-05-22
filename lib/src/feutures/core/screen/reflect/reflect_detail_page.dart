import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:shop_giay/src/feutures/core/screen/reflect/accept_reflect/accrpt_reflect.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/list_image.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/list_video.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/video_reflect/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class ReflectDetailPage extends StatefulWidget {
  const ReflectDetailPage({super.key, required this.reflect});
  final ReflectModel reflect;

  @override
  State<ReflectDetailPage> createState() => _ReflectDetailPageState();
}

class _ReflectDetailPageState extends State<ReflectDetailPage>
    with TickerProviderStateMixin {
  TextEditingController? _title;
  TextEditingController? _category;
  TextEditingController? _content;
  TextEditingController? _address;
  late DatabaseReference dbRef;
  ReflectModel? reflect;
  TextEditingController commentController = TextEditingController();

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    _title = TextEditingController(text: widget.reflect.title);
    _category = TextEditingController(text: widget.reflect.category);
    _content = TextEditingController(text: widget.reflect.content);
    _address = TextEditingController(text: widget.reflect.address);

    // profileController.getUserData();

    super.initState();
  }

  // void getUserAdmin ()async{
  //   DataSnapshot snapshot = ( await dbRef.child(widget.us))
  // }

  buildComments(String id) {
    final commentsRef = FirebaseFirestore.instance.collection('comments');
    return StreamBuilder(
      stream: commentsRef
          .doc(id)
          .collection('comments')
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Comment> comments = [];
        snapshot.data!.docs.forEach((element) {
          comments.add(Comment.fromDocument(element));
        });
        return comments.length == 0
            ? Center(
                child:
                    SizedBox(height: 30, child: Text("Chưa có bình luận...")),
              )
            : Container(
                child: Column(
                  children: comments,
                ),
              );
      },
    );
  }

  addComment(String id) {
    final commentsRef = FirebaseFirestore.instance.collection('comments');
    commentsRef.doc(id).collection("comments").add({
      "emailuser": getEmail(),
      "comment": commentController.text,
      "timestamp": Timestamp.now(),
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left)),
        title: Text("Chi tiết phản ánh"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: profileController.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                final email = TextEditingController(text: user.email);
                final password = TextEditingController(text: user.password);
                final fullName = TextEditingController(text: user.fullName);
                final phoneNo = TextEditingController(text: user.phoneNo);
                final id = TextEditingController(text: user.id);
                final level = TextEditingController(text: user.level);
                String idUser = id.text;
                String nameUser = fullName.text;
                String mailUser = email.text;
                String levelUser = level.text;
                DateTime date = DateTime.parse(
                    widget.reflect.createdAt!.toDate().toString());
                String formatedDate =
                    DateFormat('dd/MM/yyyy HH:mm').format(date);

                print(
                    "USERPROFILE == $email $idUser $fullName $phoneNo $levelUser");
                return ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  // Image.asset(Res.ic_menu_detail_reflect, width: 15, height: 15),
                                  Icon(Icons.menu),
                                  Container(
                                      margin: EdgeInsets.only(left: 7),
                                      child: Text(
                                        widget.reflect.category!,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.green),
                                      )),
                                  SizedBox(
                                    width: 160,
                                  ),
                                  widget.reflect.handle == 1
                                      ? Text("Chưa xử lý",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.yellow))
                                      : widget.reflect.handle == 2
                                          ? Text("Đã duyệt",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green))
                                          : Text("Không duyệt",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red)),
                                ]),

                            // Text("${levelUser}"),
                            // Text("${widget.reflect.address}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${widget.reflect.title}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Icon(
                                  LineAwesomeIcons.map_marked,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                widget.reflect.address == ''
                                    ? Text('B301',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ))
                                    : Text('${widget.reflect.address}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(formatedDate,
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.reflect.media!.length == 0
                                ? SizedBox()
                                : ZoomImage(images: widget.reflect.media),
                            // widget.reflect.video!.length == 0
                            // ? SizedBox()
                            // : ListVideo(
                            //     images: widget.reflect.video,
                            //   ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${widget.reflect.content}",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              height: 10,
                            ),

                            widget.reflect.handle == 2
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              "Nội dung phản hồi",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                              widget.reflect
                                                      .content_feed_back ??
                                                  "Nhà trường đã tiếp nhận phản ánh này, và sẽ sớm đưa ra biện pháp xử lý kịp thời.",
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    } else if (index == 1 && widget.reflect.handle == 2) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 10, top: 10),
                            child: Text(
                              "Nội dung bình luận",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          buildComments(widget.reflect.id!),
                        ],
                      );
                    } else {
                      return widget.reflect.handle == 2
                          ? ListTile(
                              title: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 16, 10),
                                    labelText: "Nhập nội dung bình luận..."),
                              ),
                              trailing: SizedBox(
                                height: 40,
                                child: OutlinedButton(
                                    onPressed: () =>
                                        addComment(widget.reflect.id!),
                                    child: Text("Gửi")),
                              ),
                            )
                          : SizedBox();
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
          }),
    );
  }
}

// class ReflectDetailPage extends StatelessWidget {
//   const ReflectDetailPage({super.key, required this.reflect});
//   final ReflectModel reflect;

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(ProfileController());

//     late DatabaseReference dbRef;

//   //  @override
//   // void initState() {
//   //   super.initState();

//   //   final databaseReference = FirebaseDatabase.instance.reference().child("myNode");

//   //   databaseReference.onValue.listen((event) {
//   //     Map<dynamic, dynamic> map = event.snapshot.value;
//   //     if (map != null) {
//   //       dataList = map.values.toList();
//   //       setState(() {});
//   //     }
//   //   });
//   // }

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(LineAwesomeIcons.angle_left)),
//         title: Text("Thong tin ca nhan"),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             width: 120,
//             height: 120,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Icon(Icons.person),
//             ),
//           ),
//           Form(
//               child: Column(
//             children: [
//               TextFormField(
//                 // initialValue: userData.fullName,
//                 // controller: fullName,
//                 decoration: InputDecoration(
//                     label: Text(reflect.title!),
//                     prefixIcon: Icon(Icons.person_outline_rounded)),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 // initialValue: userData.emial,
//                 // controller: email,
//                 decoration: InputDecoration(
//                     label: Text(reflect.category!),
//                     prefixIcon: Icon(Icons.email_outlined)),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 // initialValue: userData.phoneNo,
//                 // controller: phoneNo,
//                 decoration: InputDecoration(
//                     label: Text(reflect.content!),
//                     prefixIcon: Icon(Icons.numbers)),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 // initialValue: userData.password,
//                 // controller: password,
//                 decoration: InputDecoration(
//                     label: Text(reflect.address!),
//                     prefixIcon: Icon(Icons.fingerprint)),
//               ),
//               SizedBox(height: 10),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     onPressed: () async {
//                       // final userData = UserModel(
//                       //     fullName: fullName.text.trim(),
//                       //     email: email.text.trim(),
//                       //     phoneNo: phoneNo.text.trim(),
//                       //     password: password.text.trim());
//                       // await controller.updateRecord(user);
//                     },
//                     child: Text("CAP NHAT THONG TIN")),
//               )
//             ],
//           )),
//         ],
//       ),

//       // SingleChildScrollView(
//       //   child: Container(
//       //     padding: EdgeInsets.all(12),
//       //     child: FutureBuilder(
//       //       // future: controller.getUserData(),
//       //       builder: (context, snapshot) {
//       //         if (snapshot.connectionState == ConnectionState.done) {
//       //           if (snapshot.hasData) {
//       //             UserModel user = snapshot.data as UserModel;
//       //             final email = TextEditingController(text: user.email);
//       //             final password = TextEditingController(text: user.password);
//       //             final fullName = TextEditingController(text: user.fullName);
//       //             final phoneNo = TextEditingController(text: user.phoneNo);
//       //             print("USER PROFILE == $email $password $fullName $phoneNo");
//       //             return Column(
//       //               children: [
//       //                 SizedBox(
//       //                   width: 120,
//       //                   height: 120,
//       //                   child: ClipRRect(
//       //                     borderRadius: BorderRadius.circular(100),
//       //                     child: Icon(Icons.person),
//       //                   ),
//       //                 ),
//       //                 Form(
//       //                     child: Column(
//       //                   children: [
//       //                     TextFormField(
//       //                       // initialValue: userData.fullName,
//       //                       controller: fullName,
//       //                       decoration: InputDecoration(
//       //                           label: Text("Full Name"),
//       //                           prefixIcon: Icon(Icons.person_outline_rounded)),
//       //                     ),
//       //                     SizedBox(height: 10),
//       //                     TextFormField(
//       //                       // initialValue: userData.emial,
//       //                       controller: email,
//       //                       decoration: InputDecoration(
//       //                           label: Text("Email"),
//       //                           prefixIcon: Icon(Icons.email_outlined)),
//       //                     ),
//       //                     SizedBox(height: 10),
//       //                     TextFormField(
//       //                       // initialValue: userData.phoneNo,
//       //                       controller: phoneNo,
//       //                       decoration: InputDecoration(
//       //                           label: Text("Phone"),
//       //                           prefixIcon: Icon(Icons.numbers)),
//       //                     ),
//       //                     SizedBox(height: 10),
//       //                     TextFormField(
//       //                       // initialValue: userData.password,
//       //                       controller: password,
//       //                       decoration: InputDecoration(
//       //                           label: Text("Pass"),
//       //                           prefixIcon: Icon(Icons.fingerprint)),
//       //                     ),
//       //                     SizedBox(height: 10),
//       //                     SizedBox(
//       //                       width: double.infinity,
//       //                       child: ElevatedButton(
//       //                           onPressed: () async {
//       //                             // final userData = UserModel(
//       //                             //     fullName: fullName.text.trim(),
//       //                             //     email: email.text.trim(),
//       //                             //     phoneNo: phoneNo.text.trim(),
//       //                             //     password: password.text.trim());
//       //                             // await controller.updateRecord(user);
//       //                           },
//       //                           child: Text("CAP NHAT THONG TIN")),
//       //                     )
//       //                   ],
//       //                 )),
//       //               ],
//       //             );
//       //           } else if (snapshot.hasError) {
//       //             return Center(
//       //               child: Text(snapshot.error.toString()),
//       //             );
//       //           } else {
//       //             return const Center(
//       //               child: Text("Something went wrong"),
//       //             );
//       //           }
//       //         } else {
//       //           return Center(
//       //             child: CircularProgressIndicator(),
//       //           );
//       //         }
//       //       },
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

class Comment extends StatelessWidget {
  String? comment;
  String? emailuser;
  Timestamp? timestamp;

  Comment({
    this.comment,
    this.emailuser,
    this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      emailuser: doc['emailuser'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.lightBlue),
            child: Icon(Icons.person),
          ),
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$emailuser"),
                Text(
                  "${comment}",
                ),
              ],
            ),
          ),
          subtitle: Text(
            "${timeago.format(timestamp!.toDate())}",
            style: TextStyle(fontSize: 10),
          ),
        )
      ],
    );
  }
}
