import 'package:app/Page/home_page.dart';
import 'package:app/Widget/connect_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as glob;
import './authorize_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessTokenSave = prefs.getString('accessToken');
    print(accessTokenSave);
    //check for a login token previously stored
    if (accessTokenSave != null) {
      glob.accessToken = accessTokenSave;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MyHomePage(title: "Snapix");
      }));
      //If one isn't found, then return the OAuth page
    } else {
      glob.accessToken = "";
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return AuthorizeScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("./assets/snapixBg.png"),
          ConnectButton(onPressed: _onPressed),
        ],
      ),
    );
  }
}
