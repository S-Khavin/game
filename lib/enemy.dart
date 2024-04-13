import 'dart:async';
import 'package:flame/components.dart';
import 'package:game/crossing_train.dart';

class Enemy extends PositionComponent {
  final CrossingTrain enemy1;
  final CrossingTrain enemy2;
  Enemy({required this.enemy1, required this.enemy2}) : super(priority: 3);

  @override
  Future<void> onLoad() async {
    await addAll([
      enemy1,
      enemy2,
    ]);
  }

  @override
  void update(double dt) {
    enemy1.y = enemy1.y + 600 * dt;
    enemy2.y = enemy1.y + 600 * dt;
    if (enemy1.y == 2440) {
      remove(enemy1);
    }
    if (enemy2.y == 2440) {
      remove(enemy2);
      
    }
    super.update(dt);
  }
}
