import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './AppLanguage.dart';
import 'app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  AppLanguage appLanguage = AppLanguage();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', ''),
            AppLocalizations.CHN, // 'zh_Hans_CN'
            AppLocalizations.HK, // 'zh_Hant_HK'
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: AppLang(),
        );
      }),
    );
  }
}

class AppLang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('Message'),
              style: TextStyle(fontSize: 32),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    appLanguage.changeLanguage(Locale("en"));
                  },
                  child: Text('English'),
                ),
                RaisedButton(
                  onPressed: () {
                    appLanguage.changeLanguage(Locale("ar"));
                  },
                  child: Text('العربي'),
                ),
                RaisedButton(
                  onPressed: () {
                    appLanguage.changeLanguage(AppLocalizations.CHN);
                  },
                  child: Text('中文简体'),
                ),
                RaisedButton(
                  onPressed: () {
                    appLanguage.changeLanguage(AppLocalizations.HK);
                  },
                  child: Text('中文繁體'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
