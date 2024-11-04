import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class Missile extends SpriteComponent {
  Vector2 velocity = Vector2.zero();
  double speed = 300;

  Missile(Vector2 position) : super(size: Vector2(32, 16), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('missile.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(velocity * dt);
  }

  void shoot(Vector2 initialPosition, Vector2 direction) {
    position = initialPosition;
    velocity = direction.normalized() * speed;
  }
}
