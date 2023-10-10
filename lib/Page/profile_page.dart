import 'package:app/Networking/classes.dart';
import 'package:app/Section/favorite_images_list.dart';
import 'package:app/Section/posted_images_list.dart';
import 'package:app/Section/profile_header_section.dart';
import 'package:app/Section/recap_section.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(
      {Key key, this.profileInfo, this.favoriteImages, this.postedImages})
      : super(key: key);

  final DataAccountSettings profileInfo;
  final List<GalleryImage> favoriteImages;
  final List<GalleryImage> postedImages;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  List<Widget> _tabs = [
    Tab(icon: Icon(Icons.image)),
    Tab(icon: Icon(Icons.favorite)),
    Tab(icon: Icon(Icons.check_box))
  ];
  TabController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    _controller = TabController(length: _tabs.length, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 275,
                flexibleSpace: ProfileHeaderSection(
                  name: widget.profileInfo.accountUrl,
                  coverUrl: widget.profileInfo.avatar,
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: TabBar(
                    controller: _controller,
                    tabs: _tabs,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: <Widget>[
              PostedImagesList(
                postedImages: widget.postedImages,
              ),
              FavoriteImagesList(
                favoriteImages: widget.favoriteImages,
              ),
              RecapSection(
                postedImages: widget.postedImages,
                favoriteImages: widget.favoriteImages,
              )
            ],
          ),
        ),
      ),
    );
  }
}
