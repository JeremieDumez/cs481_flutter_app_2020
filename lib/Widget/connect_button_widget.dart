import 'package:flutter/material.dart';

class ConnectButton extends StatelessWidget {
  ConnectButton({Key key, this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 150.0,
      height: 55.0,
      child: RaisedButton(
          child: Text(
            "Connect",
            style: TextStyle(fontSize: 35.0),
          ),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))),
    );
  }
}
