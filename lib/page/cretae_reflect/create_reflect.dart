import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/cretae_reflect/crud_reflect/camera_reflect.dart';
import 'package:shop_giay/page/cretae_reflect/crud_reflect/colors.dart';
import 'package:shop_giay/page/cretae_reflect/crud_reflect/crud_reflect.dart';

import 'package:shop_giay/page/cretae_reflect/crud_reflect/full_screen_widget.dart';

import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/controllers/profile_controller.dart';
import 'package:shop_giay/src/feutures/core/controllers/reflect_controller.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/video_reflect/video_player.dart';

class CreateReflectPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => CreateReflectPage(),
      );
  const CreateReflectPage({super.key});

  @override
  State<CreateReflectPage> createState() => CreateReflectPageState();
}

class CreateReflectPageState extends State<CreateReflectPage> {
  final controllerUer = Get.put(ProfileController());
  List<File> listFile = [];

  String? authorName, title, desc;
  CrudReflect crudReflect = new CrudReflect();
  // final FirebaseStorage storage = FirebaseStorage.instance;
  QuerySnapshot? refSnapshot;
  // List<ReflectModel> reflect = List.empty(growable: true);
  bool accept = false;
  String? url;
  File? image;
  List<String> urls = [];
  List<String> video_urls = [];
  List<String> listCategory = ['Giáo dục', 'An ninh', 'Cơ sở vật chất'];
  String? selectNameCategogy;

  bool _isloading = false;
  String imageUrl = '';
  XFile? file;
  String? u;
  String slectedFileName = "";
  String defaultImageUrl =
      'https://hanoispiritofplace.com/wp-content/uploads/2014/08/hinh-nen-cac-loai-chim-dep-nhat-1-1.jpg';
  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("failed to picker image: $e");
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        // backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () {
                    _selectFile(true);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Camera"),
                  onTap: () {
                    // _selectFile(false);
                    _selectImgVideo(false);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
        });
  }

  _selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);

    if (file != null) {
      setState(() {
        slectedFileName = file!.name;
      });
    }
    print(file!.name);
  }

  _selectImgVideo(bool imageFrom) async {
    file = await ImagePicker().pickVideo(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);

    if (file != null) {
      setState(() {
        slectedFileName = file!.name;
      });
    }
    print(file!.name);
  }

  Future<void> uploadImages() async {
    int i = -1;

    for (File imageFile in listFile) {
      i++;

      //  final Reference storageRef =
      //     FirebaseStorage.instance.ref().child('my_bucket');
      // if (imageFile.path.endsWith('.jpg') || imageFile.path.endsWith('.png')) {
      //   TaskSnapshot snapshot =
      //       await storageRef.child('my_image.jpg').putFile(imageFile);

      //   //           var ref = firebase_storage.FirebaseStorage.instance
      //   //           .ref()
      //   //           .child('ListingImages')
      //   //           .child(randomAlpha(9) + '.jpg');
      //   // uploadTask = ref.putFile(listFile[i]);
      //   //       final snapshot = await uploadTask.whenComplete(() => null);
      //   //       u = await snapshot.ref.getDownloadURL();
      //   String downloadUrl = await snapshot.ref.getDownloadURL();
      //   urls.add(downloadUrl);
      // }

      // if (imageFile.path.toLowerCase().contains("jpg") ||
      //     imageFile.path.toLowerCase().contains("png") ||
      //     imageFile.path.toLowerCase().contains("jpeg") ||
      //     imageFile.path.toLowerCase().contains("webp")) {
      try {
        firebase_storage.UploadTask uploadTask;

        var ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('ListingImages')
            .child(randomAlpha(9) + "${listFile[i].path}");

        // await ref.putFile(imageFile);
        uploadTask = ref.putFile(listFile[i]);
        final snapshot = await uploadTask.whenComplete(() => null);
        u = await snapshot.ref.getDownloadURL();
        print("URLLL == $u");
        urls.add(u!);
      } catch (err) {
        print(err);
      }
      // } else {
      //   firebase_storage.UploadTask uploadTask;

      //   var ref = firebase_storage.FirebaseStorage.instance
      //       .ref()
      //       .child('ListVideo')
      //       .child(randomAlpha(9) + '.mp4');

      //   // await ref.putFile(imageFile);
      //   uploadTask = ref.putFile(listFile[i]);
      //   final snapshot = await uploadTask.whenComplete(() => null);
      //   u = await snapshot.ref.getDownloadURL();
      //   print("URLLL == $u");
      //   video_urls.add(u!);
      // }
    }
    print(listFile);
  }

  _uploadFile() async {
    try {
      firebase_storage.UploadTask uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Images')
          .child('/' + file!.name);

      // uploadTask = ref.putFile(File(file!.path));
      uploadTask = ref.putFile(File(file!.path));

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('UPLOAD IMAGE URL' + imageUrl);

      // Map<String, String> RefMap = {
      //   "imageUrl": imageUrl,
      //   "authorName": authorName!,
      //   "title": title!,
      //   "desc": desc!
      // };
      // crudReflect.addData(RefMap).then((value) {});
    } catch (e) {
      print(e);
    }
  }

  final controller = Get.put(ReflectController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("CATEGOGY == ${selectNameCategogy}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left)),
        title: Text("Đăng phản ánh"),
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),

                                TitleReflect(title: "Tiêu đề"),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: controller.title,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Nhập tiêu đề...' /* Enter your email... */,
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
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                TitleReflect(title: "Lĩnh vực"),
                                SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Transform.translate(
                                          offset: Offset(-10, 0),
                                          child: Text(
                                            selectNameCategogy ??
                                                listCategory[0],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        items: listCategory
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Transform.translate(
                                                    offset: Offset(-10, 0),
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectNameCategogy,
                                        onChanged: (value) {
                                          setState(() {
                                            selectNameCategogy =
                                                value as String?;
                                            if (value == listCategory[0]) {
                                              selectNameCategogy =
                                                  listCategory[0];
                                            }
                                            if (value == listCategory[1]) {
                                              selectNameCategogy =
                                                  listCategory[1];
                                            }
                                            if (value == listCategory[2]) {
                                              selectNameCategogy =
                                                  listCategory[2];
                                            }
                                          });
                                        },
                                        // buttonHeight: 30,
                                        // itemHeight: 40,
                                        // dropdownMaxHeight: 200,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                TitleReflect(title: "Nội dung"),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: controller.content,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      // suffixIcon: Icon(Icons.email),
                                      // labelText:
                                      //     'Email' /* Email Address */,
                                      hintText:
                                          'Nhập nội dung...' /* Enter your email... */,
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
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                TitleReflect(title: "Vị trí"),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: controller.address,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      // suffixIcon: Icon(Icons.email),
                                      // labelText:
                                      //     'Email' /* Email Address */,
                                      hintText:
                                          'Nhập địa chỉ...' /* Enter your email... */,
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
                                ),
                                // TextField(
                                //   controller: controller.address,
                                //   decoration: InputDecoration(
                                //       hintText: "Adrres"),
                                //   // onChanged: (value) {
                                //   //   desc = value;
                                //   // },
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                TitleReflect(title: "Ảnh, video"),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              // CameraStageScreen(this),
                                              CameraGuiPhanAnhScreen(this),
                                        ));
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        dashPattern: [3, 3, 3, 3],
                                        color: AppColors.dottedColorBorder,
                                        radius: Radius.circular(8),
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          child: Center(
                                              child:
                                                  Icon(Icons.image_outlined)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 100,
                                        width: 250,
                                        child: ListView.separated(
                                          itemCount: listFile.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            width: 20,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            print(
                                                "IMAGE == ${listFile[index].path}");

                                            if (listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("jpg") ||
                                                listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("png") ||
                                                listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("jpeg") ||
                                                listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("webp")) {
                                              print(
                                                  "file ${listFile[index].path}");
                                              return Stack(
                                                children: [
                                                  FullScreenWidget(
                                                    child: Center(
                                                      child: Hero(
                                                        tag: "guiphananh",
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.file(
                                                            listFile[index],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          listFile.remove(
                                                              listFile[index]);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              print(
                                                  "file ${listFile[index].path}");
                                              return Stack(
                                                children: [
                                                  Platform.isIOS
                                                      ? Container(
                                                          height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          199,
                                                                          202,
                                                                          204)),
                                                          child: Icon(
                                                            Icons
                                                                .video_collection,
                                                            color: Colors.white,
                                                            size: 30,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                          child: VideoPlayerCustom(
                                                              "${listFile[index].path}",
                                                              UniqueKey()),
                                                        ),
                                                  Positioned(
                                                    top: 5,
                                                    left: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          listFile.remove(
                                                              listFile[index]);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 300,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          print(
                                              "TITLE == ${controller.title.text}");
                                          // Get.to(() => const UpdateProfileScreen());
                                          // await _uploadFile();

                                          if (controller.title.text.trim() ==
                                                  null ||
                                              controller.title.text.trim() ==
                                                  "") {
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //         MySnackBars.failureSnackBar);
                                            AnimatedSnackBar.material(
                                              'Chưa nhập tiêu đề!',
                                              duration:
                                                  Duration(milliseconds: 1),
                                              type: AnimatedSnackBarType.error,
                                              mobileSnackBarPosition:
                                                  MobileSnackBarPosition.bottom,
                                            ).show(context);
                                            print("ok 1");
                                            return null;
                                          } else {
                                            setState(() {
                                              _isloading = true;
                                            });
                                            await uploadImages();
                                            await ReflectController.instance
                                                .createReflect(ReflectModel(
                                                    content_feed_back: '',
                                                    likes: [],
                                                    email: getEmail(),
                                                    title: controller.title.text
                                                        .trim(),
                                                    category:
                                                        selectNameCategogy,
                                                    content: controller
                                                        .content.text
                                                        .trim(),
                                                    address: controller
                                                        .address.text
                                                        .trim(),
                                                    media: urls,
                                                    accept: false,
                                                    handle: 1,
                                                    createdAt: Timestamp.now()))
                                                .then((value) {
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(
                                              //         MySnackBars.successSnackBar);
                                              AnimatedSnackBar.material(
                                                'Đăng phản ánh thành công!',
                                                type: AnimatedSnackBarType
                                                    .success,
                                                duration:
                                                    Duration(milliseconds: 1),
                                                mobileSnackBarPosition:
                                                    MobileSnackBarPosition
                                                        .bottom,
                                              ).show(context);
                                              controller.title.text = '';
                                              // selectNameCategogy = '';
                                              controller.content.text = '';
                                              controller.address.text = '';
                                              listFile = [];
                                              setState(() {
                                                _isloading = false;
                                              });
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber),
                                        child: Text(
                                          "Đăng phản ánh",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
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
