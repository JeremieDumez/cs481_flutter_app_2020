import 'package:flutter/material.dart';

class AppLocale extends ChangeNotifier {
  Locale _locale;

  Locale get locale => _locale ?? Locale('en');

  void changeLocale(String newLocale) {
    print(newLocale);
    if (newLocale == 'fr') {
      _locale = Locale('fr');
    } else {
      _locale = Locale('en');
    }
    notifyListeners();
  }
}
