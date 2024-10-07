import 'package:flutter/material.dart';
import 'package:game2048/base/elements/game_over.widget.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over', style: TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center( // Centrer le contenu
        child: GameOverScreen(
          imageUrl: "https://media.giphy.com/media/d2lcHJTG5Tscg/giphy.gif",
          gameOverMessage: "🫵 Game Over!  🤪",
        ),
      ),
    );
  }
}
