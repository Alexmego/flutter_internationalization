import 'package:flutter/material.dart';
import 'package:flutter_internationalizationn/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');
  static const LANGUAGE_CODE = "language_code";
  static const COUNTRY_CODE = "country_code";

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(LANGUAGE_CODE) == null) {
      _appLocale = Locale('en');
      return Null;
    }
    String countryCode = prefs.getString(COUNTRY_CODE);
    if (countryCode != null && countryCode != '') {
      if ('HK' == countryCode) {
        _appLocale = AppLocalizations.HK;
      }
      if ('CN' == countryCode) {
        _appLocale = AppLocalizations.CHN;
      }
    } else {
      _appLocale = Locale(prefs.getString(LANGUAGE_CODE));
    }

    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString(LANGUAGE_CODE, 'ar');
      await prefs.setString(COUNTRY_CODE, '');
    } else if (type == Locale("en")) {
      _appLocale = Locale("en");
      await prefs.setString(LANGUAGE_CODE, 'en');
      await prefs.setString(COUNTRY_CODE, '');
    } else if (type.countryCode == 'CN') {
      _appLocale = AppLocalizations.CHN;
      await prefs.setString(LANGUAGE_CODE, 'zh');
      await prefs.setString(COUNTRY_CODE, 'CN');
    } else {
      _appLocale = AppLocalizations.HK;
      await prefs.setString(LANGUAGE_CODE, 'zh');
      await prefs.setString(COUNTRY_CODE, 'HK');
    }
    notifyListeners();
  }
}
