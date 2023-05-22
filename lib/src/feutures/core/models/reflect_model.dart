import 'package:cloud_firestore/cloud_firestore.dart';

class ReflectModel {
  final String? id;
  final String? email;
  final String? title;
  final String? category;
  final String? content;
  final String? content_feed_back;

  final String? address;
  final List<dynamic>? media;

  final List<dynamic>? likes;

  final bool? accept;
  final int? handle;
  final Timestamp? createdAt;

  const ReflectModel({
    this.id,
    required this.email,
    required this.likes,
    required this.title,
    required this.category,
    required this.content,
    required this.address,
    required this.media,
    required this.accept,
    required this.handle,
    required this.createdAt,
    required this.content_feed_back,
  });

  toJson() {
    return {
      "Email": email,
      "Title": title,
      "Category": category,
      "Content": content,
      "Address": address,
      "Media": media,
      "Accept": accept,
      "Handle": handle,
      "Likes": likes,
      "CreatedAt": createdAt,
      "ContentFeedBack": content_feed_back
    };
  }

  factory ReflectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReflectModel(
        id: document.id,
        email: data["Email"],
        title: data["Title"],
        category: data["Category"],
        content: data["Content"],
        address: data["Address"],
        media: data["Media"],
        accept: data["Accept"],
        handle: data["Handle"],
        createdAt: data["CreatedAt"],
        likes: data["Likes"],
        content_feed_back: data["ContentFeedBack"]);
  }
}
