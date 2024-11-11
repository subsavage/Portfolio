// import 'package:flutter/material.dart';

// class GameOverMenu extends StatelessWidget {
//   const GameOverMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Game Over",
//             style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               // You can trigger a game reset or restart logic here
//               Navigator.pop(context);  // Close the game over screen
//             },
//             child: const Text('Restart Game'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/game.dart';

class GameOverMenu extends Component with HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    add(TextComponent(
        text: "Game Over",
        anchor: Anchor.center,
        position: gameRef.size / 2,
        textRenderer: TextPaint(
            style: const TextStyle(
          fontSize: 150,
          color: Colors.red,
        ))));
  }
}
