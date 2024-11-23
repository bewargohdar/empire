import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/presentation/page/setting.dart';
import 'package:empaire_film/utils/constant/lang_keys.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(BuildContext context) {
  return AppBar(
    title: Text(LangKeys.appName.tr()),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SettingsScreen();
          }));
        },
        icon: const Icon(Icons.settings),
      ),
    ],
  );
}

AppBar genralAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SettingsScreen();
          }));
        },
        icon: const Icon(Icons.settings),
      ),
    ],
  );
}
