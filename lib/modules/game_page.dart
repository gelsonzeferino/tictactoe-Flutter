import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'package:tictactoe/shared/themes/colors.dart';

import '../shared/utils.dart';
import '../shared/player.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const countMatrix = 3;
  static const double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();

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
    int p1score = Player.p1score;
    int p2score = Player.p2score;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
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
            const SizedBox(height: 100),
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
            const SizedBox(height: 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
            ),
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
          title: Text(title),
          content: Text('dialog-text'.i18n()),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primary,
              ),
              onPressed: () {
                setEmptyFields();

                Navigator.of(context).pop();
              },
              child: Text('rematch-button'.i18n()),
            ),
            ElevatedButton(
              onPressed: () {
                setEmptyFields();
                Player.p1score = 0;
                Player.p2score = 0;
                Navigator.of(context).pushReplacementNamed('home');
              },
              child: Text('exit-button'.i18n()),
            )
          ],
        ),
      );
}