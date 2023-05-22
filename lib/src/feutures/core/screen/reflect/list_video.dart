import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/image_slide.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/video_reflect/video_player.dart';

import 'package:shop_giay/src/utils/file_utils.dart';

class ListVideo extends StatefulWidget {
  List<dynamic>? images;
  ListVideo({Key? key, this.images}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  void initState() {
    // for (int i = 0; i < widget.images!.length; i++) {
    //   if (isImageFromPath(widget.images![i].split('.').last) ||
    //       isVideoFromPath(widget.images![i].split('.').last)) {
    //     list.add(widget.images![i]);
    //   }
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(" IMFG ===${widget.images![0]}");
    return widget.images!.isEmpty
        ? SizedBox()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      width: 20,
                    ),
                itemCount: widget.images!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, indext) {
                  return Container(
                    width: widget.images!.length == 1
                        ? MediaQuery.of(context).size.width - 60
                        : MediaQuery.of(context).size.width * 2 / 3,
                    child: VideoPlayerCustom(
                        "${widget.images![indext]}", UniqueKey()),
                  );
                  // if (!isImageFromPath(file)) {
                  //   return GestureDetector(
                  //     onTap: () {
                  //       // Navigator.of(context, rootNavigator: true)
                  //       //     .push(MaterialPageRoute(
                  //       //         builder: (_) => ImageSlider(
                  //       //               images: widget.images!,
                  //       //               pageIndex: indext,
                  //       //             )));
                  //     },
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(5),
                  //       child: CachedNetworkImage(
                  //         width: widget.images!.length == 1
                  //             ? MediaQuery.of(context).size.width - 60
                  //             : MediaQuery.of(context).size.width * 2 / 3,
                  //         fit: BoxFit.cover,
                  //         imageUrl: '${widget.images![indext]}',
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   print("VIDEO == ${widget.images![indext]}");
                  //   return Container(
                  //     width: widget.images!.length == 1
                  //         ? MediaQuery.of(context).size.width - 60
                  //         : MediaQuery.of(context).size.width * 2 / 3,
                  //     child: VideoPlayerCustom("${list[indext]}", UniqueKey()),
                  //   );
                  // }
                }),
          );
  }
}
