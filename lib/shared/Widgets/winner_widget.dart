import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../player.dart';

class WinnerWidget extends StatelessWidget {
  final String player;
  final TextStyle style;
  final TextStyle styleb;

  const WinnerWidget(
      {Key? key,
      required this.player,
      required this.style,
      required this.styleb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(218, 25, 42, 50),
          borderRadius: BorderRadius.circular(30)),
      height: 300,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text.rich(
              TextSpan(
                text: 'player'.i18n() + '\n' + '\n',
                style: (styleb),
                children: [
                  TextSpan(text: player + '\n', style: style),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            subtitle: Player.score == 3
                ? Text('won-game'.i18n(),
                    textAlign: TextAlign.center, style: styleb)
                : Text('won'.i18n(),
                    textAlign: TextAlign.center, style: styleb),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              height: 150, width: 150, child: Image.asset('assets/trophy.png'))
        ],
      ),
    );
  }
}
