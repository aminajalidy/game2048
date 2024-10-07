import 'package:flutter/material.dart';
import 'package:game2048/base/engine/game_engine.dart'; 
import 'package:game2048/base/elements/styled_text.widget.dart';
import 'package:game2048/base/elements/score_container.widget.dart'; 
import 'package:provider/provider.dart';

class GameOverScreen extends StatelessWidget {
  final String imageUrl;
  final String gameOverMessage;

  const GameOverScreen({
    super.key,
    required this.imageUrl,
    required this.gameOverMessage,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<GameEngine>( 
      builder: (context, GameEngine gameEngine, child) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: StyledText(
                content: gameOverMessage,
                size: 35.0,
                weight: FontWeight.bold,
              ),
            ),
            ScoreContainer(score: gameEngine.score, description: "Your Score"), 
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Image.network(
                imageUrl,
                height: screenHeight * 0.3,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
