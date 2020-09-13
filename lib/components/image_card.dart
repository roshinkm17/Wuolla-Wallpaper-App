import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/constants.dart';

class ImageCard extends StatelessWidget {
  ImageCard({this.imagePreviewUrl, this.fullImageUrl});
  final String imagePreviewUrl;
  final String fullImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: NetworkImage(imagePreviewUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
