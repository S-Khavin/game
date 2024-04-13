import 'package:flame_rive/flame_rive.dart';

class Track extends RiveComponent {
  final Artboard trackArtboard;
  late SimpleAnimation animation;
  late final RiveComponent track;
  Track({required this.trackArtboard})
      : super(artboard: trackArtboard, priority: 2);
  @override
  Future<void> onLoad() async {
    animation = SpeedController("Timeline 1");
    trackArtboard.addController(animation);
    track = RiveComponent(artboard: trackArtboard);
    return super.onLoad();
  }
}

class SpeedController extends SimpleAnimation {
  double speedMultiplier;

  SpeedController(
    String animationName, {
    double mix = 1,
    this.speedMultiplier = 1,
  }) : super(animationName, mix: mix);

  @override
  void apply(RuntimeArtboard artboard, double elapsedSeconds) {
    if (instance == null || !instance!.keepGoing) {
      isActive = false;
    }
    instance!
      ..animation.apply(instance!.time, coreContext: artboard, mix: mix)
      ..advance(elapsedSeconds * speedMultiplier);
  }

  void setSpeed(double speed) {
    speedMultiplier = speed;
  }
}
