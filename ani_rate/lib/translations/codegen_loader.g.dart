// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "login": "Login",
  "sign_up": "Sign Up",
  "password": "Password",
  "account": "Account",
  "reet_password": "Reset Password",
  "change_language": "Change Launguage",
  "remove_account": "Remove Account",
  "search_anime": "Search anime...",
  "all_anime": "All anime",
  "tags": "TAGS"
};
static const Map<String,dynamic> hr = {
  "login": "Prijava",
  "sign_up": "Registracija",
  "password": "Lozinka",
  "account": "Korisnički Račun",
  "reet_password": "Ponovno postavi lozinku",
  "change_language": "Promijeni Jezik",
  "remove_account": "Izbriši Račun",
  "search_anime": "Pretražite anime..",
  "all_anime": "Svaki anime",
  "tags": "KLJUČNE RIJEČI"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "hr": hr};
}
