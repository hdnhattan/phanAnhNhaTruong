// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class Comments extends StatefulWidget {
//   String? reflectId;
//   String? reflectOwnerId;
//   String? reflectMediaUrl;
//   Comments({this.reflectId, this.reflectOwnerId, this.reflectMediaUrl});
//   @override
//   State<Comments> createState() => CommentsState(
//       reflectId: this.reflectId,
//       reflectOwnerId: this.reflectOwnerId,
//       reflectMediaUrl: this.reflectMediaUrl);
// }

// class CommentsState extends State<Comments> {
//   String? reflectId;
//   String? reflectOwnerId;
//   String? reflectMediaUrl;

//   CommentsState({this.reflectId, this.reflectOwnerId, this.reflectMediaUrl});

// buildComments(){
//   return Text("comments");
// }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [],
//     );
//   }
// }

// showComments(BuildContext context,
//     {String? reflectId, String? ownerId, String? mediaUrl}) {
//   Navigator.push(context, MaterialPageRoute(
//     builder: (context) {
//       return Comments(
//           reflectId: reflectId,
//           reflectOwnerId: ownerId,
//           reflectMediaUrl: mediaUrl);
//     },
//   ));
// }
