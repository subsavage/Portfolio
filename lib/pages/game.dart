import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/pages/game_world.dart';

class MainGame extends FlameGame<GameWorld> with KeyboardEvents {
  MainGame()
      : super(
          world: GameWorld(),
        );

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 255, 255, 255);
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const double moveSpeed = 55.0;

    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        world.player.move(moveSpeed);
        return KeyEventResult.handled;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        world.player.move(-moveSpeed);
        return KeyEventResult.handled;
      }
    } else if (event is KeyUpEvent) {
      world.player.move(0);
    }

    return KeyEventResult.ignored;
  }
}
