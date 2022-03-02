import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/modules/ad_state.dart';
import 'package:tictactoe/shared/Widgets/current_player_widget.dart';
import 'package:tictactoe/shared/Widgets/winner_widget.dart';

import 'package:tictactoe/shared/themes/colors.dart';

import '../shared/Widgets/button_widget.dart';
import '../shared/themes/themes.dart';
import '../shared/utils.dart';
import '../shared/player.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  static const countMatrix = 3;
  static const double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyScoreFields() {
    Player.p1score = 0;
    Player.p2score = 0;
    Player.score = 0;
    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
        countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
      ));

  String p1 = Player.player1;
  String p2 = Player.player2;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    int p1score = Player.p1score;
    int p2score = Player.p2score;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            setEmptyScoreFields();
            Navigator.of(context).pushReplacementNamed('home');
          },
        ),
        title: Center(
          child: Text(
            'game-title'.i18n(),
            style: const TextStyle(
              fontFamily: "PressStart2P",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              height: 110,
              width: 300,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.p1,
                          borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: 280,
                      child: Center(
                        child: Text(
                          "$p1:$p1score",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "PressStart2P",
                              color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.p2,
                          borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: 280,
                      child: Center(
                        child: Text(
                          "$p2:$p2score",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "PressStart2P",
                              color: AppColors.primary),
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 25),
            if (banner == null)
              const SizedBox(height: 50)
            else
              // ignore: sized_box_for_whitespace
              Container(height: 50, child: AdWidget(ad: banner!)),
            const SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
            ),
            const SizedBox(height: 25),
            Player.currentPlayer == Player.X
                ? CurrentPlayerWidget(
                    color: AppColors.p1,
                    player: p1,
                  )
                : CurrentPlayerWidget(
                    color: AppColors.p2,
                    player: p2,
                  )
          ],
        ),
      ),
    );
  }

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        values,
        (y, value) => buildField(x, y),
      ),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return AppColors.p1;
      case Player.X:
        return AppColors.p2;
      default:
        return AppColors.secondary;
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getFieldColor(value);

    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(size, size),
          primary: color,
        ),
        child: Text(value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 32,
              fontFamily: "PressStart2P",
            )),
        onPressed: () => selectField(value, x, y),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
        Player.currentPlayer = newValue;
      });

      if (isWinner(x, y)) {
        if (newValue == Player.O) {
          showEndDialog(
            'player'.i18n() + p1 + ' ' + 'won'.i18n(),
          );
          Player.p1score++;
        } else if (newValue == Player.X) {
          showEndDialog(
            'player'.i18n() + p2 + ' ' + 'won'.i18n(),
          );
          Player.p2score++;
        }
        Player.score++;
      } else if (isEnd()) {
        showEndDialog(
          'no-winner'.i18n(),
        );
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  /// Check out logic here: https://stackoverflow.com/a/1058804
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    const n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          title: Column(
            children: [
              Player.currentPlayer == Player.O
                  ? WinnerWidget(
                      player: p1,
                      style: TextStyles.p1,
                      styleb: TextStyles.p1b,
                    )
                  : WinnerWidget(
                      player: p2,
                      style: TextStyles.p2,
                      styleb: TextStyles.p2b,
                    )
            ],
          ),

          // style: TextStyle(color: AppColors.p1)), ignore: sized_box_for_whitespace

          content: Container(
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            height: 40,
            child: Center(
                child: Player.score == 3
                    ? Text('rematch-text'.i18n(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold))
                    : Text('new-round-text'.i18n(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold))),
          ),

          actions: [
            Player.score == 3
                ? ElevatedButtonWidget(
                    primary: AppColors.p1,
                    onPressed: () {
                      setEmptyScoreFields();
                      Navigator.of(context).pop();
                    },
                    text: 'rematch-button'.i18n(),
                  )
                : ElevatedButtonWidget(
                    onPressed: () {
                      setEmptyFields();
                      Navigator.of(context).pop();
                    },
                    text: 'new-round'.i18n(),
                    primary: AppColors.p1,
                  ),
            ElevatedButtonWidget(
              onPressed: () {
                setEmptyScoreFields();
                Navigator.of(context).pushReplacementNamed('home');
              },
              primary: AppColors.p2,
              text: 'exit-button'.i18n(),
            )
          ],
        ),
      );
}
