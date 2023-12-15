import 'package:flutter/material.dart';

class EmployemntandKlinDetails {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController ministryController = TextEditingController();
  TextEditingController physicalAddressControlleremployment =
      TextEditingController();
  TextEditingController physicalAddressControllernextofkin =
      TextEditingController();
  TextEditingController postalAddressControllerEmployment =
      TextEditingController();
  TextEditingController postalAddressControllerforKline =
      TextEditingController();
  String? townController;
  String? provinceController;
  TextEditingController grossSalaryController = TextEditingController();
  TextEditingController netSalaryController = TextEditingController();
  String? salaryScaleController;
  TextEditingController retirementYearController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  String? yearsInEmploymentController;
  String employmentType = '';
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otherNamesController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController currentNetSalaryController = TextEditingController();
  TextEditingController temperoryexpirydate = TextEditingController();
  String? preferredYearOfRetirementController;

  void dispose() {
    jobTitleController.dispose();
    ministryController.dispose();
    physicalAddressControlleremployment.dispose();
    physicalAddressControllernextofkin.dispose();
    postalAddressControllerEmployment.dispose();
    postalAddressControllerforKline.dispose();

    grossSalaryController.dispose();
    netSalaryController.dispose();

    retirementYearController.dispose();
    employeeNumberController.dispose();

    expiryDateController.dispose();
    nameController.dispose();
    otherNamesController.dispose();
    cellNumberController.dispose();
    emailAddressController.dispose();
    currentNetSalaryController.dispose();
    temperoryexpirydate.dispose();
  }
}
