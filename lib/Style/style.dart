import 'package:flutter/material.dart';

Map<int, Color> customPurpleColorCodes = {
  50: Color.fromRGBO(93, 69, 91, .1),
  100: Color.fromRGBO(93, 69, 91, .2),
  200: Color.fromRGBO(93, 69, 91, .3),
  300: Color.fromRGBO(93, 69, 91, .4),
  400: Color.fromRGBO(93, 69, 91, .5),
  500: Color.fromRGBO(93, 69, 91, .6),
  600: Color.fromRGBO(93, 69, 91, .7),
  700: Color.fromRGBO(93, 69, 91, .8),
  800: Color.fromRGBO(93, 69, 91, .9),
  900: Color.fromRGBO(93, 69, 91, 1),
};
MaterialColor customPurpleColor = new MaterialColor(0xff5d455b, customPurpleColorCodes);

Map<int, Color> customBeigeColorCodes = {
  50: Color.fromRGBO(237, 227, 192, .1),
  100: Color.fromRGBO(237, 227, 192, .2),
  200: Color.fromRGBO(237, 227, 192, .3),
  300: Color.fromRGBO(237, 227, 192, .4),
  400: Color.fromRGBO(237, 227, 192, .5),
  500: Color.fromRGBO(237, 227, 192, .6),
  600: Color.fromRGBO(237, 227, 192, .7),
  700: Color.fromRGBO(237, 227, 192, .8),
  800: Color.fromRGBO(237, 227, 192, .9),
  900: Color.fromRGBO(237, 227, 192, 1),
};
MaterialColor customBeigeColor = new MaterialColor(0xffede3c0, customBeigeColorCodes);

ThemeData snapixTheme = ThemeData(
    primarySwatch: customPurpleColor,
    primaryColor: customPurpleColor,
    accentColor: customBeigeColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: customBeigeColor[800],
    appBarTheme: AppBarTheme(color: customPurpleColor),
    canvasColor: customPurpleColor,
    backgroundColor: customPurpleColor,
    bottomAppBarColor: customBeigeColor,
);
