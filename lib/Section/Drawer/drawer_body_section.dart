import 'package:app/Networking/classes.dart';
import 'package:app/Networking/APIRequest.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/globals.dart' as global;
import 'package:flutter_gen/gen_l10n/localization.dart';

class DrawerBodySection extends StatefulWidget {
  DrawerBodySection({Key key, this.profileInfo}) : super(key: key);

  final DataAccountSettings profileInfo;

  @override
  _DrawerBodySectionState createState() => _DrawerBodySectionState();
}

class _DrawerBodySectionState extends State<DrawerBodySection> {
  @override
  void initState() {
    super.initState();
  }

  void updateNewsletter(bool value) {
    changeAccountSettings(
        'newsletter_subscribed', '$value', global.accessToken);
    setState(() {
      widget.profileInfo.newsletter = value;
    });
  }

  void updateFilterMature(bool value) {
    changeAccountSettings('show_mature', '$value', global.accessToken);
    setState(() {
      widget.profileInfo.showMature = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(AppLocalizations.of(context).profileSectionTitleJoined,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).accentColor,
                          letterSpacing: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      size: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 5),
            child: Text(
              DateFormat.yMMMMd(AppLocalizations.of(context).localeName)
                  .format(widget.profileInfo.created)
                  .toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 50, left: 10),
              child: Row(
                children: <Widget>[
                  Text(AppLocalizations.of(context).profileSectionTitleAbout,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).accentColor,
                          letterSpacing: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.info_rounded,
                        size: 20, color: Theme.of(context).accentColor),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 5),
            child: Text(
              widget.profileInfo.bio,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(letterSpacing: 1.0, color: Colors.white),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 50, left: 10),
              child: Row(
                children: <Widget>[
                  Text("EMAIL",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).accentColor,
                          letterSpacing: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.email_rounded,
                        size: 20, color: Theme.of(context).accentColor),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 15, left: 10, right: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.profileInfo.email,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              letterSpacing: 1.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context)
                              .profileNewsletterSubscription,
                          style: TextStyle(
                              letterSpacing: 1.0, color: Colors.white)),
                      Switch(
                        value: widget.profileInfo.newsletter,
                        onChanged: (value) => updateNewsletter(value),
                        activeTrackColor: Colors.greenAccent,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.redAccent,
                      )
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 50, left: 10),
              child: Row(
                children: <Widget>[
                  Text(AppLocalizations.of(context).profileSectionTitleFilters,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).accentColor,
                          letterSpacing: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.filter_alt_rounded,
                        size: 20, color: Theme.of(context).accentColor),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 15, left: 10, right: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context).profileShowViralContent,
                          style: TextStyle(
                              letterSpacing: 1.0, color: Colors.white)),
                      Icon(Icons.check_circle, color: Colors.greenAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context).profileShowMatureContent,
                          style: TextStyle(
                              letterSpacing: 1.0, color: Colors.white)),
                      Switch(
                        value: widget.profileInfo.showMature,
                        onChanged: (value) => updateFilterMature(value),
                        activeTrackColor: Colors.greenAccent,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.redAccent,
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
