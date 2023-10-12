import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    this.height = 150,
    this.width = 150,
    this.imageRadius = 12,
    required this.image,
  });

  final double height;
  final double width;
  final double imageRadius;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(imageRadius),
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          width: double.maxFinite,
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) => Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 4, vertical: height / 4),
            child: const CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
