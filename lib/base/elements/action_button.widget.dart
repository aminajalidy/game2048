import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 0.4;
    double buttonHeight = screenHeight * 0.07;
    double fontSize = screenWidth * 0.05;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth, buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    );
  }
}
