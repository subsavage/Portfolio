import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class Player extends SpriteAnimationComponent {
  Vector2 velocity = Vector2.zero();

  Player()
      : super(
            size: Vector2(128, 128),
            anchor: Anchor.bottomCenter); // Set the size to avoid stretching

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await _loadIdleAnimation(); // Load idle animation first
    debugMode = true; // Enable debug mode to see the bounding box
  }

  Future<SpriteAnimation> _loadIdleAnimation() async {
    final idleSpriteSheet = await Flame.images.load('player_idle.png');

    return SpriteAnimation.fromFrameData(
      idleSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 6, // Number of frames in the idle animation
        textureSize: Vector2(128, 128), // Use frame size for idle animation
        stepTime: 0.1, // Adjust for desired playback speed
        loop: true,
      ),
    );
  }

  Future<SpriteAnimation> _loadRunAnimation() async {
    final runSpriteSheet = await Flame.images.load('player_run.png');

    return SpriteAnimation.fromFrameData(
      runSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 10, // Number of frames in the running animation
        textureSize: Vector2(
            128, 128), // Use consistent frame size for running animation
        stepTime: 0.1, // Adjust for desired playback speed
        loop: true,
      ),
    );
  }

  void move(double speed) async {
    if (speed > 0) {
      velocity.x = speed; // Move right
      animation = await _loadRunAnimation(); // Switch to running animation
    } else {
      velocity.x = 0; // Stop movement
      animation = await _loadIdleAnimation(); // Switch to idle animation
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(velocity * dt); // Update position based on velocity
  }
}
