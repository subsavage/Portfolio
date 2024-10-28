import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends SpriteComponent {
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("player.png");
    size = Vector2(200, 100);
    position = Vector2(0, 0);
    anchor = Anchor.center;
  }

  void move(double speed) {
    position.add(Vector2(speed, 0));
  }
}
