import 'package:flutter/material.dart';

class ScoreContainer extends StatelessWidget {
  final int score;
  final String description;

  const ScoreContainer({super.key, required this.score, required this.description});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth = screenWidth * 0.3; // 30% de la largeur de l'écran

    return Column(
      children: [
        Container(
          width: containerWidth,
          padding: const EdgeInsets.symmetric(vertical: 10), // Ajoutez un padding
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$score',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
