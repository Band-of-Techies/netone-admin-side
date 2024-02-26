import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomText({
    required this.text,
    this.color = Colors.black,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

// Example usage:
// CustomText(
//   text: 'Your Text Here',
//   color: Colors.black,
//   fontSize: 18,
//   fontWeight: FontWeight.bold,
// ),
