import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class Player extends SpriteAnimationComponent {
  Vector2 velocity = Vector2.zero();

  Player() : super(size: Vector2(128, 128), anchor: Anchor.bottomCenter);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await _loadIdleAnimation();
    debugMode = true;
  }

  Future<SpriteAnimation> _loadIdleAnimation() async {
    final idleSpriteSheet = await Flame.images.load('player_idle.png');

    return SpriteAnimation.fromFrameData(
      idleSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(128, 128),
        stepTime: 0.1,
        loop: true,
      ),
    );
  }

  Future<SpriteAnimation> _loadRunAnimation() async {
    final runSpriteSheet = await Flame.images.load('player_run.png');

    return SpriteAnimation.fromFrameData(
      runSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 10,
        textureSize: Vector2(128, 128),
        stepTime: 0.1,
        loop: true,
      ),
    );
  }

  void move(double speed) async {
    if (speed > 0) {
      velocity.x = speed; // Move right
      animation = await _loadRunAnimation();
    } else {
      velocity.x = 0; // Stop movement
      animation = await _loadIdleAnimation();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(velocity * dt);
  }
}
