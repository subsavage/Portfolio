import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:portfolio/pages/game.dart';
import 'package:portfolio/sprites/enemy.dart';
import 'package:portfolio/sprites/player.dart';

class GameWorld extends World with HasGameRef<MainGame> {
  late final Player player;

  Timer interval = Timer(6, repeat: true);

  @override
  Future<void> onLoad() async {
    player = Player();
    await super.onLoad();

    final parallax = await ParallaxComponent.load(
      [ParallaxImageData('bg.png')],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0),
    );

    parallax.position = Vector2(0, 0);
    parallax.size = gameRef.size;
    parallax.anchor = Anchor.center;

    add(parallax);

    interval.onTick = () => add(Enemy());

    add(player);
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }
}
