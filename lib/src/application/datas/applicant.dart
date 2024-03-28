import 'dart:typed_data';

import 'package:flutter/material.dart';

class ApplicantDetails {
  dynamic? applicantid;
  TextEditingController surnameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nrcController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController licenseExpiryController = TextEditingController();
  TextEditingController residentialAddressController = TextEditingController();
  TextEditingController postalAddressController = TextEditingController();
  TextEditingController howlongthisplaceController = TextEditingController();
  String? townController;
  String? provinceController;
  String? gender;
  String? ownership;
  String? selectedtown;
  String? selectedprovince;
  List<Uint8List> selectedFiles = [];
  List<String> selectedFilesnames = [];
  List<Uint8List> signature = [];
  List<String> signatureName = [];

  List<Uint8List> paysliponeFiles = [];
  List<String> paysliponeFileNames = [];

  List<Uint8List> paysliptwoFiles = [];
  List<String> paysliptwoFileNames = [];

  List<Uint8List> payslipthreeFiles = [];
  List<String> payslipthreeFileNames = [];

  List<Uint8List> intodletterFiles = [];
  List<String> introletterFileNames = [];

  List<Uint8List> bankStatementFiles = [];
  List<String> bankStatementFileNames = [];

  List<Uint8List> nrcFiles = [];
  List<String> nrcFileNames = [];
  TextEditingController loanapplicantname = TextEditingController();
  TextEditingController loanapplicantpercentage = TextEditingController();
  void dispose() {
    loanapplicantname.dispose();
    loanapplicantpercentage.dispose();
    surnameController.dispose();
    middleNameController.dispose();
    firstNameController.dispose();
    dobController.dispose();
    nrcController.dispose();
    telephoneController.dispose();
    mobileController.dispose();
    emailController.dispose();
    licenseNumberController.dispose();
    licenseExpiryController.dispose();
    residentialAddressController.dispose();
    postalAddressController.dispose();
    howlongthisplaceController.dispose();
  }
}
