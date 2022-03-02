import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../themes/colors.dart';

class CurrentPlayerWidget extends StatefulWidget {
  final String player;
  final Color color;

  const CurrentPlayerWidget(
      {Key? key, required this.player, required this.color})
      : super(key: key);

  @override
  _CurrentPlayerWidgetState createState() => _CurrentPlayerWidgetState();
}

class _CurrentPlayerWidgetState extends State<CurrentPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        height: 35,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.color, borderRadius: BorderRadius.circular(5)),
              height: 30,
              width: 290,
              child: Center(
                child: Text(
                  'current-player'.i18n() + widget.player,
                  style: const TextStyle(
                      fontSize: 10,
                      fontFamily: "PressStart2P",
                      color: AppColors.primary),
                ),
              ),
            ),
          ],
        ));
  }
}
