import 'package:flutter/material.dart';

class ApplicantDetails {
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

  void dispose() {
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
