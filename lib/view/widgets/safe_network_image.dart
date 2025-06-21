import 'package:flutter/material.dart';

class SafeNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double borderRadius;
  final String fallbackAsset;
  final BoxFit fit;

  const SafeNetworkImage({
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius = 0,
    this.fallbackAsset = 'assets/icons/newspaper-logo.png',
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            fallbackAsset,
            width: width,
            height: height,
            fit: fit,
          );
        },
      ),
    );
  }
}
