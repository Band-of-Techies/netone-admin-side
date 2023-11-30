import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimensions.dart';

class AppStyles {
  static var addressBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: AppColors.background),
  );
  static var underLineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  static var focusedTransparentBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: Colors.transparent),
  );
  static var energyBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: Colors.transparent),
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: AppColors.background, width: 0.3),
  );
  static var focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: AppColors.primary, width: 0.3),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius),
    borderSide: const BorderSide(color: AppColors.secondary),
  );
}

errorTextStyle(context) => TextStyle(
    fontSize: 10,
    color: Theme.of(context).errorColor,
    fontWeight: FontWeight.w500,
    height: 1.4);

class CustomText extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;

  const CustomText({
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.color = AppColors.neutral,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
