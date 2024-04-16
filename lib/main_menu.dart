import 'package:flutter/material.dart';
import 'package:game/main.dart';

class MainMenu extends StatelessWidget {
  final TrainGame game;
  int? highScore;
   MainMenu({super.key, required this.game, required this.highScore});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("High Score : $highScore",style: TextStyle(fontSize: 24),),
            SizedBox(
              height: 100,
              width: 100,
              child: ElevatedButton(
                style: ButtonStyle(
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Colors.red)
                  )
                )
                ),
                  onPressed: () {
                    game.resumeEngine();
                    game.overlays.remove('MainMenu');
                  },
                  child: Text("Play")),
            ),
          ],
        ),
      ),
    );
  }
}
