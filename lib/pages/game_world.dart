import 'dart:async';

import 'package:flame/components.dart';
import 'package:portfolio/pages/game.dart';
import 'package:portfolio/widgets/player.dart';

class GameWorld extends World with HasGameRef<MainGame> {
  late final Player player;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player = Player();
    add(player);
  }
}
