import 'package:flutter/material.dart';

//for section two
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
  TextEditingController townController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController grossSalaryController = TextEditingController();
  TextEditingController netSalaryController = TextEditingController();
  TextEditingController salaryScaleController = TextEditingController();
  TextEditingController retirementYearController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController yearsInEmploymentController = TextEditingController();
  String employmentType = '';
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otherNamesController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController currentNetSalaryController = TextEditingController();
  TextEditingController temperoryexpirydate = TextEditingController();
  TextEditingController preferredYearOfRetirementController =
      TextEditingController();

  // Add more controllers as needed for additional fields

  // Function to dispose of controllers when they are no longer needed
  void dispose() {
    expiryDateController.dispose();
    jobTitleController.dispose();
    ministryController.dispose();
    temperoryexpirydate.dispose();
    physicalAddressControllernextofkin.dispose();
    physicalAddressControlleremployment.dispose();
    postalAddressControllerEmployment.dispose();
    postalAddressControllerforKline.dispose();
    townController.dispose();
    provinceController.dispose();
    grossSalaryController.dispose();
    netSalaryController.dispose();
    salaryScaleController.dispose();
    retirementYearController.dispose();
    employeeNumberController.dispose();
    yearsInEmploymentController.dispose();

    nameController.dispose();
    otherNamesController.dispose();
    cellNumberController.dispose();
    emailAddressController.dispose();

    currentNetSalaryController.dispose();
    preferredYearOfRetirementController.dispose();

    // Dispose of additional controllers as needed
  }
}
