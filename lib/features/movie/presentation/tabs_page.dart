import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:empaire_film/features/movie/presentation/page/favorites.dart';
import 'package:empaire_film/features/movie/presentation/page/home.dart';
import 'package:empaire_film/features/movie/presentation/widget/app_bar/app_bar.dart';
import 'package:empaire_film/config/constant/lang_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(GetFavoriteMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: IndexedStack(
        index: currentTab,
        children: const [
          HomeScreen(),
          FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: BottomNavigationBar(
          items: List.generate(
            navTitles.length,
            (i) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Icon(
                  navIcons[i],
                ),
              ),
              label: navTitles[i].tr(),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Icon(
                  navIcons[i],
                  color: Theme.of(context)
                      .elevatedButtonTheme
                      .style!
                      .foregroundColor
                      ?.resolve({WidgetState.selected}),
                ),
              ),
            ),
          ),
          currentIndex: currentTab,
          onTap: (index) => setState(() => currentTab = index),
          selectedItemColor: Theme.of(context)
              .elevatedButtonTheme
              .style!
              .foregroundColor
              ?.resolve({WidgetState.selected}),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          elevation: 8,
        ),
      ),
    );
  }
}

final List<String> navTitles = [
  LangKeys.movies,
  LangKeys.favorites,
];

final List<IconData> navIcons = [
  Iconsax.video_play,
  Iconsax.heart,
];
