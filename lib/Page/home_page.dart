import 'package:app/Networking/APIRequest.dart';
import 'package:app/Networking/classes.dart';
import 'package:app/Page/search_page.dart';
import 'package:app/Page/upload_page.dart';
import 'package:app/Section/Drawer/drawer_section.dart';
import 'package:app/Utils/app_locale.dart';
import 'package:app/Widget/feed_gallery.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:app/globals.dart' as global;
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey bottomNavigationKey;
  TabController _tabController;
  List<Widget> _tabs = [
    Tab(text: "Recent"),
    Tab(text: "Top"),
    Tab(text: "Viral")
  ];
  bool _visible = true;
  Future _profileInfoFuture;
  int _currentPage = 0;

  @override
  initState() {
    bottomNavigationKey = GlobalKey();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _profileInfoFuture = getAccountSettings(global.accessToken);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void setVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  //Tab Selection
  Widget _getCurrentPage(int curr, DataAccountSettings profile) {
    switch (curr) {
      case 0:
        return TabBarView(
          controller: _tabController,
          children: [
            FeedGallery(
              sort: "time",
              viral: profile.showViral,
              mature: profile.showMature,
              visible: _visible,
            ),
            FeedGallery(
              sort: "top",
              viral: profile.showViral,
              mature: profile.showMature,
              visible: _visible,
            ),
            FeedGallery(
              sort: "viral",
              viral: profile.showViral,
              mature: profile.showMature,
              visible: _visible,
            )
          ],
        );
      case 1:
        return SearchPage(visible: _visible);
      default:
        return UploadPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _language = Provider.of<AppLocale>(context);
    return FutureBuilder<PostAccountSettings>(
        future: _profileInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.success) {
            global.username = snapshot.data.data.accountUrl;
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                actions: [
                  //language selectors
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      setState(() {
                        _language.changeLocale(result);
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'en',
                        child: Text('EN 🇬🇧'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'fr',
                        child: Text('FR 🇫🇷'),
                      ),
                    ],
                  ),
                ],
                bottom: _currentPage == 0
                    ? TabBar(
                        controller: _tabController,
                        tabs: _tabs,
                      )
                    : null,
              ),
              floatingActionButton: _currentPage != 2
                  ? FloatingActionButton(
                      backgroundColor: _visible ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                      onPressed: setVisibility,
                      child: Icon(Icons.flip, color: !_visible ? Theme.of(context).primaryColor : Theme.of(context).accentColor,),
                      tooltip: AppLocalizations.of(context).hideImage,
                    )
                  : null,
              drawer: Drawer(
                child: DrawerSection(
                  profileInfo: snapshot.data.data,
                ),
              ),
              body: _getCurrentPage(_currentPage, snapshot.data.data),
              bottomNavigationBar: FancyBottomNavigation(
                barBackgroundColor: Theme.of(context).bottomAppBarColor,
                activeIconColor: Theme.of(context).accentColor,
                initialSelection: 0,
                key: bottomNavigationKey,
                onTabChangedListener: (position) {
                  setState(() {
                    _currentPage = position;
                  });
                },
                tabs: [
                  TabData(iconData: Icons.home, title: AppLocalizations.of(context).bottomBarHome),
                  TabData(iconData: Icons.search_rounded, title: AppLocalizations.of(context).bottomBarSearch),
                  TabData(
                    iconData: Icons.upload_file,
                    title: AppLocalizations.of(context).bottomBarUpload,
                  )
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
