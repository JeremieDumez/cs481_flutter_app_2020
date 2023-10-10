import 'package:app/Networking/classes.dart';
import 'package:app/Widget/flipped_image.dart';
import 'package:flutter/material.dart';

class FavoriteImagesList extends StatelessWidget {
  FavoriteImagesList({Key key, this.favoriteImages}) : super(key: key);

  final List<GalleryImage> favoriteImages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteImages.length,
      itemBuilder: (context, index) {
        return FlippedImage(
          opacity: 1.0,
          image: favoriteImages[index]
        );
      },
    );
  }
}
