import 'package:easy_localization/easy_localization.dart';
import 'package:empaire_film/features/movie/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:empaire_film/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:empaire_film/features/movie/presentation/bloc/single_movie/single_movie_bloc.dart';
import 'package:empaire_film/features/movie/presentation/page/home.dart';
import 'package:empaire_film/server_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  init();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale("fa"),
      ],
      useOnlyLangCode: true,
      startLocale: const Locale('en'),
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MovieBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SingleMovieBloc>(),
        ),
        BlocProvider(create: (context) => sl<FavoriteBloc>()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Empaire Film',
        home: const HomeScreen(),
      ),
    );
  }
}
