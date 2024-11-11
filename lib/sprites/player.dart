import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/game.dart';
import 'package:portfolio/pages/missile.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  Vector2 velocity = Vector2.zero();
  final List<Missile> missiles = [];

  Player() : super(size: Vector2(128, 128), anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await _loadIdleAnimation();
    debugMode = true;

    position = Vector2(0, gameRef.size.y / 4);

    add(RectangleHitbox());
  }

  Future<SpriteAnimation> _loadIdleAnimation() async {
    final idleSpriteSheet = await Flame.images.load('ship.png');
    return SpriteAnimation.fromFrameData(
      idleSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(512, 512),
        stepTime: 0.1,
        loop: true,
      ),
    );
  }

  Future<SpriteAnimation> _loadRunAnimation() async {
    final runSpriteSheet = await Flame.images.load('ship.png');
    return SpriteAnimation.fromFrameData(
      runSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(512, 512),
        stepTime: 0.1,
        loop: true,
      ),
    );
  }

  void move(Vector2 newVelocity) async {
    velocity = newVelocity;
    if (newVelocity != Vector2.zero()) {
      animation = await _loadRunAnimation();
    } else {
      animation = await _loadIdleAnimation();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(velocity * dt);
  }

  void shoot() {
    final leftMissilePosition = position + Vector2(size.x / 4, 0);
    final leftMissile = Missile(leftMissilePosition);
    leftMissile.shoot(leftMissile.position, Vector2(1, 0));
    missiles.add(leftMissile);
    add(leftMissile);

    final rightMissilePosition = position + Vector2(size.x / 4, 100);
    final rightMissile = Missile(rightMissilePosition);
    rightMissile.shoot(rightMissile.position, Vector2(1, 0));
    missiles.add(rightMissile);
    add(rightMissile);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.gameOver = true;
    super.onCollisionStart(intersectionPoints, other);
  }
}
