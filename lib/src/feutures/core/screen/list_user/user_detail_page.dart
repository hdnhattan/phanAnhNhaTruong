import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left)),
        title: Text("Thông tin cá nhân"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey),
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              Text(
                "Tên người dùng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: TextFormField(
                  // controller: fullName,
                  obscureText: false,
                  decoration: InputDecoration(
                    // suffixIcon: Icon(Icons.email),
                    // labelText:
                    //     'Email' /* Email Address */,
                    label: Text(user.fullName!),
                    hintText:
                        'Nhập tên người dùng...' /* Enter your email... */,
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
              //   // controller: email,
              //   decoration: InputDecoration(
              //       label: Text(user.email!),
              //       prefixIcon: Icon(Icons.email_outlined)),
              // ),
              Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: TextFormField(
                  // controller: fullName,
                  obscureText: false,
                  decoration: InputDecoration(
                    // suffixIcon: Icon(Icons.email),
                    // labelText:
                    //     'Email' /* Email Address */,
                    label: Text(user.email!),
                    hintText: 'Nhập email...' /* Enter your email... */,
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
              //   // controller: phoneNo,
              //   decoration: InputDecoration(
              //       label: Text(user.phoneNo!),
              //       prefixIcon: Icon(Icons.numbers)),
              // ),
              Text(
                "Số điện thoại",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: TextFormField(
                  // controller: fullName,
                  obscureText: false,
                  decoration: InputDecoration(
                    // suffixIcon: Icon(Icons.email),
                    // labelText:
                    //     'Email' /* Email Address */,
                    label: user.phoneNo == ''
                        ? Text("Chưa cập nhật")
                        : Text(user.phoneNo!),
                    hintText:
                        'Chưa cập nhật điện thoại...' /* Enter your email... */,
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
              //   // initialValue: userData.password,
              //   // controller: password,
              //   decoration: InputDecoration(
              //       label: Text(user.password!),
              //       prefixIcon: Icon(Icons.fingerprint)),
              // ),
              // Text(
              //   "Mật khẩu",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              //   child: TextFormField(
              //     // controller: fullName,
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       // suffixIcon: Icon(Icons.email),
              //       // labelText:
              //       //     'Email' /* Email Address */,
              //       label: Text(user.password!),
              //       hintText:
              //           'Nhập tên người dùng...' /* Enter your email... */,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0x00000000),
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       errorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       focusedErrorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       filled: true,
              //       contentPadding:
              //           EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              //     ),
              //     maxLines: null,
              //   ),
              // ),
              SizedBox(height: 50),
              // Center(
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width / 1.2,
              //     height: 50,
              //     child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.amber),
              //         onPressed: () async {
              //           // final userData = UserModel(
              //           //     fullName: fullName.text.trim(),
              //           //     email: email.text.trim(),
              //           //     phoneNo: phoneNo.text.trim(),
              //           //     password: password.text.trim());
              //           // await controller.updateRecord(user);
              //         },
              //         child: Text("CAP NHAT THONG TIN",
              //             style: TextStyle(
              //                 fontSize: 16, fontWeight: FontWeight.bold))),
              //   ),
              // )
            ],
          )),

      // SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.all(12),
      //     child: FutureBuilder(
      //       // future: controller.getUserData(),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.done) {
      //           if (snapshot.hasData) {
      //             UserModel user = snapshot.data as UserModel;
      //             final email = TextEditingController(text: user.email);
      //             final password = TextEditingController(text: user.password);
      //             final fullName = TextEditingController(text: user.fullName);
      //             final phoneNo = TextEditingController(text: user.phoneNo);
      //             print("USER PROFILE == $email $password $fullName $phoneNo");
      //             return Column(
      //               children: [
      //                 SizedBox(
      //                   width: 120,
      //                   height: 120,
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(100),
      //                     child: Icon(Icons.person),
      //                   ),
      //                 ),
      //                 Form(
      //                     child: Column(
      //                   children: [
      //                     TextFormField(
      //                       // initialValue: userData.fullName,
      //                       controller: fullName,
      //                       decoration: InputDecoration(
      //                           label: Text("Full Name"),
      //                           prefixIcon: Icon(Icons.person_outline_rounded)),
      //                     ),
      //                     SizedBox(height: 10),
      //                     TextFormField(
      //                       // initialValue: userData.emial,
      //                       controller: email,
      //                       decoration: InputDecoration(
      //                           label: Text("Email"),
      //                           prefixIcon: Icon(Icons.email_outlined)),
      //                     ),
      //                     SizedBox(height: 10),
      //                     TextFormField(
      //                       // initialValue: userData.phoneNo,
      //                       controller: phoneNo,
      //                       decoration: InputDecoration(
      //                           label: Text("Phone"),
      //                           prefixIcon: Icon(Icons.numbers)),
      //                     ),
      //                     SizedBox(height: 10),
      //                     TextFormField(
      //                       // initialValue: userData.password,
      //                       controller: password,
      //                       decoration: InputDecoration(
      //                           label: Text("Pass"),
      //                           prefixIcon: Icon(Icons.fingerprint)),
      //                     ),
      //                     SizedBox(height: 10),
      //                     SizedBox(
      //                       width: double.infinity,
      //                       child: ElevatedButton(
      //                           onPressed: () async {
      //                             // final userData = UserModel(
      //                             //     fullName: fullName.text.trim(),
      //                             //     email: email.text.trim(),
      //                             //     phoneNo: phoneNo.text.trim(),
      //                             //     password: password.text.trim());
      //                             // await controller.updateRecord(user);
      //                           },
      //                           child: Text("CAP NHAT THONG TIN")),
      //                     )
      //                   ],
      //                 )),
      //               ],
      //             );
      //           } else if (snapshot.hasError) {
      //             return Center(
      //               child: Text(snapshot.error.toString()),
      //             );
      //           } else {
      //             return const Center(
      //               child: Text("Something went wrong"),
      //             );
      //           }
      //         } else {
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
