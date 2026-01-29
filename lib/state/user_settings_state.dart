import 'package:flutter/material.dart';

class UserSettings {
  String sourceLang;
  String targetLang;

  UserSettings({required this.sourceLang, required this.targetLang});
}

class UserSettingsState extends ChangeNotifier {
  final UserSettings settings = UserSettings(
    sourceLang: "English",
    targetLang: "Spanish",
  );

  void setSourceLang(String lang) {
    settings.sourceLang = lang;
    notifyListeners();
  }

  void setTargetLang(String lang) {
    settings.targetLang = lang;
    notifyListeners();
  }
}
