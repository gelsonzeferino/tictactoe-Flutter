import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/shared/themes/colors.dart';

import '../shared/player.dart';
import 'ad_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    String p1 = '';
    String p2 = '';
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
              height: 240,
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //Player 1
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 55,
                      child: TextField(
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        onChanged: (value) => p1 = value,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 10),
                          border: InputBorder.none,
                          suffixIcon: const Icon(Icons.circle_outlined,
                              color: AppColors.p1),
                          counterText: "",
                          labelText: 'player1_Input'.i18n(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //Player 2
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 50,
                      child: TextField(
                        maxLength: 10,
                        onChanged: (value) => p2 = value,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 10),
                            counterText: "",
                            labelText: 'player2-input'.i18n(),
                            suffixIcon:
                                const Icon(Icons.close, color: AppColors.p2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      if (isLoaded) {
                        interstitialAd!.show();
                      }
                      Player.player1 = p1;
                      Player.player2 = p2;
                      Navigator.of(context).pushReplacementNamed('game_page');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'button-newgame'.i18n(),
                        style: const TextStyle(
                          fontFamily: "PressStart2P",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
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
