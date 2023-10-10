import 'package:app/Page/transform_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  ProfileHeaderSection({Key key, this.name, this.coverUrl}) : super(key: key);

  final String name;
  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return TransformPage();
                }));
              },
              child: CachedNetworkImage(
                imageUrl: coverUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
