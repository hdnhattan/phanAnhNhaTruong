import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/list_image.dart';

class AcceptReflectPage extends StatefulWidget {
  const AcceptReflectPage({super.key, required this.reflect});
  final ReflectModel reflect;

  @override
  State<AcceptReflectPage> createState() => _AcceptReflectPageState();
}

class _AcceptReflectPageState extends State<AcceptReflectPage> {
  TextEditingController? _title;
  TextEditingController? _category;
  TextEditingController? _content;
  TextEditingController? _content_feed_back;

  TextEditingController? _address;
  late DatabaseReference dbRef;

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    _title = TextEditingController(text: widget.reflect.title);
    _category = TextEditingController(text: widget.reflect.category);
    _content = TextEditingController(text: widget.reflect.content);
    _content_feed_back =
        TextEditingController(text: widget.reflect.content_feed_back);

    _address = TextEditingController(text: widget.reflect.address);

    profileController.getUserData();

    super.initState();
  }

  // void getUserAdmin ()async{
  //   DataSnapshot snapshot = ( await dbRef.child(widget.us))
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(LineAwesomeIcons.angle_left)),
          title: Text("Xử lý phản ánh"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: SizedBox(
                //     width: 120,
                //     height: 120,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(100),
                //       child: Icon(Icons.person),
                //     ),
                //   ),
                // ),

                // TextFormField(
                //   // initialValue: userData.fullName,
                //   controller: _title,
                //   decoration: InputDecoration(
                //       label: Text(_title!.text ?? 'An Ninh'),
                //       prefixIcon: Icon(Icons.person_outline_rounded)),
                // ),

                SizedBox(height: 10),

                Text(
                  "Tiêu đề",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _title,
                    obscureText: false,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.email),
                      // labelText: _title!.text ?? 'An Ninh' /* Email Address */,
                      hintText:
                          'Nhập số điện thoại...' /* Enter your email... */,
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
                          EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    ),
                    maxLines: null,
                  ),
                ),

                SizedBox(height: 10),
                // TextFormField(
                //   // initialValue: userData.emial,
                //   controller: _category,
                //   decoration: InputDecoration(
                //       // label: Text(reflect!.category!),
                //       prefixIcon: Icon(Icons.email_outlined)),
                // ),
                Text(
                  "Lĩnh vực",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _category,
                    obscureText: false,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.email),
                      // labelText: _title!.text ?? 'An Ninh' /* Email Address */,
                      hintText:
                          'Nhập số điện thoại...' /* Enter your email... */,
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
                          EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(height: 10),
                // TextFormField(
                //   // initialValue: userData.phoneNo,
                //   controller: _content,
                //   decoration: InputDecoration(
                //       // label: Text(reflect!.content!),
                //       prefixIcon: Icon(Icons.numbers)),
                // ),

                Text(
                  "Địa chỉ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _address,
                    obscureText: false,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.email),
                      // labelText: _title!.text ?? 'An Ninh' /* Email Address */,
                      hintText: 'Nhập địa chỉ...' /* Enter your email... */,
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
                          EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Nội dung",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _content,
                    obscureText: false,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.email),
                      // labelText: _title!.text ?? 'An Ninh' /* Email Address */,
                      hintText:
                          'Nhập số điện thoại...' /* Enter your email... */,
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
                          EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    ),
                    maxLines: null,
                  ),
                ),
                // SizedBox(height: 10),
                // TextFormField(
                //   // initialValue: userData.password,
                //   controller: _address,
                //   decoration: InputDecoration(
                //       // label: Text(reflect!.address!),
                //       prefixIcon: Icon(Icons.fingerprint)),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hình ảnh, video",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.reflect.media!.length == 0
                    ? SizedBox()
                    : ZoomImage(images: widget.reflect.media),
                SizedBox(
                  height: 15,
                ),
                TitleReflect(title: "Nội dung phản hồi"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _content_feed_back,
                    obscureText: false,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.email),
                      // labelText: _title!.text ?? 'An Ninh' /* Email Address */,
                      hintText:
                          'Nhập nội dung trả lời...' /* Enter your email... */,
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
                          EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                    ),
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 50),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () async {
                          // final userData = UserModel(
                          //     fullName: fullName.text.trim(),
                          //     email: email.text.trim(),
                          //     phoneNo: phoneNo.text.trim(),
                          //     password: password.text.trim());
                          // await controller.updateRecord(user);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('Xác nhận',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 20)),
                                ),
                                content: Container(
                                  alignment: Alignment.topCenter,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Text(
                                    "Xác nhận tiếp nhận phản ánh này không?",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // const Text(
                                //     "Bạn có chắc chắn muốn cập nhật phản ánh này không?"),
                                actions: <Widget>[
                                  Align(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                // Navigator.of(context).pop();

                                                await ReflectController.updateRef(
                                                        ReflectModel(
                                                            content_feed_back:
                                                                _content_feed_back!
                                                                    .text,
                                                            id: widget
                                                                .reflect.id,
                                                            email: widget
                                                                .reflect.email,
                                                            title: _title!.text,
                                                            category:
                                                                _category!.text,
                                                            content:
                                                                _content!.text,
                                                            address:
                                                                _address!.text,
                                                            media: widget
                                                                .reflect.media,
                                                            accept: false,
                                                            handle: 2,
                                                            createdAt: widget
                                                                .reflect
                                                                .createdAt,
                                                            likes: widget
                                                                .reflect.likes))
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.amber),
                                              child: Text(
                                                "Xác nhận",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Container(
                                        //   width:
                                        //       MediaQuery.of(context).size.width,
                                        //   decoration:
                                        //       BoxDecoration(border: Border()),
                                        //   child: TextButton(
                                        //     style: TextButton.styleFrom(
                                        //       textStyle: Theme.of(context)
                                        //           .textTheme
                                        //           .labelLarge,
                                        //     ),
                                        //     child: Text(
                                        //       'Xác Nhận',
                                        //       style: TextStyle(
                                        //           color: Colors.green,
                                        //           fontSize: 20),
                                        //     ),
                                        //     onPressed: () async {
                                        //       // Navigator.of(context).pop();

                                        //       await ReflectController.updateRef(
                                        //               ReflectModel(
                                        //                   content_feed_back:
                                        //                       _content_feed_back!
                                        //                           .text,
                                        //                   id: widget.reflect.id,
                                        //                   email: widget
                                        //                       .reflect.email,
                                        //                   title: _title!.text,
                                        //                   category:
                                        //                       _category!.text,
                                        //                   content:
                                        //                       _content!.text,
                                        //                   address:
                                        //                       _address!.text,
                                        //                   media: widget
                                        //                       .reflect.media,
                                        //                   accept: false,
                                        //                   handle: 2,
                                        //                   createdAt: widget
                                        //                       .reflect
                                        //                       .createdAt,
                                        //                   likes: widget
                                        //                       .reflect.likes))
                                        //           .then((value) {
                                        //         Navigator.pop(context);
                                        //       });
                                        //       setState(() {});
                                        //       Navigator.of(context).pop();
                                        //     },
                                        //   ),
                                        // ),

                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              child: Text(
                                                "Hủy",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );

                         
                        },
                        child: Text(
                          "Tiếp nhận phản ánh",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                         
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('Xác nhận',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 20)),
                                ),
                                content: Container(
                                  alignment: Alignment.topCenter,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Text(
                                    "Xác nhận không tiếp nhận phản ánh này?",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // const Text(
                                //     "Bạn có chắc chắn muốn cập nhật phản ánh này không?"),
                                actions: <Widget>[
                                  Align(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                // Navigator.of(context).pop();

                                                await ReflectController.updateRef(
                                                        ReflectModel(
                                                            content_feed_back:
                                                                _content_feed_back!
                                                                    .text,
                                                            id: widget
                                                                .reflect.id,
                                                            email: widget
                                                                .reflect.email,
                                                            title: _title!.text,
                                                            category:
                                                                _category!.text,
                                                            content:
                                                                _content!.text,
                                                            address:
                                                                _address!.text,
                                                            media: widget
                                                                .reflect.media,
                                                            accept: false,
                                                            handle: 3,
                                                            createdAt: widget
                                                                .reflect
                                                                .createdAt,
                                                            likes: widget
                                                                .reflect.likes))
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.amber),
                                              child: Text(
                                                "Xác nhận",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              child: Text(
                                                "Hủy",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Không tiếp nhận phản ánh",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),

                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}

class TitleReflect extends StatelessWidget {
  String title;
  bool isRequired = true;
  TitleReflect({Key? key, required this.title, this.isRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        isRequired
            ? Text(
                '*',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            : SizedBox()
      ],
    );
  }
}
