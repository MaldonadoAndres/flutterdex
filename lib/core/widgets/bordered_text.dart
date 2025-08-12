import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  const BorderedText({super.key, required this.text, this.fontSize = 14});
  final double fontSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Border
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = Colors.black,
          ),
        ),
        // Fill
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
