import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_rive/flame_rive.dart';

class MyWorld extends World with DragCallbacks {
  final Artboard worldArtboard;
  late final RiveComponent background;
  MyWorld({required this.worldArtboard}) : super(priority: 1);
  @override
  Future<void> onLoad() async {
    background = RiveComponent(artboard: worldArtboard);
    add(background..anchor = Anchor.center);
    return super.onLoad();
  }
}
