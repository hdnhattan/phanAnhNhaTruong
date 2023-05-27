import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shop_giay/constants/ui_constants.dart';
import 'package:shop_giay/page/cretae_reflect/crud_reflect/colors.dart';

import 'package:shop_giay/page/home/home_page.dart';
import 'package:shop_giay/src/feutures/authentication/screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool changeColor = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  // // final AuthRepository _authRepository = AuthRepository();
  // // late final UserManager _userManager = context.read<UserManager>();

  // // Future storeUserandAddUser(String token) async {
  // //   await _userManager.storeAccessToken(token);
  // //   User? user = await getUserInfor();
  // //   _userManager.updateUser(user);
  // // }

  // // Future login(String email, String pass) async {
  // //   String token = await _authRepository.login(email: email, password: pass);
  // //   storeUserandAddUser(token);
  // // }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseaApp = await Firebase.initializeApp();
    return firebaseaApp;
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: UIConstants.appBarLogin(),
        // backgroundColor: Colors.black54,
        // appBar: AppBar(
        //   title: Text('Firebase Authentication'),
        // ),
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTabController(
                    length: 2,
                    child: SizedBox(
                      height: 570,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: TabBar(
                              labelColor: Colors.green,
                              indicatorColor: Colors.blue,
                              unselectedLabelColor: Colors.grey,
                              tabs: <Widget>[
                                Tab(
                                  text: "ĐĂNG NHẬP",
                                ),
                                Tab(
                                  text: "ĐĂNG KÝ",
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 20, 24, 0),
                                      child: TextFormField(
                                        controller: emailController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(Icons.email),
                                          labelText:
                                              'Email' /* Email Address */,
                                          hintText:
                                              'Email' /* Enter your email... */,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 24, 20, 24),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white,
                                            ),
                                            onPressed: () async {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          labelText:
                                              'Mật khẩu' /* Email Address */,
                                          hintText:
                                              'Mật khẩu' /* Enter your email... */,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 24, 20, 24),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            onPrimary: Colors.white,
                                            shadowColor: Colors.greenAccent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                            minimumSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                50), //////// HERE
                                          ),
                                          onPressed: () async {
                                            if (emailController.text == null ||
                                                emailController.text == "") {
                                              AnimatedSnackBar.material(
                                                'Chưa nhập email!',
                                                type:
                                                    AnimatedSnackBarType.error,
                                                mobileSnackBarPosition:
                                                    MobileSnackBarPosition
                                                        .bottom,
                                              ).show(context);
                                              print("not login");
                                            } else if (passwordController
                                                        .text ==
                                                    null ||
                                                passwordController.text == "") {
                                              AnimatedSnackBar.material(
                                                'Chưa nhập mật khẩu!',
                                                type:
                                                    AnimatedSnackBarType.error,
                                                mobileSnackBarPosition:
                                                    MobileSnackBarPosition
                                                        .bottom,
                                              ).show(context);
                                            } else {
                                              User? user =
                                                  await loginUsingEmailPassword(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      context: context);
                                              print(user);
                                              if (user != null) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(),
                                                ));
                                              }
                                            }
                                          },
                                          child: Text(
                                            "ĐĂNG NHẬP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                    ),
                                  ],
                                ),
                                SignUpFormWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Text("Dang ky"),
                  // SignUpFormWidget(),
                ],
              );
            }),
      ),
    );
  }
}

String? validateEmail(String? forEmail) {
  if (forEmail == null || forEmail.isEmpty) return 'E-mail';

  return null;
}
