import 'package:flutter/material.dart';
import 'package:game2048/base/engine/game_engine.dart';
import 'package:game2048/base/elements/score_display.widget.dart';
import 'package:game2048/base/elements/action_button.widget.dart';
import 'package:game2048/base/elements/game_grid.widget.dart';
import 'package:game2048/base/elements/score_container.widget.dart';
import 'package:game2048/base/elements/gesture_swipe_detector.widget.dart';
import 'package:game2048/base/directions/gesture_directions.dart';
import 'package:game2048/base/interface/victoryscreen.dart';
import 'package:game2048/base/interface/defeatscreen.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.color = const Color(0xFFFFE306),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int bestScore = 0;
  List<List<int>> currentGrid = [];

  void handleGameWhileSwipingAndUpdateGrid(GameEngine game, GestureDirection swipe) {
    game.play(swipe);
    setState(() {
      currentGrid = game.grid;
      if (game.score >= bestScore) {
        bestScore = game.score;
        localStorage.setItem('bestScore', bestScore.toString());
      }
    });

    if (game.isGameWon == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const VictoryScreen(), 
      ));
    } else if (game.isGameWon == 1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const GameOverPage(), 
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    final bestScoreStr = localStorage.getItem('bestScore');
    bestScore = bestScoreStr != null ? int.parse(bestScoreStr) : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048', style: TextStyle(fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Consumer<GameEngine>(builder: (context, gameEngine, child) {
        return GestureSwipeDetector(
          onSwipeLeft: () {
            handleGameWhileSwipingAndUpdateGrid(gameEngine, GestureDirection.swipeLeft);
          },
          onSwipeRight: () {
            handleGameWhileSwipingAndUpdateGrid(gameEngine, GestureDirection.swipeRight);
          },
          onSwipeUp: () {
            handleGameWhileSwipingAndUpdateGrid(gameEngine, GestureDirection.swipeUp);
          },
          onSwipeDown: () {
            handleGameWhileSwipingAndUpdateGrid(gameEngine, GestureDirection.swipeDown);
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ScoreDisplay(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ScoreContainer(score: bestScore, description: 'Best Score'),
                ),
              ),
              Center(
                child: GameGrid(grid: gameEngine.grid),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: ActionButton(
                    title: "RESTART",
                    onPressed: () {
                      gameEngine.initGridState();
                      setState(() {
                        currentGrid = gameEngine.grid;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
