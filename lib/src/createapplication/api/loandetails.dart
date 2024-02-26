import 'package:flutter/material.dart';

class LoanDetails {
  int? selectedLoanOption;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costofasset = TextEditingController();
  TextEditingController insurancecost = TextEditingController();
  TextEditingController advancepayment = TextEditingController();
  TextEditingController loanamaountapplied = TextEditingController();
  String? tenure;
  TextEditingController firstapplicantproportion = TextEditingController();
  TextEditingController secondapplicantpropotion = TextEditingController();
  TextEditingController thirdapplicantpropotion = TextEditingController();
  TextEditingController fourthapplicantpropotion = TextEditingController();
  TextEditingController firstapplicant = TextEditingController();
  TextEditingController secondapplicant = TextEditingController();
  TextEditingController thirdapplicant = TextEditingController();
  TextEditingController fourthapplicant = TextEditingController();

  void dispose() {
    descriptionController.dispose();
    costofasset.dispose();
    insurancecost.dispose();
    advancepayment.dispose();
    loanamaountapplied.dispose();

    firstapplicantproportion.dispose();
    secondapplicantpropotion.dispose();
    thirdapplicantpropotion.dispose();
    fourthapplicantpropotion.dispose();
    firstapplicant.dispose();
    secondapplicant.dispose();
    thirdapplicant.dispose();
    fourthapplicant.dispose();
  }
}
