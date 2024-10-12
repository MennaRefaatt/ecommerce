
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppNetwork extends StatelessWidget {
  const AppNetwork({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.borderRadius,
    this.fit,  this.height,
  });

  final String imageUrl;
  final double width;
  final double? height;
  final BorderRadius borderRadius;

  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child:Image.network(
            imageUrl,
            fit: BoxFit.fill,
            width: width,
            height: height,
    ));
  }
}
