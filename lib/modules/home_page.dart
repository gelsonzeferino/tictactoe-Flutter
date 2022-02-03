import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:localization/localization.dart';
import 'package:tictactoe/shared/themes/colors.dart';

import '../shared/player.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      height: 50,
                      child: TextField(
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        onChanged: (value) => p1 = value,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 5),
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
                            contentPadding: const EdgeInsets.only(left: 5),
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
                      Player.player1 = p1;
                      Player.player2 = p2;
                      Navigator.of(context).pushNamed('game_page');
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
          ],
        ),
      ),
    );
  }
}
