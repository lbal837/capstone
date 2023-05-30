import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const HomeIcon({
    Key? key,
    required this.imagePath,
    this.width = 160.0,
    this.height = 160.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80.0),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}
