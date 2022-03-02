import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'modules/game_page.dart';
import 'modules/home_page.dart';
import 'shared/themes/colors.dart';

class AppWidget extends StatelessWidget {
  static const String title = 'Jogo da Velha';

  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }

        if (locale?.countryCode == 'BR') {
          return const Locale('pt', 'BR');
        }

        return const Locale('en', 'US');
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal, primaryColor: AppColors.primary),
      initialRoute: "home",
      routes: {
        "home": (context) => const HomePage(),
        "game_page": (context) => const MainPage(),
      });
}
