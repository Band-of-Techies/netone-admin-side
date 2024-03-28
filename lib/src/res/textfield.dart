import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final String? prefix;

  const FormTextField({
    required this.controller,
    this.prefix = '',
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixText: prefix,
        labelText: labelText,
        labelStyle: GoogleFonts.dmSans(
          color: AppColors.neutral,
          height: 0.5,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.neutral, width: 1.0),
        ),
      ),
      style: GoogleFonts.dmSans(
        color: AppColors.neutral,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
    );
  }
}
