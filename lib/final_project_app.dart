import 'package:app/Utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'Page/login_page.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:provider/provider.dart';
import 'package:app/Style/style.dart';

class FinalProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppLocale(),
        child: Consumer<AppLocale>(builder: (context, locale, child) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'Final Project Home Page',
            locale: locale.locale,
            theme: snapixTheme,
            home: LoginPage(),
          );
        }));
  }
}
