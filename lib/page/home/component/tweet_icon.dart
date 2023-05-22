import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_giay/theme/pallete.dart';

class TweetIcon extends StatelessWidget {
  // final String pathName;
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  const TweetIcon(
      {Key? key,
      // required this.pathName,
      required this.text,
      required this.onTap,
      required this.icon
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // SvgPicture.asset(
          //   pathName,
          //   color: Pallete.greyColor,
          // ),
          Icon(
            icon,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(6),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
