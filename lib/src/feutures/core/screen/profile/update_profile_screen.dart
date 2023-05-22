import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final idemail = getEmail();
    // AuthController authController =

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left)),
        title: Text("Thông tin cá nhân"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNo = TextEditingController(text: user.phoneNo);
                  final role = TextEditingController(text: user.level);

                  final id = TextEditingController(text: user.id);
                  String idUser = id.text;

                  print(
                      "USER PROFILE == $email $password $fullName $phoneNo $idUser");
                  return Column(
                    children: [
                      // SizedBox(
                      //   width: 120,
                      //   height: 120,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(100),
                      //     child: Icon(Icons.person),
                      //   ),
                      // ),
                      Container(
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
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("IDUSER: $idUser"),
                          // TextFormField(
                          //   // initialValue: userData.fullName,
                          //   controller: fullName,
                          //   decoration: InputDecoration(
                          //       label: Text("Full Name"),
                          //       prefixIcon: Icon(Icons.person_outline_rounded)),
                          // ),

                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Tên người dùng",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: fullName,
                              obscureText: false,
                              decoration: InputDecoration(
                                // suffixIcon: Icon(Icons.email),
                                // labelText:
                                //     'Email' /* Email Address */,
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 24, 20, 24),
                              ),
                              maxLines: null,
                            ),
                          ),
                          SizedBox(height: 10),
                          // TextFormField(
                          //   // initialValue: userData.emial,
                          //   controller: email,
                          //   decoration: InputDecoration(
                          //       label: Text("Email"),
                          //       prefixIcon: Icon(Icons.email_outlined)),
                          // ),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: email,
                              obscureText: false,
                              decoration: InputDecoration(
                                // suffixIcon: Icon(Icons.email),
                                // labelText:
                                //     'Email' /* Email Address */,
                                hintText:
                                    'Nhập email người dùng...' /* Enter your email... */,
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 24, 20, 24),
                              ),
                              maxLines: null,
                            ),
                          ),
                          SizedBox(height: 10),

                          Text(
                            "Số điện thoại",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: phoneNo,
                              obscureText: false,
                              decoration: InputDecoration(
                                // suffixIcon: Icon(Icons.email),
                                // labelText:
                                //     'Email' /* Email Address */,
                                hintText:
                                    'Chưa cập nhật...' /* Enter your email... */,
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 24, 20, 24),
                              ),
                              maxLines: null,
                            ),
                          ),
                          SizedBox(height: 10),
                          idemail == "admin@gmail.com"
                              ? Text(
                                  "Cấp tài khoản",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : SizedBox(),
                          idemail == "admin@gmail.com"
                              ? Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: role,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      // suffixIcon: Icon(Icons.email),
                                      // labelText:
                                      //     'Email' /* Email Address */,
                                      hintText:
                                          'Chưa cập nhật...' /* Enter your email... */,
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
                                              20, 24, 20, 24),
                                    ),
                                    maxLines: null,
                                  ),
                                )
                              : SizedBox(),

                          SizedBox(height: 80),
                          idemail == "admin@gmail.com"
                              ? SizedBox()
                              : Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber),
                                        onPressed: () async {
                                          final userData = UserModel(
                                              id: idUser,
                                              fullName: fullName.text.trim(),
                                              email: email.text.trim(),
                                              phoneNo: phoneNo.text.trim(),
                                              password: password.text.trim());
                                          await controller
                                              .updateRecord(userData)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text(
                                          "CẬP NHẬT THÔNG TIN",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )
                        ],
                      )),
                    ],
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
