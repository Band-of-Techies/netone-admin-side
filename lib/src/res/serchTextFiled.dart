import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String labeltext;
  const CustomTextFormField({
    required this.controller,
    required this.labeltext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: TextFormField(
        onEditingComplete: onSubmit,
        controller: controller,
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: GoogleFonts.dmSans(
            color: AppColors.neutral,
            height: 0.3,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: AppColors.neutral, width: .40),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.primary, width: 0.4),
          ),
        ),
        style: GoogleFonts.dmSans(
          color: AppColors.neutral,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class SearchTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onsubmit;
  final String labeltext;
  const SearchTextFormField({
    required this.controller,
    required this.labeltext,
    required this.onsubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: TextFormField(
        onEditingComplete: onsubmit,
        controller: controller,
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: GoogleFonts.dmSans(
            color: AppColors.neutral,
            height: 0.3,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: AppColors.neutral, width: .40),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.primary, width: 0.4),
          ),
        ),
        style: GoogleFonts.dmSans(
          color: AppColors.neutral,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
