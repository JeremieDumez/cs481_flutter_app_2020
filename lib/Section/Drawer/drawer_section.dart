import 'package:app/Networking/APIRequest.dart';
import 'package:app/Networking/classes.dart';
import 'package:app/Page/profile_page.dart';
import 'package:app/Section/Drawer/drawer_body_section.dart';
import 'package:app/Section/Drawer/drawer_header_section.dart';
import 'package:app/Widget/alert_dialog_disconnect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:app/globals.dart' as global;

class DrawerSection extends StatefulWidget {
  DrawerSection({Key key, this.profileInfo}) : super(key: key);

  final DataAccountSettings profileInfo;

  @override
  _DrawerSectionState createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  List<GalleryImage> favoriteImages = List<GalleryImage> ();
  List<GalleryImage> postedImages = List<GalleryImage> ();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final resFav = await getAccountFavorite(widget.profileInfo.accountUrl, global.accessToken);
    final resImg = await getAccountImages(global.accessToken);

    favoriteImages = resFav.data;
    postedImages = resImg.data;
  }

  void goToProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfilePage(
        profileInfo: widget.profileInfo,
        postedImages: postedImages,
        favoriteImages: favoriteImages,
      );
    }));
  }

  void disconnectUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogDisconnect();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: goToProfile,
          child: DrawerHeaderSection(profileInfo: widget.profileInfo)
        ),
        Expanded(
          child: DrawerBodySection(profileInfo: widget.profileInfo)
        ),
        ListTile(
          onTap: disconnectUser,
          leading: Icon(Icons.exit_to_app, color: Theme.of(context).accentColor),
          title: Text(AppLocalizations.of(context).disconnect, style: TextStyle(color: Theme.of(context).accentColor)),
        ),
      ],
    );
  }
}
