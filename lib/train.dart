import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:game/config.dart';
import 'package:game/main.dart';

class Train extends RiveComponent
    with CollisionCallbacks, HasGameRef<TrainGame> {
  final Artboard trainArtboard;
  late final RiveComponent train;
  late final StateMachineController? controller;
  int initialPosition = 2;
  late RectangleHitbox hitBox;
  // late PositionComponent subComponent;

  Train({required this.trainArtboard})
      : super(artboard: trainArtboard, priority: 3) {
    debugMode = true;
  }
  @override
  Future<void> onLoad() async {
    hitBox = RectangleHitbox(
      anchor: Anchor.center,
      size: Vector2(120, 140),
      position: Vector2(gameWidth / 2, 730),
    );
    add(hitBox);
    controller = StateMachineController.fromArtboard(
      trainArtboard,
      'State Machine 1',
    );
    trainArtboard.addController(controller!);
    train = RiveComponent(artboard: trainArtboard);
    print(trainArtboard.children.first.runtimeType);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // print(hitBox.position);
    super.update(dt);
  }

  void changeTrack(double trainInTrack) {
    if (trainInTrack == 1) {
      controller!.inputs.first.value = (1.toDouble());
    } else if (trainInTrack == 2) {
      controller!.inputs.first.value = (2.toDouble());
    } else {
      controller!.inputs.first.value = (3.toDouble());
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    game.pauseEngine();
    game.overlays.add("gameOverMenu");
    print("Hit");
    super.onCollisionStart(intersectionPoints, other);
  }


}
