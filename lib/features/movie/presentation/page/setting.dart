import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/data/models/language.dart';

import 'package:empaire_film/features/movie/presentation/widget/app_bar/app_bar.dart';
import 'package:empaire_film/config/constant/lang_keys.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genralAppBar(context, LangKeys.settings.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              LangKeys.language.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ...List.generate(
              languages.length,
              (index) => LanguageTile(
                language: languages[index],
                onTap: () => context.setLocale(languages[index].locale),
              ),
            )
          ],
        ),
      ),
    );
  }

  final languages = [
    Language(
      logo: "assets/images/country_logo/ku.png",
      locale: const Locale('fa'),
    ),
    Language(
      logo: "assets/images/country_logo/en.jpg",
      locale: const Locale('en'),
    ),
    Language(
      logo: "assets/images/country_logo/iraq.png",
      locale: const Locale('ar'),
    ),
  ];
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.language,
    required this.onTap,
  });

  final void Function()? onTap;
  final Language language;

  @override
  Widget build(BuildContext context) {
    inspect(context.locale.countryCode);
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.5),
        width: double.infinity,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            language.logo,
                          ))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  language.locale.languageCode.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            if (context.locale.languageCode == language.locale.languageCode)
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(0.1)),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
