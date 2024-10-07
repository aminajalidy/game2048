import 'package:flutter/material.dart';
import 'package:game2048/base/engine/game_engine.dart'; // Assurez-vous que c'est le bon chemin
import 'package:game2048/base/elements/score_container.widget.dart'; // Assurez-vous que c'est le bon chemin
import 'package:provider/provider.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameEngine>( // Changement de GameModel à GameEngine
      builder: (context, gameEngine, child) => 
          ScoreContainer(score: gameEngine.score, description: 'Score'), // Utilisez ScoreContainer
    );
  }
}
