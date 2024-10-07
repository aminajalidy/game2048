import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String content;
  final double size;
  final FontWeight weight;

  const StyledText({
    super.key,
    required this.content,
    required this.size,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
