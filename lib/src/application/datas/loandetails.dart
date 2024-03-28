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
  dynamic productid;
  List<int> chosenProductIds = [];
  List<int> quantity = [];
  List<String> chosenProductNames = [];
  double? totalcost = 0;
  List<double> chosenProductPrice = [];
  String? loancategory;

  TextEditingController bankname = TextEditingController();
  TextEditingController branchname = TextEditingController();
  TextEditingController sortcode = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController nameandbankaddress = TextEditingController();

  void dispose() {
    descriptionController.dispose();
    costofasset.dispose();
    insurancecost.dispose();
    advancepayment.dispose();
    loanamaountapplied.dispose();
    bankname.dispose();
    branchname.dispose();
    sortcode.dispose();
    accountnumber.dispose();
    nameandbankaddress.dispose();
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
