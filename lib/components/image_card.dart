import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/constants.dart';
import 'package:wuolla_wallpapers/screens/preview_page.dart';

class ImageCard extends StatelessWidget {
  ImageCard({this.imagePreviewUrl, this.regularImageUrl, this.fullImageUrl});
  final String imagePreviewUrl;
  final String regularImageUrl;
  final String fullImageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewPage(
                      previewImageUrl: regularImageUrl,
                      downloadImageUrl: fullImageUrl,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: NetworkImage(imagePreviewUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
