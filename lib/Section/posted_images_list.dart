import 'package:app/Networking/classes.dart';
import 'package:app/Widget/flipped_image.dart';
import 'package:flutter/material.dart';

class PostedImagesList extends StatelessWidget {
  PostedImagesList({Key key, this.postedImages}) : super(key: key);

  final List<GalleryImage> postedImages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: postedImages.length,
      itemBuilder: (context, index) {
        return FlippedImage(
          opacity: 1.0,
          image: postedImages[index]
        );
      },
    );
  }
}
