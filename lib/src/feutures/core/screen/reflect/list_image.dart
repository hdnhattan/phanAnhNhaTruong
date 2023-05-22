import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/image_slide.dart';
import 'package:shop_giay/src/feutures/core/screen/reflect/video_reflect/video_player.dart';

import 'package:shop_giay/src/utils/file_utils.dart';

class ZoomImage extends StatefulWidget {
  List<dynamic>? images;
  ZoomImage({Key? key, this.images}) : super(key: key);

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  var list = [];

  String getFileName(String url) {
    RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    print(" LINKIMG == ${Uri.decodeFull(match.group(2)!)}");
    return Uri.decodeFull(match.group(2)!);
  }

  @override
  void initState() {
    // for (int i = 0; i < widget.images!.length; i++) {
    //   String file1 = getFileName(widget.images![i]);
    //   if (isImageFromPath(file1.split('.').last)) {
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
                  // if (!list[indext].contains(AppConfig.baseImageAvatar)) {
                  //   list[indext] = AppConfig.baseImageAvatar + list[indext];
                  // }
                  String file = getFileName(widget.images![indext]);

                  String filesplit = file.split('.').last;
                  // return

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context, rootNavigator: true)
                  //         .push(MaterialPageRoute(
                  //             builder: (_) => ImageSlider(
                  //                   images: widget.images!,
                  //                   pageIndex: indext,
                  //                 )));
                  //   },
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(5),
                  //     child: CachedNetworkImage(
                  //       width: widget.images!.length == 1
                  //           ? MediaQuery.of(context).size.width - 60
                  //           : MediaQuery.of(context).size.width * 2 / 3,
                  //       fit: BoxFit.cover,
                  //       imageUrl: '${widget.images![indext]}',
                  //     ),
                  //   ),
                  // );

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context, rootNavigator: true)
                  //         .push(MaterialPageRoute(
                  //             builder: (_) => ImageSlider(
                  //                   images: widget.images!,
                  //                   pageIndex: indext,
                  //                 )));
                  //   },
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(5),
                  //     child: CachedNetworkImage(
                  //       width: widget.images!.length == 1
                  //           ? MediaQuery.of(context).size.width - 30
                  //           : MediaQuery.of(context).size.width * 2 / 3,
                  //       fit: BoxFit.cover,
                  //       imageUrl: '${widget.images![indext]}',
                  //     ),
                  //   ),
                  // );
                  if (isImageFromPath(filesplit)) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context, rootNavigator: true)
                        //     .push(MaterialPageRoute(
                        //         builder: (_) => ImageSlider(
                        //               images: widget.images!,
                        //               pageIndex: indext,
                        //             )));

                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                                builder: (_) => ImageSlider(
                                      images: widget.images!,
                                      pageIndex: indext,
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          width: widget.images!.length == 1
                              ? MediaQuery.of(context).size.width - 20
                              : MediaQuery.of(context).size.width * 2 / 3,
                          fit: BoxFit.cover,
                          imageUrl: '${widget.images![indext]}',
                        ),
                      ),
                    );
                  } else {
                    print("VIDEO == ${widget.images![indext]}");
                    return Container(
                      width: widget.images!.length == 1
                          ? MediaQuery.of(context).size.width - 60
                          : MediaQuery.of(context).size.width * 2 / 3,
                      child: VideoPlayerCustom(
                          "${widget.images![indext]}", UniqueKey()),
                    );
                  }
                }),
          );
  }
}
