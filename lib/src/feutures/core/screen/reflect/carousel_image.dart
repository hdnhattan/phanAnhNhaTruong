import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CarouselImage extends StatefulWidget {
  final List<dynamic> images;

  const CarouselImage({super.key, required this.images});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
                items: widget.images.map((link) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    child: Image.network(link, fit: BoxFit.cover),
                  );
                }).toList(),
                options:
                    CarouselOptions(height: 400, enableInfiniteScroll: false)),
          ],
        )
      ],
    );
  }
}
