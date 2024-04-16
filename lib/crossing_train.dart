import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

class CrossingTrain extends RiveComponent {
  final Artboard crossingTrainArtboard;
  late final RiveComponent crossingTrain;

  CrossingTrain({required this.crossingTrainArtboard,required super.position})
      : super(artboard: crossingTrainArtboard, priority: 3) {
    // debugMode = true;
    add(RectangleHitbox(
        size: Vector2(
            crossingTrainArtboard.width, crossingTrainArtboard.height)));
  }
  @override
  Future<void> onLoad() async {
    crossingTrain = RiveComponent(artboard: crossingTrainArtboard);
    return super.onLoad();
  }  
}
