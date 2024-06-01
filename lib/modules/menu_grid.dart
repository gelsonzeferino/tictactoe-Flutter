import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tictactoe/shared/game_controller.dart';

import 'home_page.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      children:  [
        MyButton(icon: Icons.home, text: 'Pessoa vs Pessoa', onTap: () {  Navigator.of(context).pushReplacementNamed('home'); GameController.gameMode = 'PP'; },),
        MyButton(icon: Icons.search, text: 'Pessoa vs Computador', onTap: () { Navigator.of(context).pushReplacementNamed('home'); GameController.gameMode = 'PC';  },),
        MyButton(icon: Icons.online_prediction, text: 'Online', onTap: () {  },),
        MyButton(icon: Icons.settings, text: 'Settings', onTap: () {  },),
      ],
    );
  }
}


class MyButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback  onTap;

  const MyButton({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}