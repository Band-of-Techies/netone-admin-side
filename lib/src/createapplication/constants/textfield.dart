import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool? isEnabled;
  final String? prefix;

  const CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.prefix = '',
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      decoration: InputDecoration(
        prefixText: prefix,
        labelText: labelText,
        labelStyle: GoogleFonts.dmSans(
          color: Colors.black,
          height: 0.5,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: GoogleFonts.dmSans(
          color: Colors.red,
          height: 0.5,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primary, width: 1.0),
        ),
      ),
      style: GoogleFonts.dmSans(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
    );
  }
}
