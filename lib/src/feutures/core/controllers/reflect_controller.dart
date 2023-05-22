import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_giay/global/global.dart';
import 'package:shop_giay/page/cretae_reflect/create_reflect.dart';

import 'package:shop_giay/src/feutures/authentication/model/user_model.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';
import 'package:shop_giay/src/repository/authentication_repository/authentication_repository.dart';
import 'package:shop_giay/src/repository/reflect_repository/reflect_repository.dart';
import 'package:shop_giay/src/repository/user_repository/user_respository.dart';

class ReflectController extends GetxController {
  static ReflectController get instance => Get.find();
  final idUser = TextEditingController();
  final email = TextEditingController();

  final title = TextEditingController();
  final EmailAuthProvider = TextEditingController();

  final category = TextEditingController();
  final content = TextEditingController();
  final address = TextEditingController();
  final media = TextEditingController();
  final createdAt = TextEditingController();
  final RefreshController refreshController = RefreshController();
  // final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  // getUserData() {
  //   final email = _authRepo.firebaseUser.value?.email;
  //   if (email != null) {
  //     return _userRepo.getUserDetails(email);
  //   } else {
  //     Get.snackbar("Error", "Login to continue");
  //   }
  // }

  // String Userid = "23YHodaQ9is81XdtaNsR";

  ReflectModel? reflect;

  List<ReflectModel> refl = [];

  final _reflectRepo = Get.put(ReflectRepository());

  @override
  void onInit() async {
    super.onInit();
    print("REFRESH");
    await onRefresh();
  }

  Future<void> onRefresh() async {
    await getAllReflect().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError(() {
      refreshController.loadFailed();
    });
  }

  loadAllData() async {
    try {
      var from_reflext = await FirebaseFirestore.instance
          .collection("Reflect")
          .orderBy("CreatedAt", descending: true)
          .get();
      refl;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createReflect(ReflectModel reflect) async {
    await _reflectRepo.createReflect(reflect);
  }

  Future<List<ReflectModel>> createLikes() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.createLikes(email!);
  }

  Future<List<ReflectModel>> getAllReflect() async {
    return await _reflectRepo.allReflect();
  }

  Future<List<ReflectModel>> getAllReflectNonAdmin() async {
    return await _reflectRepo.allReflectAdmin(1);
  }

  Future<List<ReflectModel>> getAllReflectAcceptAdmin() async {
    return await _reflectRepo.allReflectAdmin(2);
  }

  Future<List<ReflectModel>> getAllReflectNotAcceptAdmin() async {
    return await _reflectRepo.allReflectAdmin(3);
  }

  Future<List<ReflectModel>> getAllReflectReload(bool reload) async {
    return await _reflectRepo.allReflect();
  }

  Future<List<ReflectModel>> getAllReflectUser() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.allReflectUser(email!, 1);
  }

  Future<List<ReflectModel>> getAllReflectUserSucc() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.allReflectUser(email!, 2);
  }

  Future<List<ReflectModel>> getAllReflectUserNotAccept() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.allReflectUser(email!, 3);
  }

  Future<List<ReflectModel>> getAllReflecHandle2() async {
    return await _reflectRepo.allReflectActive(2);
  }

  static Future updateRef(ReflectModel reflect) async {
    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(reflect.id);

    final newReflect = ReflectModel(
            email: reflect.email,
            title: reflect.title,
            category: reflect.category,
            content: reflect.content,
            address: reflect.address,
            media: reflect.media,
            accept: reflect.accept,
            handle: reflect.handle,
            createdAt: reflect.createdAt,
            likes: reflect.likes,
            content_feed_back: reflect.content_feed_back)
        .toJson();

    try {
      await docRef.update(newReflect);
    } catch (e) {
      print("some error $e");
    }
  }

  static Future updateLikesRef(ReflectModel reflect) async {
    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(reflect.id);

    final newReflect = ReflectModel(
            email: reflect.email,
            title: reflect.title,
            category: reflect.category,
            content: reflect.content,
            address: reflect.address,
            media: reflect.media,
            accept: reflect.accept,
            handle: reflect.handle,
            createdAt: reflect.createdAt,
            likes: reflect.likes,
            content_feed_back: reflect.content_feed_back)
        .toJson();

    try {
      await docRef.update(newReflect);
    } catch (e) {
      print("some error $e");
    }
  }

  static Future likesPost(String id) async {
    final idemail = getEmail();
    print("IDEMAILLL == $idemail");

    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(id);

    try {
      await docRef.update({
        'Likes': FieldValue.arrayUnion([idemail])
      });
    } catch (e) {
      print("some error $e");
    }
  }

  static Future disLikesPost(String id) async {
    final idemail = getEmail();
    print("IDEMAILLL == $idemail");

    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(id);

    try {
      await docRef.update({
        'Likes': FieldValue.arrayRemove([idemail])
      });
    } catch (e) {
      print("some error $e");
    }
  }

  static Future likeReflectUser(ReflectModel reflect, UserModel user) async {
    List<dynamic> likes = reflect.likes!;

    if (reflect.likes!.contains(user.email)) {
      likes.remove(user.email);
    } else {
      likes.add(user.email);
    }

    final res = await likeReflect(reflect);
  }

  static Future likeReflect(ReflectModel reflect) async {
    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(reflect.id);

    final newReflect = ReflectModel(
            email: reflect.email,
            title: reflect.title,
            category: reflect.category,
            content: reflect.content,
            address: reflect.address,
            media: reflect.media,
            accept: reflect.accept,
            handle: reflect.handle,
            createdAt: reflect.createdAt,
            likes: reflect.likes,
            content_feed_back: reflect.content_feed_back)
        .toJson();

    try {
      await docRef.update(newReflect);
    } catch (e) {
      print("some error $e");
    }
  }

  // getReflectUser() {
  //   if (reflect!.idUser != null) {
  //     return _reflectRepo.allReflectUser(reflect!.idUser!);
  //   } else {
  //     Get.snackbar("Error", "Login to continue");
  //   }
  // }
}
