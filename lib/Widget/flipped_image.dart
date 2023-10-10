import 'package:app/Networking/classes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import '../Networking/APIRequest.dart';
//import 'dart:math' as math;
import 'package:app/globals.dart' as global;

class ImagePop extends StatelessWidget {
  final String link;

  ImagePop({Key key, @required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PinchZoom(
        image: Image.network(link),
        zoomedBackgroundColor: Colors.black.withOpacity(0.5),
        resetDuration: const Duration(milliseconds: 9999),
        maxScale: 3.0,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class FlippedImage extends StatefulWidget {
  FlippedImage({Key key, this.opacity, this.image}) : super(key: key);

  @required
  final double opacity;
  @required
  final GalleryImage image;

  @override
  _FlippedImageState createState() => _FlippedImageState();
}

class _FlippedImageState extends State<FlippedImage> {
  double _flip;
  Icon _favoriteIcon = Icon(Icons.favorite_border, color: Colors.redAccent);
  bool _toggleUp = false;
  bool _toggleDown = false;
  bool _isFavorite;
  bool first = true;
  Future _isFavFuture;

  @override
  void initState() {
    initVotes(widget.image.vote);
    _flip = 0.0;
    _isFavFuture = isImageFavorite(global.accessToken, widget.image.id);
    super.initState();
  }

  void initVotes(String vote) {
    if (vote == 'up')
      setState(() {
        _toggleUp = true;
      });
    else if (vote == 'down')
      setState(() {
        _toggleDown = true;
      });
  }

  void _addImageToFavorites() {
    addImageToFavorites(widget.image.id, global.accessToken).then((value) {
      setState(() {
        if (_isFavorite) {
          _isFavorite = false;
          _favoriteIcon = Icon(Icons.favorite_border, color: Colors.redAccent);
        } else {
          _isFavorite = true;
          _favoriteIcon = Icon(
            Icons.favorite,
            color: Colors.redAccent,
          );
        }
      });
    });
  }

  void _onUpVotePressed() async {
    if (_toggleUp == true) {
      final res =
          await addVoteToImage(widget.image.id, "veto", global.accessToken);
      if (res == true)
        setState(() {
          _toggleUp = false;
          widget.image.ups -= 1;
        });
      else
        print(res);
    } else {
      final res =
          await addVoteToImage(widget.image.id, "up", global.accessToken);
      if (res == true)
        setState(() {
          _toggleUp = true;
          widget.image.ups += 1;
          if (_toggleDown == true) {
            _toggleDown = false;
            widget.image.downs -= 1;
          }
        });
      else
        print(res);
    }
  }

  void _onDownVotePressed() async {
    if (_toggleDown == true) {
      final res =
          await addVoteToImage(widget.image.id, "veto", global.accessToken);
      if (res == true)
        setState(() {
          _toggleDown = false;
          widget.image.downs -= 1;
        });
      else
        print(res);
    } else {
      final res =
          await addVoteToImage(widget.image.id, "down", global.accessToken);
      if (res == true)
        setState(() {
          _toggleDown = true;
          widget.image.downs += 1;
          if (_toggleDown == true) {
            _toggleUp = false;
            widget.image.ups -= 1;
          }
        });
      else
        print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFavFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (first) {
            first = false;
            _isFavorite = snapshot.data;
            if (_isFavorite) {
              _favoriteIcon = Icon(
                Icons.favorite,
                color: Colors.red,
              );
            } else {
              _favoriteIcon =
                  Icon(Icons.favorite_border, color: Colors.redAccent);
            }
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: widget.opacity,
                    duration: Duration(milliseconds: 700),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(_flip),
                      child: Container(
                        alignment: FractionalOffset.center,
                        child: GestureDetector(
                            child: CachedNetworkImage(
                                imageUrl: widget.image.link,
                                errorWidget: (context, url, error) => Container(
                                      child: Column(
                                        children: [
                                          Icon(Icons.error, color: Colors.red),
                                          Text("Invalid URL",
                                              style: TextStyle(
                                                  color: Colors.redAccent))
                                        ],
                                      ),
                                    ),
                                fit: BoxFit.fitHeight,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        )),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImagePop(
                                      link: widget.image.link,
                                    ),
                                  ));
                              //setState(() {
                              // if (_flip == 0.0)
                              //    _flip = math.pi;
                              // else
                              //    _flip = 0.0;
                              // });
                            }),
                      ),
                    ),
                  ),
                  Container(
                    //height: 40,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          widget.image.title != null
                              ? widget.image.title
                              : "[Untitled image]",
                          //"test",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          widget.image.description != null
                              ? widget.image.description
                              : "",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                      _toggleUp
                                          ? Icons.thumb_up_alt_rounded
                                          : Icons.thumb_up_off_alt,
                                      color: Colors.blueAccent),
                                  onPressed: _onUpVotePressed,
                                ),
                                Text(widget.image.ups.toString())
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                      _toggleDown
                                          ? Icons.thumb_down_alt_rounded
                                          : Icons.thumb_down_off_alt,
                                      color: Colors.redAccent),
                                  onPressed: _onDownVotePressed,
                                ),
                                Text(widget.image.downs.toString())
                              ],
                            ),
                            IconButton(
                                icon: _favoriteIcon,
                                onPressed: _addImageToFavorites),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                color: Colors.grey[200],
              ));
        }
      },
    );
  }
}
