import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final game = MainGame();
    return Scaffold(
        body: GameWidget(
      game: game,
    ));
  }
}
