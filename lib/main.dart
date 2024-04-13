import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game/config.dart';
import 'package:game/crossing_train.dart';
import 'package:game/enemy.dart';
import 'package:game/main_menu.dart';
import 'package:game/track.dart';
import 'package:game/train.dart';
import 'package:game/world.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // int? highScore = prefs.getInt('HighScore');

  Flame.device.fullScreen();
  Flame.device.setPortrait();
  RiveFile riveFile = await RiveFile.asset('assets/rive/final.riv');
  TrainGame game = TrainGame(riveFile: riveFile);

  runApp(
    GameWidget<TrainGame>(
      game: kDebugMode ? TrainGame(riveFile: riveFile) : game,
      overlayBuilderMap: {
        'MainMenu': (context, game) {
          game.pauseEngine();
          return MainMenu(game: game);
        },
        'gameOverMenu': (context, game) {
          return Center(child: Text('Game Over'));
        },
      },
      initialActiveOverlays: ['MainMenu'],
    ),
  );
}

class TrainGame extends FlameGame
    with HorizontalDragDetector, HasCollisionDetection {
  final RiveFile riveFile;
  late World myWorld;
  late Train train;
  late Track track;
  late CrossingTrain crossingTrain1;
  late CrossingTrain crossingTrain2;
  late Enemy enemy;
  int score = 0;
  TrainGame({required this.riveFile})
      : super(
            world: MyWorld(
                worldArtboard:
                    riveFile.artboardByName('Background')!.instance())) {
    myWorld = world;
    camera = CameraComponent.withFixedResolution(
      world: myWorld,
      width: gameWidth,
      height: gameHeight,
    );
    camera.viewfinder.anchor = Anchor.center;
  }
  @override
  FutureOr<void> onLoad() {
    myWorld.addAll([
      TextComponent(
        text: 'Score : $score',
        position: Vector2.all(100),
        priority: 10,
      ),
      Track(
        trackArtboard: riveFile.artboardByName('Track')!.instance(),
      )..anchor = Anchor.center,
      Track(
        trackArtboard: riveFile.artboardByName('Track')!.instance(),
      )
        ..anchor = Anchor.center
        ..position = Vector2(-364, 0),
      Track(
        trackArtboard: riveFile.artboardByName('Track')!.instance(),
      )
        ..anchor = Anchor.center
        ..position = Vector2(364, 0),
      train = Train(trainArtboard: riveFile.artboardByName('Train')!.instance())
        ..anchor = Anchor.center
        ..position = Vector2(0, 800),
      SpawnComponent.periodRange(
          factory: (i) {
            List<int> values = [1, 2, 3];
            Random random = Random();
            int randomIndex = random.nextInt(values.length);
            int randomNumber = values[randomIndex];
            FlameAudio.play('horn.mp3');
            print(randomNumber);
            if (randomNumber == 1) {
              return Enemy(
                enemy1: CrossingTrain(
                    crossingTrainArtboard:
                        riveFile.artboardByName('Crossing Train')!.instance(),
                    position: Vector2(-364, -1200))
                  ..anchor = Anchor.bottomCenter,
                enemy2: CrossingTrain(
                    crossingTrainArtboard:
                        riveFile.artboardByName('Crossing Train')!.instance(),
                    position: Vector2(356, -1200))
                  ..anchor = Anchor.bottomCenter,
              );
            }
            if (randomNumber == 2) {
              return Enemy(
                enemy1: CrossingTrain(
                    crossingTrainArtboard:
                        riveFile.artboardByName('Crossing Train')!.instance(),
                    position: Vector2(0, -1200))
                  ..anchor = Anchor.bottomCenter,
                enemy2: CrossingTrain(
                    crossingTrainArtboard:
                        riveFile.artboardByName('Crossing Train')!.instance(),
                    position: Vector2(356, -1200))
                  ..anchor = Anchor.bottomCenter,
              );
            } else {
              return Enemy(
                enemy1: CrossingTrain(
                    crossingTrainArtboard:
                        riveFile.artboardByName('Crossing Train')!.instance(),
                    position: Vector2(0, -1200))
                  ..anchor = Anchor.bottomCenter,
                enemy2: CrossingTrain(
                    crossingTrainArtboard:
                        riveFile.artboardByName('Crossing Train')!.instance(),
                    position: Vector2(-356, -1200))
                  ..anchor = Anchor.bottomCenter,
              );
            }
          },
          selfPositioning: true,
          minPeriod: 7,
          maxPeriod: 12),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    score++;
    super.update(dt);
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    if (info.primaryVelocity != null) {
      if (info.primaryVelocity!.isNegative) {
        switch (train.initialPosition) {
          case 2:
            train.changeTrack(1);
            train.initialPosition = 1;
            Future.delayed(const Duration(milliseconds: 800), () {
              train.hitBox.position = Vector2(gameWidth / 5.5, 730);
            });
            break;
          case 3:
            train.changeTrack(2);
            train.initialPosition = 2;
            Future.delayed(const Duration(milliseconds: 800), () {
              train.hitBox.position = Vector2(gameWidth / 2, 730);
            });
            break;
        }
        // print(1);
      } else {
        switch (train.initialPosition) {
          case 2:
            train.changeTrack(3);
            train.initialPosition = 3;
            Future.delayed(const Duration(milliseconds: 800), () {
              train.hitBox.position = Vector2(gameWidth / 1.2, 730);
            });
            break;
          case 1:
            train.changeTrack(2);
            train.initialPosition = 2;
            Future.delayed(const Duration(milliseconds: 800), () {
              train.hitBox.position = Vector2(gameWidth / 2, 730);
            });
            break;
        }
        // print(2);
      }
    }
    super.onHorizontalDragEnd(info);
  }

  void resetGame() {
    train.position = Vector2(0, 800);
  }
}
