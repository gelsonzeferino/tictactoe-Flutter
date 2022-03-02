import 'package:flutter/material.dart';

import '../player.dart';
import '../themes/colors.dart';

class ScoreBoardWidget extends StatefulWidget {
  const ScoreBoardWidget({Key? key}) : super(key: key);

  @override
  State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String p1 = Player.player1;
    String p2 = Player.player2;
    int p1score = Player.p1score;
    int p2score = Player.p2score;

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
              color: AppColors.p2, borderRadius: BorderRadius.circular(5)),
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
    );
  }
}
