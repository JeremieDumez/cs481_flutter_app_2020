import 'package:app/Networking/APIRequest.dart';
import 'package:app/Networking/classes.dart';
import 'package:app/Widget/flipped_image.dart';
import 'package:app/globals.dart' as global;
import 'package:flutter/material.dart';

class FeedGallery extends StatefulWidget {
  FeedGallery({Key key, this.sort, this.viral, this.mature, this.visible})
      : super(key: key);

  final String sort;
  final bool viral;
  final bool mature;
  final bool visible;

  @override
  _FeedGalleryState createState() => _FeedGalleryState();
}

class _FeedGalleryState extends State<FeedGallery> {
  List<GalleryImage> _items;
  bool _isLoading = false;
  int _searchPage = 1;

  @override
  void initState() {
    _items = List<GalleryImage>();
    getResearchData(getGallery(widget.sort, "all", _searchPage, widget.viral,
        widget.mature, global.accessToken));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getResearchData(Future research) async {
    research.then((result) {
      if (mounted) {
        setState(() {
          for (int i = 0; i != result.data.length; i++)
            if (!_items.contains(result.data[i])) _items.add(result.data[i]);
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                setState(() {
                  _searchPage += 1;
                  _isLoading = true;
                });
                getResearchData(getGallery(widget.sort, "all", _searchPage,
                    widget.viral, widget.mature, global.accessToken));
              }
              return true;
            },
            child: _items.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return FlippedImage(
                          opacity: widget.visible ? 1.0 : 0.0,
                          image: _items[index]);
                    },
                  ),
          ),
        ),
        Container(
          height: _isLoading ? 50.0 : 0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
