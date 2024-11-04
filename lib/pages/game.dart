import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/pages/game_world.dart';

class MainGame extends FlameGame<GameWorld> with KeyboardEvents {
  MainGame() : super(world: GameWorld());

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 255, 255, 255);
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const double moveSpeed = 55.0;
    Vector2 velocity = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = moveSpeed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -moveSpeed;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      velocity.y = -moveSpeed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      velocity.y = moveSpeed;
    }

    // Move the player based on arrow key input
    world.player.move(velocity);

    // Check for spacebar to shoot missiles
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      world.player.shoot(); // Call the shoot method from the player
      return KeyEventResult.handled;
    }

    if (event is KeyUpEvent && keysPressed.isEmpty) {
      world.player
          .move(Vector2.zero()); // Stop movement when no keys are pressed
    }

    return KeyEventResult.ignored;
  }
}
