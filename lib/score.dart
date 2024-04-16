import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:game/main.dart';

class ScoreBoard extends TextBoxComponent {
  late TextComponent scoreBox;

  @override
  Future<void> onLoad() async {
    scoreBox = TextComponent()
      ..text = "Score : 0"
      ..textRenderer = TextPaint(
          style: TextStyle(
              color: BasicPalette.white.color,
              fontSize: 65,
              fontWeight: FontWeight.bold));
    add(scoreBox);
  }

  @override
  void update(double dt) {
    scoreBox.text = "Score : ${TrainGame.score}";
    super.update(dt);
  }
}
