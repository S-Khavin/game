import 'package:flutter/material.dart';
import 'package:game/main.dart';

class MainMenu extends StatelessWidget {
  final TrainGame game;
  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              game.resumeEngine();
              game.overlays.remove('MainMenu');

            },
            child: Text("Play")),
      ),
    );
  }
}
