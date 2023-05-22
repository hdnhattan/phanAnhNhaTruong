import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_giay/src/feutures/core/models/reflect_model.dart';

class ReflectRepository extends GetxController {
  static ReflectRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createReflect(ReflectModel reflect) async {
    await _db
        .collection("Reflect")
        .add(reflect.toJson())
        .whenComplete(() => Get.snackbar("Success", "Reflect has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  createLikes(String email) async {
    await _db.collection("likes").doc(email);
  }

  Future<List<ReflectModel>> allReflect() async {
    final snapshot = await _db.collection("Reflect").get();
    final reflectData =
        snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> allReflectAdmin(int handle) async {
    final snapshot = await _db
        .collection("Reflect")
        .where("Handle", isEqualTo: handle)
        .get();
    final reflectData =
        snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> allReflectUser(String email, int handle) async {
    final snapshot = await _db
        .collection("Reflect")
        .where("Email", isEqualTo: email)
        .where("Handle", isEqualTo: handle)
        .get();
    final reflectData =
        snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> allReflectActive(int handle) async {
    final snapshot = await _db
        .collection("Reflect")
        .where("Handle", isEqualTo: handle)
        .get();
    final reflectData =
        snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }
}
