import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter/services.dart';
import 'package:portfolio/pages/game_over_menu.dart';
import 'package:portfolio/pages/game_world.dart';

class MainGame extends FlameGame<GameWorld>
    with KeyboardEvents, HasGameRef<MainGame>, HasCollisionDetection {
  bool gameOver = false;
  bool showGameOverScreen = false;
  MainGame() : super(world: GameWorld());
  late final RouterComponent router;

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 255, 255, 255);
  }

  @override
  void onLoad() async {
    super.onLoad();
    add(router = RouterComponent(initialRoute: 'gameplay', routes: {
      'gameplay': Route(GameWorld.new),
      'gameover': Route(GameOverMenu.new),
    }));
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const double moveSpeed = 55.0;
    Vector2 velocity = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      velocity.y = -moveSpeed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      velocity.y = moveSpeed;
    }

    world.player.move(velocity);

    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      world.player.shoot();
      return KeyEventResult.handled;
    }

    if (event is KeyUpEvent && keysPressed.isEmpty) {
      world.player.move(Vector2.zero());
    }

    return KeyEventResult.ignored;
  }
}
