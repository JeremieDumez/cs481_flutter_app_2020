import '../globals.dart' as glob;
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.contains("access_token=") &&
          url.contains("&expires") &&
          glob.accessToken == "") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        glob.accessToken = url.split("access_token=")[1].split("&expires")[0];
        prefs.setString('accessToken', glob.accessToken);
        print("Token: \"" + glob.accessToken + "\"");
        flutterWebviewPlugin.dispose();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MyHomePage(title: "Snapix");
        }));
      }
    });
    return WebviewScaffold(
      url: glob.URL,
      clearCache: true,
      clearCookies: true,
    );
  }
}
