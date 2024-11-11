import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:portfolio/pages/game.dart';

class Enemy extends SpriteAnimationComponent with HasGameReference<MainGame> {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );

  static const enemySize = 100.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy_1.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: .2,
        textureSize: Vector2.all(256),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }
}
