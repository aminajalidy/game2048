import 'package:flutter/material.dart';
import 'package:game2048/base/elements/game_over.widget.dart'; // Assurez-vous que c'est le bon chemin

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Congratulations!', style: TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center( // Centrer le contenu
        child: GameOverScreen( // Changer le nom de la classe pour GameOverScreen
          imageUrl: "https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExcW82YXMwamE3MTZkeGZtb2ZnNjA4dmo0eHhweXNqNW0xbHQxdHhuYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/JV7GuEriVvMk921YaA/giphy.gif",
          gameOverMessage: "🎉 You Won! 🎊", // Changer le texte pour indiquer que le joueur a gagné
        ),
      ),
    );
  }
}
