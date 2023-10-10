import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/Networking/classes.dart';

class DrawerHeaderSection extends StatelessWidget {
  DrawerHeaderSection({Key key, this.profileInfo}) : super(key: key);

  final DataAccountSettings profileInfo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        profileInfo.cover != null
            ? Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: profileInfo.cover,
                  imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  )),
                ),
              )
            : Positioned.fill(
                child: Container(color: Theme.of(context).primaryColor)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 275,
          child: DrawerHeader(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.read_more_rounded,
                        color: Theme.of(context).accentColor,
                        size: 30,
                    ),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl: profileInfo.avatar,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(profileInfo.accountUrl,
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
                Text(
                  profileInfo.reputation +
                      ' PTS\t•\t' +
                      profileInfo.reputationName.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
