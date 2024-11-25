import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/presentation/page/setting.dart';
import 'package:empaire_film/config/constant/lang_keys.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

AppBar mainAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        Text(
          LangKeys.appName.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SettingsScreen();
          }));
        },
        icon: const Icon(
          Iconsax.setting_2,
          size: 26,
        ),
      ),
    ],
  );
}

AppBar genralAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      iconSize: 26,
      padding: EdgeInsets.zero,
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
  );
}
