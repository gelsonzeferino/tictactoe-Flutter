import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/modules/menu_grid.dart';
import 'package:tictactoe/shared/themes/colors.dart';

import '../shared/player.dart';
import 'ad_state.dart';
import 'home_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  InterstitialAd? interstitialAd;
  bool isLoaded = false;
  BannerAd? banner2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);

    InterstitialAd.load(
      adUnitId: adState.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
          interstitialAd = ad;
        });
        print("Ad loaded");
      }, onAdFailedToLoad: (error) {
        print('InterstitialAd failed to load: $error.');
      }),
    );

    adState.initialization.then((status) {
      setState(() {
        banner2 = BannerAd(
          adUnitId: adState.bannerAdUnitId1,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5)),
              height: 380,
              width: 380,
              child: MenuGrid()
            ),
            const SizedBox(height: 25),
            if (banner2 == null)
              const SizedBox(height: 50)
            else
            // ignore: sized_box_for_whitespace
              Container(height: 50, child: AdWidget(ad: banner2!)),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
