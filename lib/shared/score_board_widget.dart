import 'package:flutter/material.dart';

import 'player.dart';
import 'themes/colors.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  static var p1placar = 1;
  static var p2placar = 3;

  @override
  Widget build(BuildContext context) {
    String p1 = Player.player1;
    String p2 = Player.player2;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      height: 110,
      width: 300,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.p1, borderRadius: BorderRadius.circular(5)),
          height: 40,
          width: 280,
          child: Center(
            child: Text(
              "$p1:$p1placar",
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
              color: AppColors.p2, borderRadius: BorderRadius.circular(5)),
          height: 40,
          width: 280,
          child: Center(
            child: Text(
              "$p2:$p2placar",
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "PressStart2P",
                  color: AppColors.primary),
            ),
          ),
        ),
      ]),
    );
  }
}
