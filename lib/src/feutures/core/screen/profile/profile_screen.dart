import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/login/login_page.dart';
import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/list_reflect_no_process.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/reflect_page/reflect_page.dart';
import 'package:shop_giay/src/feutures/core/screen/list_user/list_user.dart';
import 'package:shop_giay/src/feutures/core/screen/profile/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());
  final idemail = getEmail();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {}, icon: Icon(LineAwesomeIcons.angle_left)),
      //   title: Text(
      //     "Trang ca nhan",
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
      //   ],
      // ),
      body: FutureBuilder(
        future: controller.getUserData(),
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

              print(
                  "USERPROFILE == $email $idUser $fullName $phoneNo $levelUser");
              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child:
                      Stack(alignment: AlignmentDirectional(0, -1), children: [
                    Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Image.asset(
                          "assets/logo_dhkhh.png",
                          width: double.infinity,
                          height: 500,
                          fit: BoxFit.cover,
                        )),
                    Align(
                      alignment: AlignmentDirectional(0, -0.87),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //   width: 40,
                            //   height: 40,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         blurRadius: 4,
                            //         color: Color(0x520E151B),
                            //         offset: Offset(0, 2),
                            //       )
                            //     ],
                            //     borderRadius: BorderRadius.circular(50),
                            //     shape: BoxShape.rectangle,
                            //   ),
                            //   child: IconButton(
                            //     // style: ,
                            //     // borderColor: Colors.transparent,
                            //     // borderRadius: 8,
                            //     // borderWidth: 1,
                            //     // buttonSize: 40,
                            //     icon: Icon(
                            //       Icons.arrow_back_rounded,
                            //       // color: FlutterFlowTheme.of(context).primary,
                            //       size: 20,
                            //     ),
                            //     onPressed: () async {
                            //       Navigator.pop(context);
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                        child: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                              Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 300, 0, 0),
                                      child: Container(
                                          width: double.infinity,
                                          height: 600,
                                          decoration: BoxDecoration(
                                            // color: Color(0xFFF8F7FA),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x320E151B),
                                                offset: Offset(0, -2),
                                              )
                                            ],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 0),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    ProfileMenuWidget(
                                                      endicon: LineAwesomeIcons
                                                          .angle_right,
                                                      titile:
                                                          "Thông tin cá nhân",
                                                      icon: Icons.person,
                                                      endIcon: true,
                                                      onPress: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const UpdateProfileScreen()),
                                                        );
                                                      },
                                                    ),
                                                    levelUser == 'admin'
                                                        ? ProfileMenuWidget(
                                                            endicon:
                                                                LineAwesomeIcons
                                                                    .angle_right,
                                                            titile:
                                                                "Danh sách tài khoản",
                                                            icon: LineAwesomeIcons
                                                                .address_book,
                                                            endIcon: true,
                                                            onPress: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const ListUserScreen()),
                                                              );
                                                            },
                                                          )
                                                        : SizedBox(),
                                                    ProfileMenuWidget(
                                                      endicon: LineAwesomeIcons
                                                          .angle_right,
                                                      titile:
                                                          "Danh sách phản ánh",
                                                      icon: LineAwesomeIcons
                                                          .paste,
                                                      endIcon: true,
                                                      onPress: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ReflectPage()),
                                                        );
                                                      },
                                                    ),
                                                    ProfileMenuWidget(
                                                      endicon: LineAwesomeIcons
                                                          .angle_right,
                                                      titile: "Đăng xuất",
                                                      icon: LineAwesomeIcons
                                                          .alternate_sign_out,
                                                      endIcon: true,
                                                      onPress: () {
                                                        auth
                                                            .signOut()
                                                            .then((value) => {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginScreen(),
                                                                      ))
                                                                });
                                                      },
                                                    ),
                                                  ])))))
                            ]))),
                  ]));
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
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.titile,
    required this.icon,
    required this.onPress,
    required this.endicon,
    this.endIcon = true,
  });

  final String titile;
  final IconData icon;
  final IconData endicon;

  final VoidCallback onPress;
  final bool endIcon;
  // final Color? textColor;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          onTap: onPress,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.lightBlue),
            child: Icon(icon),
          ),
          title: Text(
            titile,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          trailing: endIcon
              ? Icon(
                  endicon,
                  size: 18,
                  color: Colors.black,
                )
              : null,
        ),
      ),
    );
  }
}
