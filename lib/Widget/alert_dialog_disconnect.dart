import 'package:app/Page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:app/globals.dart' as global;

class AlertDialogDisconnect extends StatelessWidget {
  Future<void> disconnect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('accessToken');
    global.username = "";
    global.accessToken = "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).disconnect),
      scrollable: true,
      content: Text(AppLocalizations.of(context).disconnectAlert),
      actions: [
        TextButton(
            onPressed: () {
              disconnect().then((value) => Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  })));
            },
            child: Text(AppLocalizations.of(context).yes)),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).no)),
      ],
    );
  }
}
